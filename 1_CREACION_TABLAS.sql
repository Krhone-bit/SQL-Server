-- Crear la base de datos
IF DB_ID('dbCompuCenter') IS NULL
BEGIN
    CREATE DATABASE dbCompuCenter;
END;
GO

-- Usar la base de datos dbCompuCenter
USE dbCompuCenter;
GO

-- Crear tabla Cliente
IF OBJECT_ID('Cliente', 'U') IS NULL
BEGIN
    CREATE TABLE Cliente (
        ClienteID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(50),
        Apellido NVARCHAR(50),
        Email NVARCHAR(100),
        Telefono NVARCHAR(20)
    );
END;
GO

-- Crear tabla Producto
IF OBJECT_ID('Producto', 'U') IS NULL
BEGIN
    CREATE TABLE Producto (
        ProductoID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(100),
        Precio DECIMAL(10, 2),
        Descripcion NVARCHAR(255)
    );
END;
GO

-- Crear tabla MetodoPago
IF OBJECT_ID('MetodoPago', 'U') IS NULL
BEGIN
    CREATE TABLE MetodoPago (
        MetodoPagoID INT IDENTITY(1,1) PRIMARY KEY,
        Metodo NVARCHAR(50)
    );
END;
GO

-- Crear tabla Venta
IF OBJECT_ID('Venta', 'U') IS NULL
BEGIN
    CREATE TABLE Venta (
        VentaID INT IDENTITY(1,1) PRIMARY KEY,
        ClienteID INT,
        FechaVenta DATE,
        Total DECIMAL(10, 2),
        MetodoPagoID INT,
        FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
        FOREIGN KEY (MetodoPagoID) REFERENCES MetodoPago(MetodoPagoID)
    );
END;
GO

-- Crear tabla DetalleVenta
IF OBJECT_ID('DetalleVenta', 'U') IS NULL
BEGIN
    CREATE TABLE DetalleVenta (
        DetalleID INT IDENTITY(1,1) PRIMARY KEY,
        VentaID INT,
        ProductoID INT,
        Cantidad INT,
        Precio DECIMAL(10, 2),
        FOREIGN KEY (VentaID) REFERENCES Venta(VentaID),
        FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
    );
END;
GO
