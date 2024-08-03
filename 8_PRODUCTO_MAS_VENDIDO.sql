-- Selecciona el producto mas vendido basado en la cantidad total de producto vendidos
SELECT TOP 1 P.ProductoID, P.Nombre, SUM(D.Cantidad) AS TotalVendido
FROM Producto P
JOIN DetalleVenta D ON P.ProductoID = D.ProductoID
GROUP BY P.ProductoID, P.Nombre
ORDER BY TotalVendido DESC; -- Ordena por la cantidad total vendida en orden descendente
