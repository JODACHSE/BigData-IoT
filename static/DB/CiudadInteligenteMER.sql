USE master;
GO
-- 1. Verificar si existe la BD y eliminarla
IF DB_ID('CiudadInteligenteMER') IS NOT NULL
BEGIN
    ALTER DATABASE CiudadInteligenteMER SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CiudadInteligenteMER;
END;
GO

-- 2. Crear la base de datos
CREATE DATABASE CiudadInteligenteMER;
GO
USE CiudadInteligenteMER;
GO
-- 3. Crear esquemas
CREATE SCHEMA Core; -- Datos principales
GO
CREATE SCHEMA IoT; -- Dispositivos y sensores
GO
CREATE SCHEMA Ops; -- Operaciones (mantenimientos)
GO
CREATE SCHEMA Geo; -- Geografía
GO
CREATE SCHEMA Catalogo; -- Tablas de referencia
GO

/* ===========================
 ESQUEMA GEO
=========================== */
CREATE TABLE Geo.Pais
(
    IdPais INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    CodigoISO3 CHAR(3) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Geo.Departamento
(
    IdDepartamento INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    IdPais INT FOREIGN KEY REFERENCES Geo.Pais(IdPais),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Geo.Municipio
(
    IdMunicipio INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    IdDepartamento INT FOREIGN KEY REFERENCES Geo.Departamento(IdDepartamento),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Geo.Barrio
(
    IdBarrio INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    IdMunicipio INT FOREIGN KEY REFERENCES Geo.Municipio(IdMunicipio),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Geo.TipoZona
(
    IdTipoZona INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

/* ===========================
 ESQUEMA CATALOGO
=========================== */
CREATE TABLE Catalogo.TipoCompania
(
    IdTipoCompania INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Catalogo.TipoUsuario
(
    IdTipoUsuario INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Catalogo.TipoRol
(
    IdTipoRol INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Catalogo.TipoDocumento
(
    IdTipoDocumento INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Catalogo.TipoContacto
(
    IdTipoContacto INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Catalogo.TipoConexion
(
    IdTipoConexion INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Catalogo.EstadoInfraestructura
(
    IdEstado INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Descripcion NVARCHAR(200) NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

/* ===========================
 ESQUEMA CORE
=========================== */
CREATE TABLE Core.Direccion
(
    IdDireccion INT IDENTITY PRIMARY KEY,
    IdBarrio INT FOREIGN KEY REFERENCES Geo.Barrio(IdBarrio),
    IdTipoZona INT FOREIGN KEY REFERENCES Geo.TipoZona(IdTipoZona),
    Calle VARCHAR(100) NOT NULL,
    Numero VARCHAR(20) NOT NULL,
    CodigoPostal VARCHAR(10) NOT NULL,
    DetalleExtra VARCHAR(100) NULL,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Core.Compania
(
    IdCompania INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    IdTipoCompania INT FOREIGN KEY REFERENCES Catalogo.TipoCompania(IdTipoCompania),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Core.Usuario
(
    IdUsuario INT IDENTITY PRIMARY KEY,
    Nombre1 NVARCHAR(50) NOT NULL,
    Nombre2 NVARCHAR(50) NULL,
    Apellido1 NVARCHAR(50) NOT NULL,
    Apellido2 NVARCHAR(50) NULL,
    IdTipoUsuario INT FOREIGN KEY REFERENCES Catalogo.TipoUsuario(IdTipoUsuario),
    IdTipoDocumento INT FOREIGN KEY REFERENCES Catalogo.TipoDocumento(IdTipoDocumento),
    Documento NVARCHAR(20) UNIQUE,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Core.Contacto
(
    IdContacto INT IDENTITY PRIMARY KEY,
    Valor NVARCHAR(200) NOT NULL,
    IdTipoContacto INT FOREIGN KEY REFERENCES Catalogo.TipoContacto(IdTipoContacto),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Core.UsuarioContacto
(
    IdUsuarioContacto INT IDENTITY PRIMARY KEY,
    IdUsuario INT FOREIGN KEY REFERENCES Core.Usuario(IdUsuario),
    IdContacto INT FOREIGN KEY REFERENCES Core.Contacto(IdContacto),
    EsPrincipal BIT DEFAULT 0,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Core.RolCompania
(
    IdRolCompania INT IDENTITY PRIMARY KEY,
    IdUsuario INT FOREIGN KEY REFERENCES Core.Usuario(IdUsuario),
    IdCompania INT FOREIGN KEY REFERENCES Core.Compania(IdCompania),
    IdRol INT FOREIGN KEY REFERENCES Catalogo.TipoRol(IdTipoRol),
    FechaIngreso DATETIME,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Core.UsuarioDireccion
(
    IdUsuarioDireccion INT IDENTITY PRIMARY KEY,
    IdUsuario INT NOT NULL FOREIGN KEY REFERENCES Core.Usuario(IdUsuario),
    IdDireccion INT NOT NULL FOREIGN KEY REFERENCES Core.Direccion(IdDireccion),
    EsPrincipal BIT DEFAULT 0,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Core.CompaniaDireccion
(
    IdCompaniaDireccion INT IDENTITY PRIMARY KEY ,
    IdCompania INT NOT NULL FOREIGN KEY REFERENCES Core.Compania(IdCompania),
    IdDireccion INT NOT NULL FOREIGN KEY REFERENCES Core.Direccion(IdDireccion),
    EsPrincipal BIT DEFAULT 0,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

/* ===========================
   ESQUEMA IoT
=========================== */
CREATE TABLE IoT.Ubicacion
(
    IdUbicacion INT IDENTITY PRIMARY KEY,
    Latitud DECIMAL(9,6),
    Longitud DECIMAL(9,6),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE IoT.WiFi
(
    IdWiFi INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(100),
    IdUbicacion INT FOREIGN KEY REFERENCES IoT.Ubicacion(IdUbicacion),
    IdCompania INT FOREIGN KEY REFERENCES Core.Compania(IdCompania),
    IdEstado INT FOREIGN KEY REFERENCES Catalogo.EstadoInfraestructura(IdEstado),
    RangoCobertura DECIMAL(10,2),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE IoT.SensorWiFi
(
    IdSensorWiFi BIGINT IDENTITY PRIMARY KEY,
    IdWiFi INT FOREIGN KEY REFERENCES IoT.WiFi(IdWiFi),
    IdUsuario INT FOREIGN KEY REFERENCES Core.Usuario(IdUsuario),
    FechaConexion DATETIME,
    FechaMedicion DATETIME,
    VelocidadSubida DECIMAL(10,2),
    VelocidadBajada DECIMAL(10,2),
    DireccionIP VARCHAR(45),
    IdTipoConexion INT FOREIGN KEY REFERENCES Catalogo.TipoConexion(IdTipoConexion),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE IoT.AlumbradoPublico
(
    IdAlumbrado INT IDENTITY PRIMARY KEY,
    Codigo NVARCHAR(50) UNIQUE,
    IdUbicacion INT FOREIGN KEY REFERENCES IoT.Ubicacion(IdUbicacion),
    IdCompania INT FOREIGN KEY REFERENCES Core.Compania(IdCompania),
    IdEstado INT FOREIGN KEY REFERENCES Catalogo.EstadoInfraestructura(IdEstado),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE IoT.SensorLuminaria
(
    IdSensorLuminaria BIGINT IDENTITY PRIMARY KEY,
    IdAlumbrado INT FOREIGN KEY REFERENCES IoT.AlumbradoPublico(IdAlumbrado),
    FechaMedicion DATETIME,
    Consumo DECIMAL(10,2),
    Temperatura DECIMAL(5,2),
    Luminiscencia DECIMAL(5,2),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

/* ===========================
   ESQUEMA OPS
=========================== */
CREATE TABLE Ops.Mantenimiento
(
    IdMantenimiento INT IDENTITY PRIMARY KEY,
    IdAlumbrado INT NULL FOREIGN KEY REFERENCES IoT.AlumbradoPublico(IdAlumbrado),
    IdWiFi INT NULL FOREIGN KEY REFERENCES IoT.WiFi(IdWiFi),
    Fecha DATETIME,
    Descripcion NVARCHAR(200),
    IdCompania INT FOREIGN KEY REFERENCES Core.Compania(IdCompania),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Ops.MantenimientoEmpleado
(
    IdMantenimientoEmpleado INT IDENTITY PRIMARY KEY,
    IdMantenimiento INT FOREIGN KEY REFERENCES Ops.Mantenimiento(IdMantenimiento),
    IdEmpleado INT FOREIGN KEY REFERENCES Core.RolCompania(IdRolCompania),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO

/* ===========================
 TRIGGERS
=========================== */
USE CiudadInteligenteMER;
GO
-- Trigger para contactos
CREATE TRIGGER TRG_UsuarioContacto_EsPrincipal
ON Core.UsuarioContacto
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE UC
    SET EsPrincipal = 0
    FROM Core.UsuarioContacto UC
        INNER JOIN Core.Contacto C ON UC.IdContacto = C.IdContacto
        INNER JOIN inserted i ON UC.IdUsuario = i.IdUsuario
    WHERE UC.IdUsuario = i.IdUsuario
        AND C.IdTipoContacto = (SELECT IdTipoContacto
        FROM Core.Contacto
        WHERE IdContacto = i.IdContacto)
        AND UC.IdUsuarioContacto <> i.IdUsuarioContacto
        AND i.EsPrincipal = 1;
END;
GO

-- Trigger para direcciones de usuario
CREATE TRIGGER TRG_UsuarioDireccion_EsPrincipal
ON Core.UsuarioDireccion
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE UD
    SET EsPrincipal = 0
    FROM Core.UsuarioDireccion UD
        INNER JOIN inserted i ON UD.IdUsuario = i.IdUsuario
    WHERE UD.IdUsuario = i.IdUsuario
        AND UD.IdUsuarioDireccion <> i.IdUsuarioDireccion
        AND i.EsPrincipal = 1;
END;
GO

-- Trigger para direcciones de compañía
CREATE TRIGGER TRG_CompaniaDireccion_EsPrincipal
ON Core.CompaniaDireccion
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE CD
    SET EsPrincipal = 0
    FROM Core.CompaniaDireccion CD
        INNER JOIN inserted i ON CD.IdCompania = i.IdCompania
    WHERE CD.IdCompania = i.IdCompania
        AND CD.IdCompaniaDireccion <> i.IdCompaniaDireccion
        AND i.EsPrincipal = 1;
END;
GO

/* ===========================
 VISTAS
=========================== */
USE CiudadInteligenteMER;
GO
