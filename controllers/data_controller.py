from dashboards.energia_dashboard import graph_consumo
from dashboards.wifi_dashboard import graph_estado_wifi, graph_velocidad_promedio
from dashboards.luminarias_dashboard import graph_estado_luminarias, graph_luminiscencia
from dashboards.mantenimiento_dashboard import graph_fallas
from dashboards.ambiente_dashboard import graph_ambiente

def get_all_graphs(conn_dw, conn_mer, filtros=None):
    """
    Genera las gráficas aplicando filtros si se proporcionan
    """
    filtros = filtros or {}
    return {
        "consumo": graph_consumo(conn_dw, filtros).to_html(full_html=False),
        "wifi_velocidad": graph_velocidad_promedio(conn_dw, filtros).to_html(full_html=False),
        "ambiente": graph_ambiente(conn_dw, filtros).to_html(full_html=False),
        "wifi_estado": graph_estado_wifi(conn_dw, filtros).to_html(full_html=False),
        "luminarias_estado": graph_estado_luminarias(conn_dw, filtros).to_html(full_html=False),
        "luminarias_luz": graph_luminiscencia(conn_mer, filtros).to_html(full_html=False),
        "fallas": graph_fallas(conn_mer, filtros).to_html(full_html=False),
    }
