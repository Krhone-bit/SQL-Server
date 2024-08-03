-- Selecciona al cliente que compra la mayor cantidad de producto
SELECT TOP 1 C.ClienteID, C.Nombre, C.Apellido, SUM(D.Cantidad) AS TotalComprado
FROM Cliente C
JOIN Venta V ON C.ClienteID = V.ClienteID
JOIN DetalleVenta D ON V.VentaID = D.VentaID
GROUP BY C.ClienteID, C.Nombre, C.Apellido
ORDER BY TotalComprado DESC; -- Ordena por la cantidad total comprada en orden descendente
