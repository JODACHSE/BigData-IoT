import os
from flask import Flask, render_template, request, current_app
from dotenv import load_dotenv
from db import execute_select
from email_service import send_email
import smtplib

load_dotenv()

app = Flask(__name__)
secret = os.getenv("SECRET_KEY")
if not secret:
    raise RuntimeError("SECRET_KEY no está definido en variables de entorno")
app.secret_key = secret

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
    return render_template("pages/contacto.html", success=None, error=None)

@app.route("/Contacto/enviar", methods=["POST"])
def send_contact():
    nombre = request.form.get("nombre", "").strip()
    email = request.form.get("email", "").strip()
    asunto = request.form.get("asunto", "").strip()
    mensaje = request.form.get("mensaje", "").strip()

    error = success = None
    try:
        if not (nombre and email and asunto and mensaje):
            error = "Por favor completa todos los campos."
        else:
            current_app.logger.info(f"Intentando enviar correo de '{email}' con asunto '{asunto}'")
            send_email(nombre, email, asunto, mensaje)
            success = "Tu mensaje fue enviado correctamente. ¡Gracias por contactarnos!"
    except ValueError as ve:
        error = str(ve)
    except smtplib.SMTPAuthenticationError:
        error = "Autenticación SMTP fallida. Verifica EMAIL_USER y EMAIL_PASS (App Password)."
    except (smtplib.SMTPConnectError, smtplib.SMTPServerDisconnected, smtplib.SMTPDataError) as e:
        error = f"Fallo de conexión/entrega SMTP: {e}"
    except Exception as e:
        current_app.logger.exception("Error inesperado al enviar correo")
        error = f"No se pudo enviar el correo: {e}"

    return render_template("pages/contacto.html", success=success, error=error), 200

if __name__ == "__main__":
    app.run(debug=True)