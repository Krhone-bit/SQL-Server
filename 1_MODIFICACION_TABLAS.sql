-----------------------------------------------------
-- Agregar Campos adicionales y campos de auditoria
-----------------------------------------------------

ALTER TABLE Cliente
ADD Dni Char(8) NULL;

ALTER TABLE Cliente
ADD FechaCreacion Date NULL;

ALTER TABLE Cliente
ADD FechaActualizacion Date NULL;

ALTER TABLE DetalleVenta
ADD FechaCreacion Date NULL;

ALTER TABLE DetalleVenta
ADD FechaActualizacion Date NULL;

ALTER TABLE MetodoPago
ADD FechaCreacion Date NULL;

ALTER TABLE MetodoPago
ADD FechaActualizacion Date NULL;

ALTER TABLE Producto
ADD FechaCreacion Date NULL;

ALTER TABLE Producto
ADD FechaActualizacion Date NULL

ALTER TABLE Venta
ADD FechaCreacion Date NULL;

ALTER TABLE Venta
ADD FechaActualizacion Date NULL;

-----------------------------------------------------
-- Actualizar Los Campos agregados
-----------------------------------------------------
WITH RandomDNIs AS (
    SELECT 
        ClienteID,
        nombre,
        RIGHT('00000000' + CAST(ABS(CHECKSUM(NEWID())) % 100000000 AS VARCHAR(8)), 8) AS dni_aleatorio
    FROM 
        cliente
)
UPDATE Cliente
SET dni = r.dni_aleatorio
FROM cliente c
JOIN RandomDNIs r ON c.ClienteID = r.ClienteID;

WITH RandomDates AS (
    SELECT 
        ClienteID,
        DATEADD(DAY, -1 * ABS(CHECKSUM(NEWID()) % 730), GETDATE()) AS RandomCreationDate,
        DATEADD(DAY, -1 * ABS(CHECKSUM(NEWID()) % 730), GETDATE()) + ABS(CHECKSUM(NEWID()) % 30) AS RandomUpdateDate
    FROM 
        cliente
)
UPDATE cliente
SET FechaCreacion = r.RandomCreationDate,
    FechaActualizacion = r.RandomUpdateDate
FROM cliente c
JOIN RandomDates r ON c.ClienteID = r.ClienteID;

WITH RandomDates AS (
    SELECT 
        MetodoPagoID,
        DATEADD(DAY, -1 * ABS(CHECKSUM(NEWID()) % 730), GETDATE()) AS RandomCreationDate,
        DATEADD(DAY, -1 * ABS(CHECKSUM(NEWID()) % 730), GETDATE()) + ABS(CHECKSUM(NEWID()) % 30) AS RandomUpdateDate
    FROM 
        MetodoPago
)
UPDATE MetodoPago
SET FechaCreacion = r.RandomCreationDate,
    FechaActualizacion = r.RandomUpdateDate
FROM MetodoPago c
JOIN RandomDates r ON c.MetodoPagoID = r.MetodoPagoID;


WITH RandomDates AS (
    SELECT 
        ProductoID,
        DATEADD(DAY, -1 * ABS(CHECKSUM(NEWID()) % 730), GETDATE()) AS RandomCreationDate,
        DATEADD(DAY, -1 * ABS(CHECKSUM(NEWID()) % 730), GETDATE()) + ABS(CHECKSUM(NEWID()) % 30) AS RandomUpdateDate
    FROM 
        Producto
)
UPDATE Producto
SET FechaCreacion = r.RandomCreationDate,
    FechaActualizacion = r.RandomUpdateDate
FROM Producto c
JOIN RandomDates r ON c.ProductoID = r.ProductoID;


WITH RandomDates AS (
    SELECT 
        VentaID,
        FechaVenta AS FechaCreacion,
        DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 30) + 1, FechaVenta) AS FechaActualizacion
    FROM 
        Venta
)
UPDATE Venta
SET FechaCreacion = r.FechaCreacion,
    FechaActualizacion = r.FechaActualizacion
FROM Venta c
JOIN RandomDates r ON c.VentaID = r.VentaID;

WITH DetalleRandomDates AS (
    SELECT 
        dv.DetalleID,
        v.FechaVenta AS FechaCreacion,
        DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 30) + 1, v.FechaVenta) AS FechaActualizacion
    FROM 
        DetalleVenta dv
    JOIN Venta v ON dv.VentaID = v.VentaID
)
UPDATE DetalleVenta
SET FechaCreacion = d.FechaCreacion,
    FechaActualizacion = d.FechaActualizacion
FROM DetalleVenta dv
JOIN DetalleRandomDates d ON dv.DetalleID = d.DetalleID;

SELECT * FROM Cliente;
SELECT * FROM MetodoPago;
SELECT * FROM Producto;
SELECT * FROM Venta;
SELECT * FROM DetalleVenta;