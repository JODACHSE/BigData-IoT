# Universidad de Cundinamarca - Chía - Big Data 701N
# Pregrado en Ingeniería de Sistemas y Computación

# Comandos utiles para consola:
# 1. pip install -r requirements.txt

# Librerias
from flask import Flask, render_template, jsonify
import os
from dotenv import load_dotenv
import pyodbc
import pandas as pd
from sqlalchemy import create_engine, text
import urllib

from controllers.data_controller import get_all_graphs

# Incializar la app (o sitio web)
app = Flask(__name__)

# Cargar variables de entorno
load_dotenv()

# Obtener el driver desde .env
DRIVER = os.getenv("SQLSERVER_DRIVER", "ODBC Driver 18 for SQL Server")

def get_engine_dw():
    params = urllib.parse.quote_plus(
        f"DRIVER={{ODBC Driver 18 for SQL Server}};"
        f"SERVER={os.getenv('SQLSERVER_SERVER')};"
        f"DATABASE=CiudadInteligenteDW;"   # <- esta base debe tener Hec.Medicion
        f"Trusted_Connection=yes;"
        f"Encrypt=no;"
        f"TrustServerCertificate=yes;"
    )
    return create_engine(f"mssql+pyodbc:///?odbc_connect={params}")

# Conexión a tu BD CiudadInteligenteMER
def get_engine_mer():
    return create_engine("mssql+pyodbc://localhost/CiudadInteligenteMER?driver=ODBC+Driver+17+for+SQL+Server")


@app.route('/')
def home():
    return render_template('pages/home.html')


@app.route("/dashboard")
def dashboard_page():
    # Pasa ambas conexiones al controlador usando los engines de SQLAlchemy
    graphs = get_all_graphs(get_engine_dw(), get_engine_mer())
    return render_template("pages/dev/data.html", graphs=graphs)


# Países
@app.route("/api/paises")
def get_paises():
    sql = text("SELECT Nombre FROM Geo.Pais ORDER BY Nombre")
    with get_engine_mer().connect() as conn:
        df = pd.read_sql(sql, conn)
    return jsonify(df['Nombre'].tolist())

@app.route("/api/departamentos/<pais>")
def get_departamentos(pais):
    sql = text("""
        SELECT d.Nombre
        FROM Geo.Departamento d
        JOIN Geo.Pais p ON d.IdPais = p.IdPais
        WHERE p.Nombre = :pais
        ORDER BY d.Nombre
    """)
    with get_engine_mer().connect() as conn:
        df = pd.read_sql(sql, conn, params={"pais": pais})
    return jsonify(df['Nombre'].tolist())

@app.route("/api/municipios/<departamento>")
def get_municipios(departamento):
    sql = text("""
        SELECT m.Nombre
        FROM Geo.Municipio m
        JOIN Geo.Departamento d ON m.IdDepartamento = d.IdDepartamento
        WHERE d.Nombre = :departamento
        ORDER BY m.Nombre
    """)
    with get_engine_mer().connect() as conn:
        df = pd.read_sql(sql, conn, params={"departamento": departamento})
    return jsonify(df['Nombre'].tolist())

@app.route("/api/barrios/<municipio>")
def get_barrios(municipio):
    sql = text("""
        SELECT b.Nombre
        FROM Geo.Barrio b
        JOIN Geo.Municipio m ON b.IdMunicipio = m.IdMunicipio
        WHERE m.Nombre = :municipio
        ORDER BY b.Nombre
    """)
    with get_engine_mer().connect() as conn:
        df = pd.read_sql(sql, conn, params={"municipio": municipio})
    return jsonify(df['Nombre'].tolist())

@app.route("/api/filtrar", methods=["POST"])
def aplicar_filtros():
    from controllers.data_controller import get_all_graphs

    filtros = request.json
    pais = filtros.get("pais")
    depto = filtros.get("departamento")
    muni = filtros.get("municipio")
    barrio = filtros.get("barrio")
    fecha_inicio = filtros.get("fechaInicio")
    fecha_fin = filtros.get("fechaFin")

    graphs = get_all_graphs(get_engine_dw(), get_engine_mer())

    # Aquí podrías pasar los filtros a las funciones si tus dashboards los aceptan.
    # Ejemplo: graph_consumo(conn_dw, fecha_inicio, fecha_fin, municipio)

    return jsonify({
        "consumo": graphs["consumo"],
        "wifi_estado": graphs["wifi_estado"],
        "wifi_velocidad": graphs["wifi_velocidad"],
        "luminarias_estado": graphs["luminarias_estado"],
        "luminarias_luz": graphs["luminarias_luz"],
        "fallas": graphs["fallas"],
        "ambiente": graphs["ambiente"]
    })


# Ejecutar el app en modo debug
if __name__ == '__main__':
    app.run(debug=True)
