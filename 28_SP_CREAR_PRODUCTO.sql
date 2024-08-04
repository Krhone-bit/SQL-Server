
-- Creacion del procedimiento almacenado para registrar un nuevo producto
CREATE PROCEDURE SPRegistrarProducto
    @Nombre NVARCHAR(100),
    @Precio DECIMAL(10, 2),
    @Descripcion NVARCHAR(255) = NULL
AS
BEGIN
    -- Comienza una transaccion
    BEGIN TRANSACTION;

    -- Manejo de errores
    BEGIN TRY
        -- Insercion del nuevo producto en la tabla Producto
        INSERT INTO Producto (Nombre, Precio, Descripcion)
        VALUES (@Nombre, @Precio, @Descripcion);

        -- Confirmar la transaccion si no hay errores
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- En caso de error, deshacer la transaccion
        ROLLBACK TRANSACTION;

        -- Opcional: Manejo del error
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO



EXEC RegistrarProducto @Nombre = 'Monitor', @Precio = 150.00, @Descripcion = 'Monitor de 24 pulgadas';

SELECT * FROM Producto WHERE Nombre ='Monitor';