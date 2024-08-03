CREATE PROCEDURE ActualizarTelefonosAleatorios
AS
BEGIN
    DECLARE @ClienteID INT;
    DECLARE @Telefono NVARCHAR(9);
    DECLARE @NumeroTelefono INT;
    DECLARE @Min INT = 0;  -- Mínimo para los dígitos aleatorios (00000000)
    DECLARE @Max INT = 99999999;  -- Máximo para los dígitos aleatorios (99999999)
    DECLARE @RandomPart INT;
    DECLARE @Prefix NVARCHAR(1) = '9';  -- Prefijo fijo

    DECLARE ClienteCursor CURSOR FOR
    SELECT ClienteID
    FROM Cliente;

    OPEN ClienteCursor;
    FETCH NEXT FROM ClienteCursor INTO @ClienteID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Generar la parte aleatoria del número de teléfono de 8 dígitos
        SET @RandomPart = FLOOR(RAND() * (@Max - @Min + 1)) + @Min;

        -- Convertir la parte aleatoria a NVARCHAR y combinar con el prefijo '9'
        SET @Telefono = @Prefix + RIGHT('00000000' + CAST(@RandomPart AS NVARCHAR(8)), 8);

        -- Actualizar el número de teléfono del cliente
        UPDATE Cliente
        SET Telefono = @Telefono
        WHERE ClienteID = @ClienteID;

        FETCH NEXT FROM ClienteCursor INTO @ClienteID;
    END;

    CLOSE ClienteCursor;
    DEALLOCATE ClienteCursor;
END;
GO

EXEC ActualizarTelefonosAleatorios;

SELECT count(1) FROM Venta;