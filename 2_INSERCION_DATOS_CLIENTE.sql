	-- Usar la base de datos dbCompuCenter
	USE dbCompuCenter;
	GO

	-- Funcion para generar nombres aleatorios
	IF OBJECT_ID('dbo.GenerarNombreAleatorio', 'FN') IS NOT NULL
	BEGIN
		DROP FUNCTION dbo.GenerarNombreAleatorio;
	END;
	GO

	CREATE FUNCTION dbo.GenerarNombreAleatorio(@Random INT)
	RETURNS NVARCHAR(50)
	AS
	BEGIN
		DECLARE @Nombres TABLE (Item INT, Nombre NVARCHAR(50));
		INSERT INTO @Nombres VALUES 
		(1, 'Juan'), (2, 'Maria'), (3, 'Pedro'), (4, 'Ana'), (5, 'Luis'), 
		(6, 'Laura'), (7, 'Carlos'), (8, 'Elena'), (9, 'Jorge'), (10, 'Lucia'),
		(11, 'Miguel'), (12, 'Sofia'), (13, 'David'), (14, 'Isabel'), (15, 'Antonio'),
		(16, 'Francisco'), (17, 'Paula'), (18, 'Jesus'), (19, 'Andrea'), (20, 'Manuel'),
		(21, 'Alberto'), (22, 'Marta'), (23, 'Ricardo'), (24, 'Cristina'), (25, 'Adrian'),
		(26, 'Raquel'), (27, 'Sergio'), (28, 'Lorena'), (29, 'Javier'), (30, 'Monica'),
		(31, 'Oscar'), (32, 'Beatriz'), (33, 'Joaquin'), (34, 'Patricia'), (35, 'Mario'),
		(36, 'Nuria'), (37, 'Victor'), (38, 'Claudia'), (39, 'Diego'), (40, 'Angela'),
		(41, 'Fernando'), (42, 'Eva'), (43, 'Ignacio'), (44, 'Silvia'), (45, 'Pablo'),
		(46, 'Sandra'), (47, 'Ruben'), (48, 'Teresa'), (49, 'Eduardo'), (50, 'Veronica');
    
		RETURN (SELECT TOP 1 Nombre FROM @Nombres WHERE Item = @Random);
	END;
	GO

	-- Funcion para generar apellidos aleatorios
	IF OBJECT_ID('dbo.GenerarApellidoAleatorio', 'FN') IS NOT NULL
	BEGIN
		DROP FUNCTION dbo.GenerarApellidoAleatorio;
	END;
	GO

	CREATE FUNCTION dbo.GenerarApellidoAleatorio(@Random INT)
	RETURNS NVARCHAR(50)
	AS
	BEGIN
		DECLARE @Apellidos TABLE (Item INT, Apellido NVARCHAR(50));
		INSERT INTO @Apellidos VALUES 
		(1, 'Perez'), (2, 'Gomez'), (3, 'Rodriguez'), (4, 'Lopez'), (5, 'Martinez'), 
		(6, 'Garcia'), (7, 'Hernandez'), (8, 'Sanchez'), (9, 'Ramirez'), (10, 'Torres'),
		(11, 'Diaz'), (12, 'Fernandez'), (13, 'Moreno'), (14, 'Muñoz'), (15, 'Alvarez'),
		(16, 'Vargas'), (17, 'Ortiz'), (18, 'Ramos'), (19, 'Castillo'), (20, 'Cruz'),
		(21, 'Morales'), (22, 'Rojas'), (23, 'Guerrero'), (24, 'Gutierrez'), (25, 'Salazar'),
		(26, 'Molina'), (27, 'Soto'), (28, 'Paredes'), (29, 'Bravo'), (30, 'Ponce'),
		(31, 'Guzman'), (32, 'Cortez'), (33, 'Reyes'), (34, 'Mendoza'), (35, 'Flores'),
		(36, 'Rivera'), (37, 'Benitez'), (38, 'Miranda'), (39, 'Vasquez'), (40, 'Romero'),
		(41, 'Padilla'), (42, 'Cabrera'), (43, 'Espinoza'), (44, 'Ortiz'), (45, 'Montoya'),
		(46, 'Araya'), (47, 'Chavez'), (48, 'Mejia'), (49, 'Cisneros'), (50, 'Nieves');
    
		RETURN (SELECT TOP 1 Apellido FROM @Apellidos WHERE Item = @Random);
	END;
	GO

	-- Insercion de datos en la tabla Cliente
	DECLARE @NumCliente INT = 10000;
	DECLARE @Nombre NVARCHAR(50);
	DECLARE @Apellido NVARCHAR(50);
	DECLARE @RandomNombre INT;
	DECLARE @RandomApellido INT;
	DECLARE @i INT = 0;

	WHILE @i < @NumCliente
	BEGIN
		SET @RandomNombre = FLOOR(RAND() * 50) + 1;
		SET @RandomApellido = FLOOR(RAND() * 50) + 1;

		SET @Nombre = dbo.GenerarNombreAleatorio(@RandomNombre);
		SET @Apellido = dbo.GenerarApellidoAleatorio(@RandomApellido);

		INSERT INTO Cliente (Nombre, Apellido, Email, Telefono)
		VALUES (@Nombre, @Apellido, LOWER(@Nombre + '.' + @Apellido + '@example.com'), '1234567890');

		SET @i = @i + 1;
	END;
	GO
