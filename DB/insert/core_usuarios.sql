USE CiudadInteligenteMER;
GO
SET NOCOUNT ON;

DECLARE @TotalUsuarios INT = 10000;  -- cambia este valor si necesitas más

/* 0) Validaciones mínimas de catálogo */
IF NOT EXISTS (
    SELECT 1 FROM Catalogo.TipoUsuario 
    WHERE Nombre IN (N'Ciudadano Común',N'Ciudadano Externo',N'Invitado',N'Empleado',N'Operador',
                     N'Técnico',N'Supervisor',N'Gerente',N'Administrador',N'Auditor')
)
BEGIN
    RAISERROR('Faltan tipos de usuario requeridos en Catalogo.TipoUsuario.',16,1);
    RETURN;
END

/* 1) Listas pequeñas de nombres y apellidos para combinar aleatoriamente */
DECLARE @Nombres TABLE (Id INT IDENTITY(1,1) PRIMARY KEY, Nombre NVARCHAR(100));
INSERT INTO @Nombres (Nombre) VALUES
(N'Juan'),(N'Carlos'),(N'Luis'),(N'Sergio'),(N'Andrés'),(N'Felipe'),(N'José'),(N'Miguel'),(N'Jorge'),(N'Camilo'),
(N'Pedro'),(N'Ricardo'),(N'Rafael'),(N'Óscar'),(N'Iván'),(N'Germán'),(N'Héctor'),(N'Víctor'),(N'Roberto'),(N'Pablo'),
(N'Ana'),(N'María'),(N'Laura'),(N'Luisa'),(N'Paula'),(N'Diana'),(N'Carolina'),(N'Natalia'),(N'Claudia'),(N'Juliana'),
(N'Andrea'),(N'Camila'),(N'Valentina'),(N'Gabriela'),(N'Sofía'),(N'Isabella'),(N'Daniela'),(N'Catalina'),(N'Fernanda'),(N'Elena');

DECLARE @Apellidos TABLE (Id INT IDENTITY(1,1) PRIMARY KEY, Apellido NVARCHAR(100));
INSERT INTO @Apellidos (Apellido) VALUES
(N'García'),(N'Rodríguez'),(N'Martínez'),(N'López'),(N'González'),
(N'Hernández'),(N'Pérez'),(N'Sánchez'),(N'Ramírez'),(N'Torres'),
(N'Flores'),(N'Rivera'),(N'Gómez'),(N'Díaz'),(N'Cruz'),
(N'Moreno'),(N'Ortiz'),(N'Reyes'),(N'Vargas'),(N'Castro'),
(N'Rojas'),(N'Mendoza'),(N'Guerrero'),(N'Vega'),(N'Molano'),
(N'Romero'),(N'Alvarez'),(N'Navarro'),(N'Silva'),(N'Peña'),
(N'Ruiz'),(N'Camacho'),(N'Valencia'),(N'Calderón'),(N'Bautista'),
(N'Peñaloza'),(N'Cordoba'),(N'Beltrán'),(N'Padilla'),(N'Gallardo');

DECLARE @cNombres  INT = (SELECT COUNT(*) FROM @Nombres);
DECLARE @cApellidos INT = (SELECT COUNT(*) FROM @Apellidos);

/* 2) Distribución 0..999 para asignar TipoUsuario con las probabilidades solicitadas */
DECLARE @Dist TABLE (Nombre NVARCHAR(50), RIni INT, RFin INT);
-- 60.0%
INSERT INTO @Dist VALUES (N'Ciudadano Común',   0, 599);
-- 25.0%
INSERT INTO @Dist VALUES (N'Ciudadano Externo', 600, 849);
--  5.0%
INSERT INTO @Dist VALUES (N'Invitado',          850, 899);
--  3.0%
INSERT INTO @Dist VALUES (N'Empleado',          900, 929);
--  2.0%
INSERT INTO @Dist VALUES (N'Operador',          930, 949);
--  2.0%
INSERT INTO @Dist VALUES (N'Técnico',           950, 969);
--  1.0%
INSERT INTO @Dist VALUES (N'Supervisor',        970, 979);
--  1.0%
INSERT INTO @Dist VALUES (N'Gerente',           980, 989);
--  0.5%
INSERT INTO @Dist VALUES (N'Administrador',     990, 994);
--  0.5%
INSERT INTO @Dist VALUES (N'Auditor',           995, 999);

/* 3) Insertar @TotalUsuarios en Core.Usuario y capturar Ids */
DECLARE @NuevosUsuarios TABLE (IdUsuario INT PRIMARY KEY);

WITH base AS (
    SELECT TOP (@TotalUsuarios)
           ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn,
           ABS(CHECKSUM(NEWID())) % 1000 AS rTipo
    FROM sys.all_objects a CROSS JOIN sys.all_objects b
),
tipo AS (
    SELECT b.rn, tu.IdTipoUsuario
    FROM base b
    JOIN @Dist d
      ON b.rTipo BETWEEN d.RIni AND d.RFin
    JOIN Catalogo.TipoUsuario tu
      ON tu.Nombre = d.Nombre
)
INSERT INTO Core.Usuario
    (Nombre1, Nombre2, Apellido1, Apellido2, IdTipoUsuario, IdTipoDocumento, Documento)
