from flask import Flask, render_template, request
from db import execute_select

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("pages/home.html")

@app.route("/Planteamiento")
def planteamiento():
    return render_template("pages/planteamiento.html")

@app.route("/ETL")
def ETL():
    return render_template("pages/etl.html", query=None, columns=None, rows=None, error=None)

@app.route("/ETL/query", methods=["POST"]) 
def etl_query():
    query = request.form.get("query", "").strip()
    columns = rows = None
    error = None
    try:
        if not query:
            error = "Ingresa una consulta SELECT."
        else:
            columns, rows = execute_select(query)
    except ValueError as ve:
        error = str(ve)
    except Exception as e:
        error = f"Error al ejecutar la consulta: {e}"

    return render_template("pages/etl.html", query=query, columns=columns, rows=rows, error=error)

@app.route("/PowerBi")
def PowerBi():
    return render_template("pages/power-bi.html")

@app.route("/Contacto")
def Contacto():
    return render_template("pages/contacto.html")

if __name__ == "__main__":
    app.run(debug=True)