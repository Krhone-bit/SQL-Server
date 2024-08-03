-- Primero asegúrate de que no exista una vista con el mismo nombre
IF OBJECT_ID('RegistroTotalTrimestral', 'V') IS NOT NULL
    DROP VIEW RegistroTotalTrimestral;
GO

CREATE VIEW RegistroTotalTrimestral AS
SELECT 
    MAX(TotalRegistrosMayo) AS TOTAL_MAYO, 
    MAX(TotalRegistrosJunio) AS TOTAL_JUNIO,
    MAX(TotalRegistrosJulio) AS TOTAL_JULIO 
FROM (
    SELECT COUNT(1) AS TotalRegistrosMayo, 0 AS TotalRegistrosJunio, 0 AS TotalRegistrosJulio
    FROM Venta
    WHERE FechaVenta BETWEEN '2024-05-01' AND '2024-05-31' -- Mayo tiene 31 días
    UNION ALL
    SELECT 0 AS TotalRegistrosMayo, COUNT(1) AS TotalRegistrosJunio, 0 AS TotalRegistrosJulio
    FROM Venta
    WHERE FechaVenta BETWEEN '2024-06-01' AND '2024-06-30'
    UNION ALL
    SELECT 0 AS TotalRegistrosMayo, 0 AS TotalRegistrosJunio, COUNT(1) AS TotalRegistrosJulio
    FROM Venta
    WHERE FechaVenta BETWEEN '2024-07-01' AND '2024-07-31'
) T;
GO

SELECT * FROM RegistroTotalTrimestral;
