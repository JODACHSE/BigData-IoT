from sqlalchemy import text
import pandas as pd
import plotly.express as px

# 📶 Gráfico 1: Estado general de la red WiFi
def graph_estado_wifi(engine, filtros=None):
    filtros = filtros or {}
    fecha_inicio = filtros.get("fechaInicio")
    fecha_fin = filtros.get("fechaFin")

    q = text("""
        SELECT 
            CASE 
                WHEN f.VelocidadBajada < 5 THEN 'Lenta'
                WHEN f.VelocidadBajada BETWEEN 5 AND 20 THEN 'Media'
                ELSE 'Rápida'
            END AS Estado,
            COUNT(*) AS Cantidad
        FROM Hec.FactWiFi f
        JOIN Dim.Tiempo t ON f.IdTiempo = t.IdTiempo
        WHERE (:fecha_inicio IS NULL OR t.FechaCompleta >= :fecha_inicio)
          AND (:fecha_fin IS NULL OR t.FechaCompleta <= :fecha_fin)
        GROUP BY 
            CASE 
                WHEN f.VelocidadBajada < 5 THEN 'Lenta'
                WHEN f.VelocidadBajada BETWEEN 5 AND 20 THEN 'Media'
                ELSE 'Rápida'
            END
    """)

    df = pd.read_sql(q, engine, params={
        "fecha_inicio": fecha_inicio,
        "fecha_fin": fecha_fin
    })

    if df.empty:
        return px.bar(title="Sin datos de estado de red WiFi")

    fig = px.pie(df, names="Estado", values="Cantidad", title="Estado general de la red WiFi")
    return fig


# 📈 Gráfico 2: Velocidad promedio de subida y bajada
def graph_velocidad_promedio(engine, filtros=None):
    filtros = filtros or {}
    fecha_inicio = filtros.get("fechaInicio")
    fecha_fin = filtros.get("fechaFin")

    q = text("""
        SELECT 
            AVG(f.VelocidadSubida) AS Subida,
            AVG(f.VelocidadBajada) AS Bajada
        FROM Hec.FactWiFi f
        JOIN Dim.Tiempo t ON f.IdTiempo = t.IdTiempo
        WHERE (:fecha_inicio IS NULL OR t.FechaCompleta >= :fecha_inicio)
          AND (:fecha_fin IS NULL OR t.FechaCompleta <= :fecha_fin)
    """)

    df = pd.read_sql(q, engine, params={
        "fecha_inicio": fecha_inicio,
        "fecha_fin": fecha_fin
    })

    if df.empty:
        return px.bar(title="Sin datos de velocidad WiFi")
    
    df = df.melt(var_name="Tipo", value_name="Velocidad")
    fig = px.bar(df, x="Tipo", y="Velocidad", title="Velocidad promedio WiFi (Mbps)")
    return fig
