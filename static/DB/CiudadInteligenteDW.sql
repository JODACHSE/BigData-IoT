USE master;
GO

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

-- Crear esquemas
CREATE SCHEMA Dim;
GO
CREATE SCHEMA Hec;
GO

/* ===========================
DIMENSIONES
=========================== */

-- Dimensión Tiempo
CREATE TABLE Dim.Tiempo (
    IdTiempo INT IDENTITY PRIMARY KEY,
    FechaCompleta DATE NOT NULL,
    Anio INT NOT NULL,
    Mes INT NOT NULL,
    NombreMes NVARCHAR(20),
    Dia INT NOT NULL,
    NombreDia NVARCHAR(20),
    Hora INT NULL,
    Minuto INT NULL,
    Segundo INT NULL
);
CREATE UNIQUE INDEX IX_Tiempo_FechaHora ON Dim.Tiempo(FechaCompleta, Hora, Minuto, Segundo);

-- Dimensión Usuario
CREATE TABLE Dim.Usuario (
    IdUsuarioDW INT IDENTITY PRIMARY KEY,
    IdUsuarioMER INT NOT NULL,
    NombreCompleto NVARCHAR(200),
    TipoUsuario NVARCHAR(50)
);
CREATE INDEX IX_Usuario_Tipo ON Dim.Usuario(TipoUsuario);

-- Dimensión Ubicación (independiente de Dirección)
CREATE TABLE Dim.Ubicacion (
    IdUbicacionDW INT IDENTITY PRIMARY KEY,
    IdUbicacionMER INT NOT NULL,
    Latitud DECIMAL(9,6),
    Longitud DECIMAL(9,6)
);
CREATE INDEX IX_Ubicacion_LatLong ON Dim.Ubicacion(Latitud, Longitud);

-- Dimensión Dispositivo (WiFi o Luminaria)
CREATE TABLE Dim.Dispositivo (
    IdDispositivoDW INT IDENTITY PRIMARY KEY,
    IdDispositivoMER INT NOT NULL,
    TipoDispositivo NVARCHAR(50), -- 'WiFi' o 'Luminaria'
    Estado NVARCHAR(50)
);
CREATE INDEX IX_Dispositivo_Tipo ON Dim.Dispositivo(TipoDispositivo);

-- Dimensión TipoMantenimiento
CREATE TABLE Dim.TipoMantenimiento (
    IdTipoMantenimiento INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL
);
CREATE UNIQUE INDEX IX_TipoMantenimiento_Nombre ON Dim.TipoMantenimiento(Nombre);

/* ===========================
TABLAS DE HECHOS
=========================== */

-- FactWiFi: mediciones de velocidad
CREATE TABLE Hec.FactWiFi (
    IdMedicion BIGINT IDENTITY PRIMARY KEY,
    IdTiempo INT NOT NULL FOREIGN KEY REFERENCES Dim.Tiempo(IdTiempo),
    IdUsuarioDW INT NULL FOREIGN KEY REFERENCES Dim.Usuario(IdUsuarioDW),
    IdUbicacionDW INT NOT NULL FOREIGN KEY REFERENCES Dim.Ubicacion(IdUbicacionDW),
    IdDispositivoDW INT NOT NULL FOREIGN KEY REFERENCES Dim.Dispositivo(IdDispositivoDW),
    VelocidadSubida DECIMAL(10,2) NOT NULL,
    VelocidadBajada DECIMAL(10,2) NOT NULL,
    IdTipoConexion INT NULL -- opcional, si se requiere como atributo adicional
);
CREATE INDEX IX_FactWiFi_Tiempo ON Hec.FactWiFi(IdTiempo);
CREATE INDEX IX_FactWiFi_Ubicacion ON Hec.FactWiFi(IdUbicacionDW);

-- FactLuminaria: mediciones de alumbrado
CREATE TABLE Hec.FactLuminaria (
    IdMedicion BIGINT IDENTITY PRIMARY KEY,
    IdTiempo INT NOT NULL FOREIGN KEY REFERENCES Dim.Tiempo(IdTiempo),
    IdUbicacionDW INT NOT NULL FOREIGN KEY REFERENCES Dim.Ubicacion(IdUbicacionDW),
    IdDispositivoDW INT NOT NULL FOREIGN KEY REFERENCES Dim.Dispositivo(IdDispositivoDW),
    Consumo DECIMAL(10,2) NOT NULL,
    Temperatura DECIMAL(5,2) NULL,
    Luminiscencia DECIMAL(5,2) NULL
);
CREATE INDEX IX_FactLuminaria_Tiempo ON Hec.FactLuminaria(IdTiempo);
CREATE INDEX IX_FactLuminaria_Ubicacion ON Hec.FactLuminaria(IdUbicacionDW);

-- FactMantenimiento: eventos de mantenimiento
CREATE TABLE Hec.FactMantenimiento (
    IdEvento BIGINT IDENTITY PRIMARY KEY,
    IdTiempo INT NOT NULL FOREIGN KEY REFERENCES Dim.Tiempo(IdTiempo),
    IdDispositivoDW INT NOT NULL FOREIGN KEY REFERENCES Dim.Dispositivo(IdDispositivoDW),
    IdTipoMantenimiento INT NOT NULL FOREIGN KEY REFERENCES Dim.TipoMantenimiento(IdTipoMantenimiento),
    IdCompania INT NULL, -- opcional si se requiere
    Descripcion NVARCHAR(200) NULL
);
CREATE INDEX IX_FactMantenimiento_Tiempo ON Hec.FactMantenimiento(IdTiempo);
CREATE INDEX IX_FactMantenimiento_Dispositivo ON Hec.FactMantenimiento(IdDispositivoDW);
