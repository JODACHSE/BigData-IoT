from sqlalchemy import text
import pandas as pd
import plotly.express as px

def graph_ambiente(engine, filtros=None):
    filtros = filtros or {}
    fecha_inicio = filtros.get("fechaInicio")
    fecha_fin = filtros.get("fechaFin")

    q = text("""
        SELECT 
            AVG(f.Temperatura) AS TemperaturaPromedio,
            AVG(f.Luminiscencia) AS LuminiscenciaPromedio
        FROM Hec.FactLuminaria f
        JOIN Dim.Tiempo t ON f.IdTiempo = t.IdTiempo
        WHERE (f.Temperatura IS NOT NULL OR f.Luminiscencia IS NOT NULL)
          AND (:fecha_inicio IS NULL OR t.FechaCompleta >= :fecha_inicio)
          AND (:fecha_fin IS NULL OR t.FechaCompleta <= :fecha_fin)
    """)

    df = pd.read_sql(q, engine, params={
        "fecha_inicio": fecha_inicio,
        "fecha_fin": fecha_fin
    })

    if df.empty:
        return px.bar(title="Sin datos ambientales")

    df = df.melt(var_name="Indicador", value_name="Valor")
    fig = px.bar(df, x="Indicador", y="Valor", title="Indicadores Ambientales Promedio")
    return fig
