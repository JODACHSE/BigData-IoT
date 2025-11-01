USE CiudadInteligenteMER;
GO

INSERT INTO Catalogo.TipoCompania
    (Nombre)
VALUES
    ('Proveedor de Servicios Públicos'),
    ('Proveedor de WiFi');
GO

INSERT INTO Catalogo.TipoUsuario
    (Nombre)
VALUES
    ('Administrador'),
    ('Gerente'),
    ('Empleado'),
    ('Ciudadano Común'),
    ('Ciudadano Externo'),
    ('Operador'),
    ('Técnico'),
    ('Supervisor'),
    ('Auditor'),
    ('Invitado');
GO

INSERT INTO Catalogo.TipoRol
    (Nombre)
VALUES
    ('CEO'),
    ('Gerente'),
    ('Administrador'),
    ('Director de Operaciones'),
    ('Director Técnico'),
    ('Ingeniero de Redes'),
    ('Ingeniero Eléctrico'),
    ('Técnico de Campo'),
    ('Técnico de Mantenimiento'),
    ('Operador'),
    ('Supervisor'),
    ('Analista de Datos'),
    ('Analista de Infraestructura'),
    ('Auxiliar Técnico'),
    ('Auxiliar Administrativo'),
    ('Contratista'),
    ('Consultor'),
    ('Especialista en Seguridad'),
    ('Especialista en IoT'),
    ('Especialista en Alumbrado'),
    ('Especialista en Telecomunicaciones'),
    ('Gestor de Proyectos'),
    ('Coordinador de Instalaciones'),
    ('Auditor Interno'),
    ('Auditor Externo');
GO

INSERT INTO Catalogo.TipoDocumento
    (Nombre)
VALUES
    ('Cédula de ciudadanía'),
    ('Tarjeta de identidad'),
    ('Pasaporte'),
    ('Cédula de extranjería'),
    ('NIT'),
    ('Licencia de conducción');
GO

INSERT INTO Catalogo.TipoContacto
    (Nombre)
VALUES
    ('Teléfono'),
    ('Email'),
    ('Fax'),
    ('WhatsApp'),
    ('Dirección'),
    ('Página web');
GO

INSERT INTO Catalogo.TipoConexion
    (Nombre)
VALUES
    ('WiFi'),
    ('Cable'),
    ('4G'),
    ('5G'),
    ('Fibra óptica'),
    ('Satelital');
GO

INSERT INTO Catalogo.EstadoInfraestructura
    (Nombre, Descripcion)
VALUES
    ('Activo', 'Infraestructura operativa y en uso'),
    ('Inactivo', 'Infraestructura instalada pero no operativa'),
    ('En mantenimiento', 'Infraestructura en proceso de reparación'),
    ('Dañado', 'Infraestructura fuera de servicio por daño'),
    ('Pendiente instalación', 'Infraestructura planificada pero no instalada'),
    ('Retirado', 'Infraestructura desinstalada o fuera de operación');
GO

SELECT 'Catalogo.TipoCompania' AS Tabla, COUNT(*) AS TotalRegistros
FROM Catalogo.TipoCompania;

SELECT 'Catalogo.TipoUsuario' AS Tabla, COUNT(*) AS TotalRegistros
FROM Catalogo.TipoUsuario;

SELECT 'Catalogo.TipoRol' AS Tabla, COUNT(*) AS TotalRegistros
FROM Catalogo.TipoRol;

SELECT 'Catalogo.TipoDocumento' AS Tabla, COUNT(*) AS TotalRegistros
FROM Catalogo.TipoDocumento;

SELECT 'Catalogo.TipoContacto' AS Tabla, COUNT(*) AS TotalRegistros
FROM Catalogo.TipoContacto;

SELECT 'Catalogo.TipoConexion' AS Tabla, COUNT(*) AS TotalRegistros
FROM Catalogo.TipoConexion;

SELECT 'Catalogo.EstadoInfraestructura' AS Tabla, COUNT(*) AS TotalRegistros
FROM Catalogo.EstadoInfraestructura;
GO