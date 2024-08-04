-- Creacion del procedimiento almacenado para leer datos de productos
CREATE PROCEDURE SPLeerProducto
    @ProductoID INT = NULL
AS
BEGIN
    -- Manejo de errores
    BEGIN TRY
        IF @ProductoID IS NULL
        BEGIN
            -- Seleccionar todos los productos si no se proporciona ProductoID
            SELECT ProductoID, Nombre, Precio, Descripcion
            FROM Producto;
        END
        ELSE
        BEGIN
            -- Seleccionar un producto especifico si se proporciona ProductoID
            SELECT ProductoID, Nombre, Precio, Descripcion
            FROM Producto
            WHERE ProductoID = @ProductoID;
        END
    END TRY
    BEGIN CATCH
        -- Manejo del error
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


EXEC LeerProducto;

EXEC LeerProducto @ProductoID = 51;