USE Warehouse
GO

DECLARE @test TABLE(x VARCHAR(20));
INSERT INTO @test (x)
    SELECT '+91 (876) 098 6789' UNION ALL
    SELECT '1-567-987-7655' UNION ALL
    SELECT 'FR5-5105';

WITH
    Num1 (n) AS (SELECT 1 UNION ALL SELECT 1),
    Num2 (n) AS (SELECT 1 FROM Num1 AS X, Num1 AS Y),
    Num3 (n) AS (SELECT 1 FROM Num2 AS X, Num2 AS Y),
    Num4 (n) AS (SELECT 1 FROM Num3 AS X, Num3 AS Y),
    Nums (n) AS (SELECT ROW_NUMBER() OVER(ORDER BY n) FROM Num4),
    Cleaner AS (
        SELECT x
        ,   (SELECT
                CASE
                    WHEN SUBSTRING(x, n, 1) NOT LIKE '[^0-9]'
                        THEN SUBSTRING(x, n, 1)
                    ELSE ''
                END + ''
            FROM Nums
            WHERE n <= LEN(x)
            FOR XML PATH('')) AS x_clean
        FROM @test)
SELECT x, x_clean
FROM Cleaner;