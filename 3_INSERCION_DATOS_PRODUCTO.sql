-- Usar la base de datos dbCompuCenter
USE dbCompuCenter;
GO

-- Funcion para generar producto aleatorios
IF OBJECT_ID('dbo.GenerarProductoAleatorio', 'FN') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.GenerarProductoAleatorio;
END;
GO

CREATE FUNCTION dbo.GenerarProductoAleatorio(@Random INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Producto TABLE (Item INT, Producto NVARCHAR(100));
    INSERT INTO @Producto VALUES 
    (1, 'Laptop'), (2, 'PC de Escritorio'), (3, 'Tablet'), (4, 'Monitor'), 
    (5, 'Teclado'), (6, 'Mouse'), (7, 'Impresora'), (8, 'Auriculares'), 
    (9, 'Cámara Web'), (10, 'Disco Duro Externo'),
    (11, 'Tarjeta Gráfica'), (12, 'Procesador'), (13, 'Memoria RAM'), (14, 'SSD'), 
    (15, 'Fuente de Alimentación'), (16, 'Caja de PC'), (17, 'Refrigeración Líquida'), (18, 'Altavoces'),
    (19, 'Micrófono'), (20, 'Ruteador'), (21, 'Switch de Red'), (22, 'Cable HDMI'),
    (23, 'Mousepad'), (24, 'Teclado Mecánico'), (25, 'USB Flash Drive'), (26, 'Cámara de Seguridad'),
    (27, 'Proyector'), (28, 'Smartphone'), (29, 'Tablet'), (30, 'Smartwatch'),
    (31, 'Reloj Inteligente'), (32, 'TV Smart'), (33, 'Blu-ray Player'), (34, 'Home Theater'),
    (35, 'VR Headset'), (36, 'Fitness Tracker'), (37, 'Gaming Console'), (38, 'Gamepad'),
    (39, 'Joystick'), (40, 'Volante de Carreras'), (41, 'Joystick de Vuelo'), (42, 'Mouse Inalámbrico'),
    (43, 'Cámara DSLR'), (44, 'Cámara Mirrorless'), (45, 'Lente de Cámara'), (46, 'Trípode'),
    (47, 'Gimbal'), (48, 'Drone'), (49, 'Micrófono de Condensador'), (50, 'Interfaz de Audio');
    
    RETURN (SELECT TOP 1 Producto FROM @Producto WHERE Item = @Random);
END;
GO

-- Insercion de datos en la tabla Producto
DECLARE @NumProducto INT = 50;
DECLARE @Producto NVARCHAR(100);
DECLARE @Precio DECIMAL(10, 2);
DECLARE @RandomProducto INT;
DECLARE @i INT = 0;

WHILE @i < @NumProducto
BEGIN
    SET @RandomProducto = FLOOR(RAND() * 50) + 1;
    SET @Producto = dbo.GenerarProductoAleatorio(@RandomProducto);
    SET @Precio = CAST(RAND() * (2000 - 100 + 1) + 100 AS DECIMAL(10, 2));

    INSERT INTO Producto (Nombre, Precio, Descripcion)
    VALUES (@Producto, @Precio, @Producto + ' de alta calidad');

    SET @i = @i + 1;
END;
GO
