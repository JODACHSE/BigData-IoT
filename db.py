import os
import re
import pyodbc
from typing import List, Tuple, Any

try:
    from dotenv import load_dotenv
    load_dotenv()
except Exception:
    # dotenv is optional at runtime; continue if not present
    pass


def _env(name: str, default: str | None = None) -> str:
    value = os.getenv(name, default)
    if value is None:
        raise RuntimeError(f"Falta variable de entorno requerida: {name}")
    return value


def get_connection() -> pyodbc.Connection:
    """Crea y retorna una conexión ODBC a SQL Server en somee.com.

    Variables de entorno requeridas: revisar .env.example
    """
    server = _env("SOMEE_SQL_SERVER")
    database = _env("SOMEE_SQL_DATABASE")
    user = _env("SOMEE_SQL_USER")
    password = _env("SOMEE_SQL_PASSWORD")
    # Permite usar una cadena completa desde .env si está definida
    conn_string_env = os.getenv("SOMEE_SQL_CONNECTION_STRING", "").strip()
    if conn_string_env:
        conn_str = conn_string_env
    else:
        driver = os.getenv("ODBC_DRIVER", "ODBC Driver 17 for SQL Server").strip()
        # Importante: llaves simples alrededor del nombre del driver
        conn_str = (
            f"DRIVER={{{driver}}};"
            f"SERVER={server};"
            f"DATABASE={database};"
            f"UID={user};"
            f"PWD={password};"
            "Encrypt=yes;"
            "TrustServerCertificate=yes;"
            "Connection Timeout=15;"
        )

    # autocommit deshabilitado por defecto para evitar cambios accidentales
    return pyodbc.connect(conn_str, autocommit=False)


_FORBIDDEN = (
    r"\bALTER\b",
    r"\bCREATE\b",
    r"\bDELETE\b",
    r"\bDROP\b",
    r"\bEXEC\b",
    r"\bINSERT\b",
    r"\bMERGE\b",
    r"\bTRUNCATE\b",
    r"\bUPDATE\b",
    r"\bGRANT\b",
    r"\bREVOKE\b",
)


def is_safe_sql(sql: str) -> bool:
    """Valida que la consulta sea solamente SELECT y no contenga palabras peligrosas."""
    q = sql.strip()
    # Permitir únicamente una sentencia y que inicie con SELECT
    if not q.upper().startswith("SELECT"):
        return False
    # Bloquear ; que indique múltiples sentencias
    if ";" in q:
        return False
    for pat in _FORBIDDEN:
        if re.search(pat, q, flags=re.IGNORECASE):
            return False
    return True


def execute_select(sql: str) -> Tuple[List[str], List[Tuple[Any, ...]]]:
    """Ejecuta una consulta SELECT segura y retorna (columnas, filas)."""
    if not is_safe_sql(sql):
        raise ValueError("La consulta no es segura. Solo se permiten instrucciones SELECT.")

    with get_connection() as conn:
        # Asegurar aislamiento de lectura
        try:
            conn.execute("SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED")
        except Exception:
            # Si el servidor no soporta, continuar
            pass
        cur = conn.cursor()
        cur.execute(sql)
        columns = [col[0] for col in cur.description]
        rows = cur.fetchall()
        return columns, [tuple(r) for r in rows]