OUTPUT inserted.IdUsuario INTO @NuevosUsuarios
SELECT
    -- Nombre1
    (SELECT n1.Nombre FROM @Nombres n1 WHERE n1.Id = 1 + ABS(CHECKSUM(NEWID())) % @cNombres),
    -- Nombre2 (50% nulo)
    CASE WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 
         THEN (SELECT n2.Nombre FROM @Nombres n2 WHERE n2.Id = 1 + ABS(CHECKSUM(NEWID())) % @cNombres)
         ELSE NULL END,
    -- Apellido1
    (SELECT a1.Apellido FROM @Apellidos a1 WHERE a1.Id = 1 + ABS(CHECKSUM(NEWID())) % @cApellidos),
    -- Apellido2 (aprox 65% nulo)
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0
         THEN (SELECT a2.Apellido FROM @Apellidos a2 WHERE a2.Id = 1 + ABS(CHECKSUM(NEWID())) % @cApellidos)
         ELSE NULL END,
    -- TipoUsuario según distribución
    t.IdTipoUsuario,
    -- TipoDocumento aleatorio existente
    (SELECT TOP 1 IdTipoDocumento FROM Catalogo.TipoDocumento ORDER BY NEWID()),
    -- Documento único alfanumérico de 12 chars
    RIGHT(REPLACE(CONVERT(VARCHAR(36), NEWID()), '-', ''), 12)
FROM tipo t
OPTION (MAXDOP 1);

DECLARE @cntUsuarios INT;
SELECT @cntUsuarios = COUNT(*) FROM @NuevosUsuarios;
PRINT CONCAT('Usuarios creados: ', @cntUsuarios);

/* 4) Generar 2..5 direcciones por usuario y elegir exactamente 1 principal */
DECLARE @Tally TABLE(n INT PRIMARY KEY);
INSERT INTO @Tally(n) VALUES (1),(2),(3),(4),(5);

DECLARE @Pendientes TABLE
(
    IdUsuario INT,
    EsPrincipal BIT,
    IdBarrio INT,
    IdTipoZona INT,
    Calle VARCHAR(100),
    Numero VARCHAR(20),
    CodigoPostal VARCHAR(10),
    DetalleExtra VARCHAR(100)
);

INSERT INTO @Pendientes (IdUsuario, EsPrincipal, IdBarrio, IdTipoZona, Calle, Numero, CodigoPostal, DetalleExtra)
SELECT
    u.IdUsuario,
    CASE WHEN t.n = p2.principal THEN 1 ELSE 0 END AS EsPrincipal,
    (SELECT TOP 1 IdBarrio   FROM Geo.Barrio   ORDER BY NEWID()),
    (SELECT TOP 1 IdTipoZona FROM Geo.TipoZona ORDER BY NEWID()),
    'Calle ' + CAST(ABS(CHECKSUM(NEWID())) % 200 + 1 AS VARCHAR(3)),
    CAST(ABS(CHECKSUM(NEWID())) % 200 + 1 AS VARCHAR(3))
      + '-' +
    CAST(ABS(CHECKSUM(NEWID())) % 200 + 1 AS VARCHAR(3)),
    RIGHT('00000' + CAST(ABS(CHECKSUM(NEWID())) % 100000 AS VARCHAR(5)), 5),
    CASE WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 
         THEN 'Apto ' + CAST(ABS(CHECKSUM(NEWID())) % 500 + 1 AS VARCHAR(4))
         ELSE NULL END
FROM @NuevosUsuarios u
CROSS APPLY ( SELECT total = 2 + ABS(CHECKSUM(NEWID())) % 4 ) p     -- 2..5 direcciones
CROSS APPLY ( SELECT principal = 1 + ABS(CHECKSUM(NEWID())) % p.total ) p2  -- 1..total
JOIN @Tally t
  ON t.n <= p.total;

-- Mapa de IdDireccion generado por MERGE
DECLARE @Map TABLE (IdUsuario INT, IdDireccion INT, EsPrincipal BIT);

MERGE Core.Direccion AS D
USING @Pendientes AS S
    ON 1 = 0  -- fuerza INSERT
WHEN NOT MATCHED THEN
    INSERT (IdBarrio, IdTipoZona, Calle, Numero, CodigoPostal, DetalleExtra)
    VALUES (S.IdBarrio, S.IdTipoZona, S.Calle, S.Numero, S.CodigoPostal, S.DetalleExtra)
OUTPUT S.IdUsuario, inserted.IdDireccion, S.EsPrincipal
INTO @Map;

INSERT INTO Core.UsuarioDireccion (IdUsuario, IdDireccion, EsPrincipal)
SELECT IdUsuario, IdDireccion, EsPrincipal
FROM @Map;

DECLARE @cntDirs INT;
SELECT @cntDirs = COUNT(*) FROM @Map;
PRINT CONCAT('Direcciones creadas: ', @cntDirs);

/* 5) Chequeos rápidos */
-- Distribución por tipo de usuario dentro del lote creado
SELECT tu.Nombre AS TipoUsuario, COUNT(*) AS Usuarios
FROM Core.Usuario u
JOIN @NuevosUsuarios nu ON nu.IdUsuario = u.IdUsuario
JOIN Catalogo.TipoUsuario tu ON tu.IdTipoUsuario = u.IdTipoUsuario
GROUP BY tu.Nombre
ORDER BY Usuarios DESC;

USE CiudadInteligenteMER;
GO
SELECT COUNT(*) AS UsuartiosEnMER FROM Core.Usuario;
GO

USE CiudadInteligenteDW;
GO
SELECT COUNT(*) AS UsuartiosEnDW FROM DIM.Usuario;
GO

USE CiudadInteligenteMER;
GO
SELECT * FROM Core.UsuarioDireccion;
GO