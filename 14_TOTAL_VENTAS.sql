-- Calcula el total de venta en el periodo de actividad baja (Enero)
SELECT SUM(Total) AS TotalBaja
FROM Venta
WHERE FechaVenta BETWEEN '2024-05-01' AND '2024-05-31';
--WHERE FechaVenta BETWEEN '2023-01-01' AND '2023-05-31';


--SELECT * FROM Venta;
-- Calcula el total de venta en el periodo de actividad normal (Febrero)
SELECT SUM(Total) AS TotalNormal
FROM Venta
WHERE FechaVenta BETWEEN '2024-06-01' AND '2024-06-28';
-- Calcula el total de venta en el periodo de actividad alta (Marzo)
SELECT SUM(Total) AS TotalAlta
FROM Venta
WHERE FechaVenta BETWEEN '2024-07-01' AND '2024-07-30';

SELECT COUNT(*) FROM Venta WHERE FechaVenta BETWEEN '2024-05-01' AND '2024-05-31';
SELECT COUNT(*) FROM Venta WHERE FechaVenta BETWEEN '2024-06-01' AND '2024-06-28';
SELECT COUNT(*) FROM Venta WHERE FechaVenta BETWEEN '2024-07-01' AND '2024-07-31';
