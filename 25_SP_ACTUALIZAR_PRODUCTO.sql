-- Creacion del procedimiento almacenado para actualizar un producto existente
CREATE PROCEDURE SPActualizarProducto
    @ProductoID INT,
    @Nombre NVARCHAR(100) = NULL,
    @Precio DECIMAL(10, 2) = NULL,
    @Descripcion NVARCHAR(255) = NULL
AS
BEGIN
    -- Comienza una transacci?n
    BEGIN TRANSACTION;

    -- Manejo de errores
    BEGIN TRY
        -- Actualizacion del producto en la tabla Producto
        UPDATE Producto
        SET
            Nombre = COALESCE(@Nombre, Nombre),
            Precio = COALESCE(@Precio, Precio),
            Descripcion = COALESCE(@Descripcion, Descripcion)
        WHERE ProductoID = @ProductoID;

        -- Confirmar la transaccion si no hay errores
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- En caso de error, deshacer la transacci?n
        ROLLBACK TRANSACTION;

        -- Manejo del error
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

EXEC ActualizarProducto @ProductoID = 51, @Nombre = 'Monitor Samsung', @Precio = 35.99;

SELECT * FROM Producto WHERE ProductoID =51;
