from sqlalchemy import text
import pandas as pd
import plotly.express as px

def graph_consumo(engine, filtros=None):
    filtros = filtros or {}
    fecha_inicio = filtros.get("fechaInicio")
    fecha_fin = filtros.get("fechaFin")

    q = text("""
        SELECT 
            t.Anio,
            t.Mes,
            SUM(f.Consumo) AS Consumo
        FROM Hec.FactLuminaria f
        JOIN Dim.Tiempo t ON f.IdTiempo = t.IdTiempo
        WHERE (:fecha_inicio IS NULL OR t.FechaCompleta >= :fecha_inicio)
          AND (:fecha_fin IS NULL OR t.FechaCompleta <= :fecha_fin)
        GROUP BY t.Anio, t.Mes
        ORDER BY t.Anio, t.Mes
    """)

    df = pd.read_sql(q, engine, params={
        "fecha_inicio": fecha_inicio,
        "fecha_fin": fecha_fin
    })

    if df.empty:
        return px.bar(title="Sin datos de consumo energético")

    df["Periodo"] = df["Anio"].astype(str) + "-" + df["Mes"].astype(str)
    fig = px.bar(df, x="Periodo", y="Consumo", title="Consumo energético mensual")
    return fig
