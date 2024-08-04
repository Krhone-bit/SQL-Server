-- Creacion del procedimiento almacenado para eliminar un producto
CREATE PROCEDURE SPEliminarProducto
    @ProductoID INT
AS
BEGIN
    -- Comienza una transacci?n
    BEGIN TRANSACTION;

    -- Manejo de errores
    BEGIN TRY
        -- Verificar si el ProductoID existe
        IF EXISTS (SELECT 1 FROM Producto WHERE ProductoID = @ProductoID)
        BEGIN
            -- Eliminar el producto de la tabla Producto
            DELETE FROM Producto
            WHERE ProductoID = @ProductoID;

            -- Confirmar la transaccion si no hay errores
            COMMIT TRANSACTION;
        END
        ELSE
        BEGIN
            -- Si el ProductoID no existe, lanzar un error
            RAISERROR('Producto no encontrado', 16, 1);
            ROLLBACK TRANSACTION;
        END
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


EXEC EliminarProducto @ProductoID = 51;


