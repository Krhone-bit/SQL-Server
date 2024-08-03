SELECT
    P.Nombre AS NombreProducto,
    MP.Metodo AS MetodoPago,
    SUM(DV.Cantidad) AS CantidadVendida,
    CAST(SUM(V.Total) AS NVARCHAR(50)) + ' S/.' AS TotalVentas
FROM
    Venta V
JOIN
	DetalleVenta DV ON V.VentaID = DV.VentaID
JOIN
    Producto P ON DV.ProductoID = P.ProductoID
JOIN
    MetodoPago MP ON V.MetodoPagoID = MP.MetodoPagoID
WHERE
    V.FechaVenta BETWEEN '2024-01-01' AND '2024-07-31'
GROUP BY
    P.Nombre, MP.Metodo
ORDER BY
    TotalVentas DESC;