USE CiudadInteligenteMER;
GO
SET NOCOUNT ON;

DECLARE @Nuevas TABLE (Nombre NVARCHAR(100), Tipo NVARCHAR(50));
INSERT INTO @Nuevas (Nombre, Tipo) VALUES
    (N'AndeNet', N'Proveedor de WiFi'),
    (N'Fibra Andina', N'Proveedor de WiFi'),
    (N'ConectaBog', N'Proveedor de WiFi'),
    (N'Ruta Digital', N'Proveedor de WiFi'),
    (N'Red Ágil', N'Proveedor de WiFi'),
    (N'NetPacífico', N'Proveedor de WiFi'),
    (N'Altamira Fibra', N'Proveedor de WiFi'),
    (N'OrionNet', N'Proveedor de WiFi'),
    (N'MegaWiFi', N'Proveedor de WiFi'),
    (N'Cumbre Telecom', N'Proveedor de WiFi'),
    (N'Luz Urbana', N'Proveedor de Servicios Públicos'),
    (N'Brilla Ciudad', N'Proveedor de Servicios Públicos'),
    (N'Prisma Lumínico', N'Proveedor de Servicios Públicos'),
    (N'Farol Andino', N'Proveedor de Servicios Públicos'),
    (N'Ilumina Metropolitana', N'Proveedor de Servicios Públicos'),
    (N'Halo Público', N'Proveedor de Servicios Públicos'),
    (N'Luminex Distrital', N'Proveedor de Servicios Públicos'),
    (N'ClaroLuz', N'Proveedor de Servicios Públicos'),
    (N'Vía Clara', N'Proveedor de Servicios Públicos'),
    (N'Soluciones de Alumbrado', N'Proveedor de Servicios Públicos');

DECLARE @PorInsertar TABLE (Nombre NVARCHAR(100), IdTipoCompania INT);
INSERT INTO @PorInsertar (Nombre, IdTipoCompania)
SELECT n.Nombre, tc.IdTipoCompania
FROM @Nuevas n
JOIN Catalogo.TipoCompania tc ON tc.Nombre = n.Tipo
LEFT JOIN Core.Compania c ON c.Nombre = n.Nombre
WHERE c.IdCompania IS NULL;

DECLARE @NuevasIds TABLE (IdCompania INT PRIMARY KEY);
INSERT INTO Core.Compania (Nombre, IdTipoCompania)
OUTPUT inserted.IdCompania INTO @NuevasIds
SELECT Nombre, IdTipoCompania
FROM @PorInsertar;

DECLARE @IdCompania INT;
DECLARE cur CURSOR LOCAL FAST_FORWARD FOR SELECT IdCompania FROM @NuevasIds;
OPEN cur;
FETCH NEXT FROM cur INTO @IdCompania;
WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @n INT = 2 + ABS(CHECKSUM(NEWID())) % 4; -- 2..5
    DECLARE @principal INT = 1 + ABS(CHECKSUM(NEWID())) % @n;
    DECLARE @i INT = 1;
    WHILE @i <= @n
    BEGIN
        DECLARE @IdBarrio INT = (SELECT TOP 1 IdBarrio FROM Geo.Barrio ORDER BY NEWID());
        DECLARE @IdTipoZona INT = (SELECT TOP 1 IdTipoZona FROM Geo.TipoZona ORDER BY NEWID());
        DECLARE @Calle VARCHAR(100) = 'Calle ' + CAST(ABS(CHECKSUM(NEWID())) % 200 + 1 AS VARCHAR(3));
        DECLARE @Numero VARCHAR(20) = CAST(ABS(CHECKSUM(NEWID())) % 200 + 1 AS VARCHAR(3)) + '-' + CAST(ABS(CHECKSUM(NEWID())) % 200 + 1 AS VARCHAR(3));
        DECLARE @CodigoPostal VARCHAR(10) = RIGHT('00000' + CAST(ABS(CHECKSUM(NEWID())) % 100000 AS VARCHAR(5)), 5);
        DECLARE @Detalle VARCHAR(100) = CASE WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN 'Apto ' + CAST(ABS(CHECKSUM(NEWID())) % 500 + 1 AS VARCHAR(4)) ELSE NULL END;

        INSERT INTO Core.Direccion (IdBarrio, IdTipoZona, Calle, Numero, CodigoPostal, DetalleExtra)
        VALUES (@IdBarrio, @IdTipoZona, @Calle, @Numero, @CodigoPostal, @Detalle);
        DECLARE @IdDireccion INT = SCOPE_IDENTITY();

        INSERT INTO Core.CompaniaDireccion (IdCompania, IdDireccion, EsPrincipal)
        VALUES (@IdCompania, @IdDireccion, CASE WHEN @i = @principal THEN 1 ELSE 0 END);

        SET @i += 1;
    END

    FETCH NEXT FROM cur INTO @IdCompania;
END
CLOSE cur; DEALLOCATE cur;

SELECT c.IdCompania, c.Nombre, COUNT(cd.IdCompaniaDireccion) AS DireccionesCreadas
FROM Core.Compania c
JOIN @NuevasIds ni ON ni.IdCompania = c.IdCompania
LEFT JOIN Core.CompaniaDireccion cd ON cd.IdCompania = c.IdCompania
GROUP BY c.IdCompania, c.Nombre
ORDER BY c.IdCompania;

SELECT 
  c.Nombre AS Empresa,
  cd.EsPrincipal,
  d.Calle, d.Numero, d.CodigoPostal, d.DetalleExtra,
  b.Nombre  AS Barrio,
  tz.Nombre AS TipoZona
FROM Core.Compania c
JOIN Core.CompaniaDireccion cd ON cd.IdCompania = c.IdCompania
JOIN Core.Direccion d          ON d.IdDireccion = cd.IdDireccion
LEFT JOIN Geo.Barrio b         ON b.IdBarrio = d.IdBarrio
LEFT JOIN Geo.TipoZona tz      ON tz.IdTipoZona = d.IdTipoZona
ORDER BY c.Nombre, cd.EsPrincipal DESC, d.IdDireccion;
