SET NOCOUNT ON
GO

set quoted_identifier on
GO

SET DATEFORMAT mdy
GO

/* 1) Crear/Resetear BD */
IF DB_ID('CiudadInteligenteDW') IS NOT NULL
BEGIN
    ALTER DATABASE CiudadInteligenteDW SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CiudadInteligenteDW;
END;
GO

CREATE DATABASE CiudadInteligenteDW;
GO
USE CiudadInteligenteDW;
GO

/* 2) Esquemas */
CREATE SCHEMA Dim;   -- Dimensiones
GO
CREATE SCHEMA Hechos; -- Tablas de hechos
GO

/* ===========================
   DIMENSIONES
=========================== */

-- Dimensión de fechas (calendario) - clave sustituta YYYYMMDD
CREATE TABLE Dim.Fecha
(
    IdFecha INT NOT NULL PRIMARY KEY,
    -- yyyymmdd
    Fecha DATE NOT NULL,
    Anio SMALLINT NOT NULL,
    Mes TINYINT NOT NULL,
    Dia TINYINT NOT NULL,
    Trimestre TINYINT NOT NULL,
    NombreMes NVARCHAR(20) NOT NULL,
    DiaSemana TINYINT NOT NULL,
    -- 1=Lunes .. 7=Domingo
    NombreDiaSemana NVARCHAR(20) NOT NULL,
    SemanaAnio TINYINT NOT NULL
);
GO

-- Dimensión ubicación (lat/long) basada en IoT.Ubicacion
CREATE TABLE Dim.Ubicacion
(
    IdUbicacion INT IDENTITY PRIMARY KEY,
    IdUbicacionSource INT UNIQUE,
    -- rastreo origen
    Latitud DECIMAL(9,6) NULL,
    Longitud DECIMAL(9,6) NULL
);
GO

-- Dimensión compañía (Core.Compania + Catalogo.TipoCompania)
CREATE TABLE Dim.Compania
(
    IdCompania INT IDENTITY PRIMARY KEY,
    IdCompaniaSource INT UNIQUE,
    Nombre NVARCHAR(100) NOT NULL,
    TipoCompania NVARCHAR(50) NULL
);
GO

-- Dimensión usuario (Core.Usuario + tipos)
CREATE TABLE Dim.Usuario
(
    IdUsuario INT IDENTITY PRIMARY KEY,
    IdUsuarioSource INT UNIQUE,
    NombreCompleto NVARCHAR(200) NOT NULL,
    TipoUsuario NVARCHAR(50) NULL,
    TipoDocumento NVARCHAR(50) NULL,
    Documento NVARCHAR(20) NULL
);
GO

-- Dimensión estado infraestructura (Catalogo.EstadoInfraestructura)
CREATE TABLE Dim.EstadoInfraestructura
(
    IdEstadoInfraestructura INT IDENTITY PRIMARY KEY,
    IdEstadoSource INT UNIQUE,
    Nombre NVARCHAR(50) NOT NULL,
    Descripcion NVARCHAR(200) NULL
);
GO

-- Dimensión tipo de conexión (Catalogo.TipoConexion)
CREATE TABLE Dim.TipoConexion
(
    IdTipoConexion INT IDENTITY PRIMARY KEY,
    IdTipoConexionSource INT UNIQUE,
    Nombre NVARCHAR(50) NOT NULL
);
GO

-- Dimensión WiFi (IoT.WiFi) denormalizada con atributos relevantes
CREATE TABLE Dim.WiFi
(
    IdWiFi INT IDENTITY PRIMARY KEY,
    IdWiFiSource INT UNIQUE,
    Nombre NVARCHAR(100) NULL,
    RangoCobertura DECIMAL(10,2) NULL,
    -- Atributos denormalizados
    CompaniaNombre NVARCHAR(100) NULL,
    EstadoNombre NVARCHAR(50) NULL,
    Latitud DECIMAL(9,6) NULL,
    Longitud DECIMAL(9,6) NULL
);
GO

-- Dimensión Alumbrado público (IoT.AlumbradoPublico) denormalizada
CREATE TABLE Dim.Alumbrado
(
    IdAlumbrado INT IDENTITY PRIMARY KEY,
    IdAlumbradoSource INT UNIQUE,
    Codigo NVARCHAR(50) NOT NULL,
    -- Atributos denormalizados
    CompaniaNombre NVARCHAR(100) NULL,
    EstadoNombre NVARCHAR(50) NULL,
    Latitud DECIMAL(9,6) NULL,
    Longitud DECIMAL(9,6) NULL
);
GO

/* ===========================
   HECHOS
=========================== */

