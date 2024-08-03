-- Calcula los ingresos totales por mes
SELECT MONTH(FechaVenta) AS Mes, SUM(Total) AS Ingresos
FROM Venta
GROUP BY MONTH(FechaVenta)
ORDER BY Mes;

SELECT * FROM RegistroTotalTrimestral;

