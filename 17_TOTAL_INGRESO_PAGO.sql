-- Compara la cantidad de venta y los ingresos por m�todo de pago
SELECT M.Metodo, COUNT(V.VentaID) AS TotalVenta, SUM(V.Total) AS TotalIngresos
FROM MetodoPago M
JOIN Venta V ON M.MetodoPagoID = V.MetodoPagoID
GROUP BY M.Metodo
ORDER BY TotalVenta DESC;
