CREATE PROCEDURE InsertarVentasConFechaAleatoria
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
    DECLARE @DiferenciaDias INT;
    DECLARE @DiasAleatorios INT;

    -- Inicializacion de la variable @i
    SET @i = 0;

    -- Calcula la diferencia en dias entre la fecha de inicio y la fecha de fin
    SET @DiferenciaDias = DATEDIFF(DAY, @FechaInicio, @FechaFin);

    -- Bucle para insertar 30,000 ventas
    WHILE @i < @CantidadVentas -- ventas para actividad normal
    BEGIN
        SET @ClienteID = FLOOR(RAND() * 10000) + 1; -- Asumimos 10,000 clientes

        -- Genera un n?mero aleatorio de d?as dentro del rango de diferencia
        SET @DiasAleatorios = FLOOR(RAND() * (@DiferenciaDias + 1)); -- +1 para incluir ambos extremos

        -- Calcula la fecha aleatoria sumando los d?as aleatorios a la fecha de inicio
        SET @FechaVenta = DATEADD(DAY, @DiasAleatorios, @FechaInicio);

        SET @MetodoPagoID = FLOOR(RAND() * 5) + 1; -- Asumimos 5 m?todos de pago

        SET @Total = 0; -- Inicializar el total

        -- Inserta una nueva venta en la tabla Venta de la base de datos dbCompuCenter
        INSERT INTO dbCompuCenter.dbo.Venta (ClienteID, FechaVenta, Total, MetodoPagoID)
        VALUES (@ClienteID, @FechaVenta, @Total, @MetodoPagoID);

        SET @VentaID = SCOPE_IDENTITY();

        -- Inserci?n de detalles de venta
        SET @RandomProducto = FLOOR(RAND() * 50) + 1; -- Asumimos 50 productos
        SET @Cantidad = FLOOR(RAND() * 5) + 1; -- Cantidad entre 1 y 5
        SET @Precio = (SELECT Precio FROM dbCompuCenter.dbo.Producto WHERE ProductoID = @RandomProducto);
        SET @Total = @Precio * @Cantidad;

        INSERT INTO dbCompuCenter.dbo.DetalleVenta (VentaID, ProductoID, Cantidad, Precio)
        VALUES (@VentaID, @RandomProducto, @Cantidad, @Precio);

        -- Actualizar el total en la tabla Venta
        UPDATE dbCompuCenter.dbo.Venta
        SET Total = @Total
        WHERE VentaID = @VentaID;

        -- Incrementar el contador
        SET @i = @i + 1;
    END;
END;
GO


EXEC InsertarVentasConFechaAleatoria '2024-07-01', '2024-07-30', 30000;

--EXEC InsertarVentasConFechaAleatoria '2024-07-01', '2024-07-30';