-- Hecho: mediciones de sensores WiFi (IoT.SensorWiFi)
CREATE TABLE Hechos.SensorWiFi
(
    IdSensorWiFi BIGINT IDENTITY PRIMARY KEY,
    IdSensorWiFiSource BIGINT UNIQUE,
    -- rastreo origen

    -- Dimensiones
    IdFechaMedicion INT NOT NULL FOREIGN KEY REFERENCES Dim.Fecha(IdFecha),
    IdFechaConexion INT NULL FOREIGN KEY REFERENCES Dim.Fecha(IdFecha),
    IdWiFi INT NOT NULL FOREIGN KEY REFERENCES Dim.WiFi(IdWiFi),
    IdUsuario INT NULL FOREIGN KEY REFERENCES Dim.Usuario(IdUsuario),
    IdTipoConexion INT NULL FOREIGN KEY REFERENCES Dim.TipoConexion(IdTipoConexion),

    -- Medidas
    VelocidadSubida DECIMAL(10,2) NULL,
    VelocidadBajada DECIMAL(10,2) NULL,

    -- Degenerada
    DireccionIP VARCHAR(45) NULL
);
GO

CREATE INDEX IX_SensorWiFi_FechaMedicion ON Hechos.SensorWiFi(IdFechaMedicion);
CREATE INDEX IX_SensorWiFi_WiFi ON Hechos.SensorWiFi(IdWiFi);
CREATE INDEX IX_SensorWiFi_Usuario ON Hechos.SensorWiFi(IdUsuario);
GO

-- Hecho: mediciones de luminaria (IoT.SensorLuminaria)
CREATE TABLE Hechos.SensorLuminaria
(
    IdSensorLuminaria BIGINT IDENTITY PRIMARY KEY,
    IdSensorLuminariaSource BIGINT UNIQUE,

    -- Dimensiones
    IdFechaMedicion INT NOT NULL FOREIGN KEY REFERENCES Dim.Fecha(IdFecha),
    IdAlumbrado INT NOT NULL FOREIGN KEY REFERENCES Dim.Alumbrado(IdAlumbrado),

    -- Medidas
    Consumo DECIMAL(10,2) NULL,
    Temperatura DECIMAL(5,2) NULL,
    Luminiscencia DECIMAL(5,2) NULL
);
GO

CREATE INDEX IX_SensorLuminaria_FechaMedicion ON Hechos.SensorLuminaria(IdFechaMedicion);
CREATE INDEX IX_SensorLuminaria_Alumbrado ON Hechos.SensorLuminaria(IdAlumbrado);
GO

-- Hecho: mantenimientos (Ops.Mantenimiento) con agregados simples
CREATE TABLE Hechos.Mantenimiento
(
    IdMantenimiento INT IDENTITY PRIMARY KEY,
    IdMantenimientoSource INT UNIQUE,

    -- Dimensiones
    IdFecha INT NOT NULL FOREIGN KEY REFERENCES Dim.Fecha(IdFecha),
    IdCompania INT NULL FOREIGN KEY REFERENCES Dim.Compania(IdCompania),
    IdWiFi INT NULL FOREIGN KEY REFERENCES Dim.WiFi(IdWiFi),
    IdAlumbrado INT NULL FOREIGN KEY REFERENCES Dim.Alumbrado(IdAlumbrado),

    -- Medidas
    EmpleadosAsignados INT NULL,
    -- derivado de Ops.MantenimientoEmpleado
    CantidadMantenimientos INT NOT NULL DEFAULT 1,

    -- Degenerada
    Descripcion NVARCHAR(200) NULL
);
GO

CREATE INDEX IX_Mantenimiento_Fecha ON Hechos.Mantenimiento(IdFecha);
CREATE INDEX IX_Mantenimiento_Compania ON Hechos.Mantenimiento(IdCompania);
GO

/* ===========================
   Carga inicial de Dim.Fecha
   (rango 2015-01-01 a 2030-12-31)
=========================== */
SET NOCOUNT ON;
DECLARE @start DATE = '2015-01-01';
DECLARE @end   DATE = '2030-12-31';
;WITH
    d
    AS
    (
                    SELECT @start AS dt
        UNION ALL
            SELECT DATEADD(DAY, 1, dt)
            FROM d
            WHERE dt < @end
    )
INSERT INTO Dim.Fecha
    (IdFecha, Fecha, Anio, Mes, Dia, Trimestre, NombreMes, DiaSemana, NombreDiaSemana, SemanaAnio)
SELECT
    CONVERT(INT, FORMAT(dt, 'yyyyMMdd')) AS IdFecha,
    dt AS Fecha,
    YEAR(dt) AS Anio,
    MONTH(dt) AS Mes,
    DAY(dt) AS Dia,
    DATEPART(QUARTER, dt) AS Trimestre,
    DATENAME(MONTH, dt) AS NombreMes,
    ((DATEPART(WEEKDAY, dt) + 5) % 7) + 1 AS DiaSemana, -- 1=Lunes
    DATENAME(WEEKDAY, dt) AS NombreDiaSemana,
    DATEPART(WEEK, dt) AS SemanaAnio
FROM d
OPTION
(MAXRECURSION
0);
GO