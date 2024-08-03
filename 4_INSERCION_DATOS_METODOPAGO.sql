-- Usar la base de datos dbCompuCenter
USE dbCompuCenter;
GO

-- Insercion de datos en MetodoPago
INSERT INTO MetodoPago (Metodo)
VALUES ('Tarjeta de Credito'), ('Tarjeta de Debito'), ('Efectivo'), ('Transferencia Bancaria'), ('Paypal');
GO

