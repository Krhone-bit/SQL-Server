-- Usar la base de datos dbCompuCenter
USE dbCompuCenter;
GO

-- Insercion de datos en la tabla Venta y DetalleVenta (Actividad Normal)
DECLARE @ClienteID INT;
DECLARE @FechaVenta DATE;
DECLARE @Total DECIMAL(10, 2);
DECLARE @MetodoPagoID INT;
DECLARE @VentaID INT;
DECLARE @RandomProducto INT;
DECLARE @Cantidad INT;
DECLARE @Precio DECIMAL(10, 2);
DECLARE @i INT;

-- Inicializacion de la variable @i
SET @i = 0;

WHILE @i < 30000 -- 30,000 venta para actividad normal
BEGIN
    SET @ClienteID = FLOOR(RAND() * 10000) + 1; -- Asumimos 10,000 clientes
    --SET @FechaVenta = DATEADD(DAY, FLOOR(RAND() * 28), '2023-02-01'); -- Febrero (Actividad Normal)
	SET @FechaVenta = DATEADD(DAY, FLOOR(RAND() * 90), DATEADD(DAY, -90, GETDATE())); -- Fecha aleatoria en los ultimos 90 dias

    SET @MetodoPagoID = FLOOR(RAND() * 5) + 1; -- Asumimos 5 metodos de pago

    SET @Total = 0; -- Inicializar el total

    INSERT INTO Venta (ClienteID, FechaVenta, Total, MetodoPagoID)
    VALUES (@ClienteID, @FechaVenta, @Total, @MetodoPagoID);

    SET @VentaID = SCOPE_IDENTITY();

    -- Insercion de detalles de venta
    SET @RandomProducto = FLOOR(RAND() * 50) + 1; -- Asumimos 50 producto
    SET @Cantidad = FLOOR(RAND() * 5) + 1; -- Cantidad entre 1 y 5
    SET @Precio = (SELECT Precio FROM Producto WHERE ProductoID = @RandomProducto);
    SET @Total = @Precio * @Cantidad;

    INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Precio)
    VALUES (@VentaID, @RandomProducto, @Cantidad, @Precio);

    -- Actualizar el total en la tabla Venta
    UPDATE Venta
    SET Total = @Total
    WHERE VentaID = @VentaID;

    -- Incrementar el contador
    SET @i = @i + 1;
END;
GO
