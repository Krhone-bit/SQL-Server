---------------------------------------------
-- CORREGIDO
---------------------------------------------
-- Crear el procedimiento en un lote separado
CREATE PROCEDURE SPInsertarVentasConFechaAleatoria
    @FechaInicio DATE,
    @FechaFin DATE,
    @CantidadVentas INT
AS
BEGIN
    -- Declaracion de variables
    DECLARE @ClienteID INT;
    DECLARE @FechaVenta DATE;
    DECLARE @Total DECIMAL(10, 2);
    DECLARE @MetodoPagoID INT;
    DECLARE @VentaID INT;
    DECLARE @RandomProducto INT;
    DECLARE @Cantidad INT;
    DECLARE @Precio DECIMAL(10, 2);
    DECLARE @i INT;
    DECLARE @j INT;
    DECLARE @NumDetalles INT;
    DECLARE @DiferenciaDias INT;
    DECLARE @DiasAleatorios INT;

    -- Inicializacion de la variable @i
    SET @i = 0;

    -- Calcula la diferencia en dias entre la fecha de inicio y la fecha de fin
    SET @DiferenciaDias = DATEDIFF(DAY, @FechaInicio, @FechaFin);

    -- Bucle para insertar las ventas
    WHILE @i < @CantidadVentas
    BEGIN
        SET @ClienteID = FLOOR(RAND() * 10000) + 1; -- Asumimos 10,000 clientes

        -- Genera un número aleatorio de días dentro del rango de diferencia
        SET @DiasAleatorios = FLOOR(RAND() * (@DiferenciaDias + 1)); -- +1 para incluir ambos extremos

        -- Calcula la fecha aleatoria sumando los días aleatorios a la fecha de inicio
        SET @FechaVenta = DATEADD(DAY, @DiasAleatorios, @FechaInicio);

        SET @MetodoPagoID = FLOOR(RAND() * 5) + 1; -- Asumimos 5 métodos de pago

        SET @Total = 0; -- Inicializar el total

        -- Inserta una nueva venta en la tabla Venta de la base de datos dbCompuCenter
        INSERT INTO dbCompuCenter.dbo.Venta (ClienteID, FechaVenta, Total, MetodoPagoID)
        VALUES (@ClienteID, @FechaVenta, @Total, @MetodoPagoID);

        SET @VentaID = SCOPE_IDENTITY();

        -- Generar un número aleatorio de detalles de venta (entre 1 y 3)
        SET @NumDetalles = FLOOR(RAND() * 3) + 1;

        -- Bucle para insertar los detalles de la venta
        SET @j = 0;
        WHILE @j < @NumDetalles
        BEGIN
            SET @RandomProducto = FLOOR(RAND() * 50) + 1; -- Asumimos 50 productos
            SET @Cantidad = FLOOR(RAND() * 5) + 1; -- Cantidad entre 1 y 5
            SET @Precio = (SELECT Precio FROM dbCompuCenter.dbo.Producto WHERE ProductoID = @RandomProducto);
            SET @Total = @Total + (@Precio * @Cantidad);

            INSERT INTO dbCompuCenter.dbo.DetalleVenta (VentaID, ProductoID, Cantidad, Precio)
            VALUES (@VentaID, @RandomProducto, @Cantidad, @Precio);

            SET @j = @j + 1;
        END;

        -- Actualizar el total en la tabla Venta
        UPDATE dbCompuCenter.dbo.Venta
        SET Total = @Total
        WHERE VentaID = @VentaID;

        -- Incrementar el contador
        SET @i = @i + 1;
    END;
END;
GO

-- 1er Trimestre
EXEC SPInsertarVentasConFechaAleatoria '2024-02-01', '2024-02-29', 11000;
EXEC SPInsertarVentasConFechaAleatoria '2024-03-01', '2024-03-30', 12000;
EXEC SPInsertarVentasConFechaAleatoria '2024-04-01', '2024-04-30', 14000;

-- 2do Trimestre
EXEC SPInsertarVentasConFechaAleatoria '2024-05-01', '2024-05-31', 15000;
EXEC SPInsertarVentasConFechaAleatoria '2024-06-01', '2024-06-30', 35000;
EXEC SPInsertarVentasConFechaAleatoria '2024-07-01', '2024-07-31', 60000;

--EXEC InsertarVentasConFechaAleatoria '2024-07-01', '2024-07-30';

DBCC CHECKIDENT ('Venta', RESEED, 0);
DBCC CHECKIDENT ('DetalleVenta', RESEED, 0);

SELECT * FROM Venta;
SELECT * FROM Cliente;
SELECT * FROM Producto;
SELECT * FROM DetalleVenta;

DELETE FROM DetalleVenta;
DELETE FROM Venta;