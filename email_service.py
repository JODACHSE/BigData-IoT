import os
import smtplib
from email.mime.text import MIMEText


def send_email(nombre: str, from_email: str, asunto: str, mensaje: str) -> None:
    """Envía un correo usando SMTP (Gmail) con los datos del formulario.

    Requiere variables de entorno:
    - EMAIL_HOST (p.ej. smtp.gmail.com)
    - EMAIL_PORT (p.ej. 587)
    - EMAIL_USER (tu cuenta de gmail)
    - EMAIL_PASS (App Password de Gmail)
    - EMAIL_TO   (destinatario final)
    """

    host = os.getenv("EMAIL_HOST", "smtp.gmail.com")
    port = int(os.getenv("EMAIL_PORT", "587"))
    user = os.getenv("EMAIL_USER")
    password = os.getenv("EMAIL_PASS")
    to_email = os.getenv("EMAIL_TO", user)

    if not user or not password:
        raise ValueError("Faltan credenciales de email (EMAIL_USER/EMAIL_PASS).")

    # Construir el contenido del correo
    body = f"""
    Nuevo mensaje de contacto:

    Nombre: {nombre}
    Email: {from_email}
    Asunto: {asunto}

    Mensaje:
    {mensaje}
    """.strip()

    msg = MIMEText(body, _charset="utf-8")
    msg["Subject"] = f"[Contacto] {asunto.strip()}"
    msg["From"] = user
    msg["To"] = to_email or ""

    # Enviar por SMTP con STARTTLS
    with smtplib.SMTP(host, port) as server:
        server.ehlo()
        server.starttls()
        server.login(user, password)
        server.send_message(msg)