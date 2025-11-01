from sqlalchemy import text
import pandas as pd
import plotly.express as px

def graph_fallas(engine, filtros=None):
    filtros = filtros or {}
    fecha_inicio = filtros.get("fechaInicio")
    fecha_fin = filtros.get("fechaFin")
    municipio = filtros.get("municipio")

    q = text("""
        SELECT 
            tm.Nombre AS TipoMantenimiento,
            COUNT(f.IdEvento) AS TotalEventos
        FROM Hec.FactMantenimiento f
        JOIN Dim.TipoMantenimiento tm ON f.IdTipoMantenimiento = tm.IdTipoMantenimiento
        JOIN Dim.Dispositivo d ON f.IdDispositivoDW = d.IdDispositivoDW
        JOIN Dim.Ubicacion u ON d.IdUbicacionDW = u.IdUbicacionDW
        JOIN Dim.Tiempo t ON f.IdTiempo = t.IdTiempo
        WHERE (:fecha_inicio IS NULL OR t.Fecha >= :fecha_inicio)
          AND (:fecha_fin IS NULL OR t.Fecha <= :fecha_fin)
          AND (:municipio IS NULL OR u.Municipio = :municipio)
        GROUP BY tm.Nombre
    """)

    params = {
        "fecha_inicio": fecha_inicio,
        "fecha_fin": fecha_fin,
        "municipio": municipio
    }

    df = pd.read_sql(q, engine, params=params)

    if df.empty:
        return px.pie(title="Sin datos de mantenimiento")

    fig = px.pie(df,
                 values="TotalEventos",
                 names="TipoMantenimiento",
                 title="Fallas y Mantenimiento")
    return fig
