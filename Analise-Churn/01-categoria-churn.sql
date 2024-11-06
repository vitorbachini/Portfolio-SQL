USE BankCustomers;

-- Taxa de Churn Geral;

SELECT 
	COUNT(CustomerId) AS TotalCustomers,
	COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
	FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

FROM 
	[Customer-Churn-Records];


-- 1. Churn por Categoria;

--- 1.1. Gênero
	
	SELECT
		Gender,
		COUNT(CustomerId) AS TotalCustomers,
		COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
		FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate
	
	FROM 
		[Customer-Churn-Records]
	GROUP BY 
		Gender
	ORDER BY
		ChurnRate;


--- 1.2. Idade

WITH AgePercentile AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Age)  OVER () AS Percentile25,
        PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Age)  OVER () AS Percentile50,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Age)  OVER () AS Percentile75
    FROM 
        [Customer-Churn-Records]
)

SELECT
    CASE
        WHEN Age < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
        WHEN Age >= p.Percentile25 AND Age < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
        WHEN Age >= p.Percentile50 AND Age < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
        ELSE CONCAT(p.Percentile75, '+')
    END AS AgeRange,
  
    COUNT(CustomerId) AS TotalCustomers,
    COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
    FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

FROM 
    [Customer-Churn-Records] c
CROSS JOIN
    AgePercentile p
GROUP BY
    CASE
        WHEN Age < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
        WHEN Age >= p.Percentile25 AND Age < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
        WHEN Age >= p.Percentile50 AND Age < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
        ELSE CONCAT(p.Percentile75, '+')
    END
ORDER BY
    AgeRange;


--- 1.3. País

	SELECT
		[Geography] AS Country,
		COUNT(CustomerId) AS TotalCustomers,
		COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
		FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

	FROM 
		[Customer-Churn-Records]
	GROUP BY 
		[Geography]
	ORDER BY
		ChurnRate;