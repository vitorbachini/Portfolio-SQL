-- 6. Tempo de Conta;

USE BankCustomers;
WITH TenurePercentile AS (
	SELECT DISTINCT
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Tenure) OVER () AS Percentile25,
		PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Tenure) OVER () AS Percentile50,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Tenure) OVER () AS Percentile75
	FROM 
		[Customer-Churn-Records]
)

SELECT
	CASE
		WHEN Tenure < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
		WHEN Tenure >= p.Percentile25 AND Tenure < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
		WHEN Tenure >= p.Percentile50 AND Tenure < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END AS TenureRange,

	COUNT(CustomerId) AS TotalCustomers,
	COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
	FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

FROM 
	[Customer-Churn-Records] c
CROSS JOIN
	TenurePercentile p

GROUP BY
	CASE
		WHEN Tenure < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
		WHEN Tenure >= p.Percentile25 AND Tenure < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
		WHEN Tenure >= p.Percentile50 AND Tenure < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END
ORDER BY
	ChurnRate;
