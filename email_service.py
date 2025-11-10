# función: send_email
import os
import smtplib
from email.mime.text import MIMEText
import ssl


def send_email(nombre: str, from_email: str, asunto: str, mensaje: str) -> None:
    host = os.getenv("EMAIL_HOST", "smtp.gmail.com")
    port = int(os.getenv("EMAIL_PORT", "587"))
    user = os.getenv("EMAIL_USER")
    password = os.getenv("EMAIL_PASS")
    to_email = os.getenv("EMAIL_TO", user)

    if not user or not password:
        raise ValueError("Faltan credenciales de email (EMAIL_USER/EMAIL_PASS).")

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
    msg["Reply-To"] = from_email or user

    context = ssl.create_default_context()

    # Intento 1: STARTTLS en 587 con timeout; si falla, intentar SSL en 465
    try:
        with smtplib.SMTP(host, port, timeout=15) as server:
            server.ehlo()
            server.starttls(context=context)
            server.ehlo()
            server.login(user, password)
            server.send_message(msg)
    except Exception:
        with smtplib.SMTP_SSL(host, 465, context=context, timeout=15) as server:
            server.login(user, password)
            server.send_message(msg)
            print("Email enviado por SSL en 465.")