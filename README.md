# BigData-IoT

Aplicación web en Flask para visualizar y experimentar con un proyecto de Big Data e IoT orientado a Ciudades Inteligentes. Incluye páginas informativas, un módulo de consultas SQL (ETL) contra SQL Server y un formulario de contacto con envío de correos mediante Gmail.

## Enlace de Visualización
- Producción (Render): https://bigdata-iot.onrender.com

## Tecnologías
- Backend: `Flask`
- Templates: `Jinja2` + `Bootstrap`
- DB: `SQL Server` vía `pyodbc`
- Configuración: `python-dotenv`
- Servidor producción: `gunicorn`
- Despliegue: `Render`

## Estructura del Proyecto
```
BigData-IoT/
├── DB/
│   ├── CiudadInteligenteDW.sql
│   └── CiudadInteligenteMER.sql
├── db.py
├── email_service.py
├── main.py
├── requirements.txt
├── Procfile
├── .env            # no versionado (se crea localmente)
├── .env.example    # ejemplo de variables de entorno
├── static/
│   ├── WololoIcon.png
│   ├── css/styles.css
│   ├── favicon.ico
│   ├── img/
│   │   ├── Ciudades inteligentes.png
│   │   └── devs/
│   │       ├── Andres.jpg
│   │       └── Jonathan.png
│   └── js/main.js
└── templates/
    ├── components/
    │   ├── footer.html
    │   └── navbar.html
    ├── index.html
    └── pages/
        ├── contacto.html
        ├── etl.html
        ├── home.html
        ├── planteamiento.html
        └── power-bi.html
```

## Instalación y Ejecución Local
1. Clona el repositorio:
   ```bash
   git clone https://github.com/JODACHSE/BigData-IoT.git
   cd BigData-IoT
   ```
2. Crea un entorno virtual e instala dependencias:
   ```bash
   python -m venv .venv
   .\.venv\Scripts\activate
   pip install -r requirements.txt
   ```
3. Configura variables de entorno:
   - Copia `.env.example` a `.env` y completa los valores.
   - Variables clave:
     - Conexión a SQL Server (Somee): `SOMEE_SQL_*`, `ODBC_DRIVER`
     - Email (Gmail SMTP): `EMAIL_HOST`, `EMAIL_PORT`, `EMAIL_USER`, `EMAIL_PASS`, `EMAIL_TO`
     - Seguridad Flask: `SECRET_KEY`
   
4. Ejecuta en desarrollo:
   ```bash
   python main.py
   ```
   - Abre `http://127.0.0.1:5000/`
   
### Generar y configurar SECRET_KEY (Flask)
- Genera una clave segura (usa valores diferentes para local y producción):
  ```bash
  python -c "import secrets; print(secrets.token_hex(32))"
  ```
- Copia el resultado en tu `.env` local:
  ```plaintext
  SECRET_KEY=<pega_aqui_el_token_hex_generado>
  ```
- En producción (Render), declara `SECRET_KEY` desde el panel (Environment → Add Environment Variable).
   
Opcional: si quieres que la app falle cuando `SECRET_KEY` no está definido, ajusta en `main.py`:
```python
from dotenv import load_dotenv
import os

load_dotenv()
secret = os.getenv("SECRET_KEY")
if not secret:
    raise RuntimeError("SECRET_KEY no está definido en variables de entorno")
app.secret_key = secret
```
   
### Envío de Correos (Contacto)
- En la página "Contacto" el formulario envía un correo usando Gmail SMTP.
- Requisitos para Gmail:
  - Recomendado: activar verificación en dos pasos y usar una App Password.
  - Variables: `EMAIL_USER` (tu cuenta de Gmail), `EMAIL_PASS` (App Password), `EMAIL_TO` (destino del correo; por ejemplo `jdchavarro@ucundinamarca.edu.co`).
- Al enviar, verás una alerta de éxito o error en la misma página.

## Despliegue en Render
1. Asegúrate de tener `gunicorn` en `requirements.txt` y el `Procfile` con:
   ```
   web: gunicorn main:app
   ```
2. Crea un nuevo Web Service en Render apuntando al repositorio.
3. Start Command (si no usas `Procfile`): `gunicorn main:app`
4. Configura las variables de entorno en Render Dashboard usando los valores de `.env.example`, incluyendo:
   - `SECRET_KEY` (obligatorio y distinto al de local)
   - Credenciales de email (`EMAIL_*`)
   - Conexión SQL (`SOMEE_SQL_*`, `ODBC_DRIVER`)
5. Render construirá e iniciará el servicio. El enlace público debe coincidir con:
   - `https://bigdata-iot.onrender.com`

## Notas
- Para consultas en ETL, introduce únicamente sentencias `SELECT` válidas, el backend las valida y ejecuta contra SQL Server.
- Si usas `pyodbc` con SQL Server en local, asegúrate de tener instalado el `ODBC Driver 17 for SQL Server`.
- No incluyas secretos en el repositorio. Usa `.env` local y variables de entorno en Render.