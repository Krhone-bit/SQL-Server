-- Calcula el promedio de gasto por cliente
SELECT C.ClienteID, C.Nombre, C.Apellido, AVG(V.Total) AS PromedioGasto
FROM Cliente C
JOIN Venta V ON C.ClienteID = V.ClienteID
GROUP BY C.ClienteID, C.Nombre, C.Apellido;
