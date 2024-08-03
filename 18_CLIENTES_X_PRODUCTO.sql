-- Selecciona los clientes que compraron un producto espec�fico
SELECT C.ClienteID, C.Nombre, C.Apellido
FROM Cliente C
JOIN Venta V ON C.ClienteID = V.ClienteID
JOIN DetalleVenta D ON V.VentaID = D.VentaID
WHERE D.ProductoID = 1; -- Reemplaza 1 con el ID del producto espec�fico
