-- Cantidad De Clientes Por Mes
SELECT FORMAT(V.FechaVenta, 'MMMM') FechaVenta, C.Nombre, COUNT(*) CantidadClientes FROM 
Venta V
JOIN Cliente C ON V.ClienteID = C.ClienteID
Group By V.FechaVenta, C.Nombre
HAVING COUNT(C.Nombre)>1;

-- Cantidad De Clientes Por Mes
SELECT T.FechaVenta, SUM(CantidadClientes) TotalCatidadDeClientes FROM (
SELECT FORMAT(V.FechaVenta, 'MMMM') FechaVenta, C.Nombre, COUNT(*) CantidadClientes FROM 
Venta V
JOIN Cliente C ON V.ClienteID = C.ClienteID
Group By V.FechaVenta, C.Nombre
HAVING COUNT(C.Nombre)>1)
T GROUP BY FechaVenta;
