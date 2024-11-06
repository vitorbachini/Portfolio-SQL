-- 5. Tipo do Cartão e Pontuação de Fidelidade;
USE BankCustomers;

--- 5.1. Tipo do Cartão

	SELECT
		[Card Type],
		COUNT(CustomerId) AS TotalCustomers,
		COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
		FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

	FROM 
		[Customer-Churn-Records]

	GROUP BY 
		[Card Type]
	ORDER BY
		ChurnRate;

--- 5.2. Faixa de Pontuação de Fidelidade

WITH PointEarnedPercentile AS (
	SELECT DISTINCT
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY [Point Earned]) OVER () AS Percentile25,
		PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY [Point Earned]) OVER () AS Percentile50,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY [Point Earned]) OVER () AS Percentile75
	FROM 
		[Customer-Churn-Records]
)

SELECT
	CASE
		WHEN [Point Earned] < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
		WHEN [Point Earned] >= p.Percentile25 AND [Point Earned] < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
		WHEN [Point Earned] >= p.Percentile50 AND [Point Earned] < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END AS PointEarnedRange,

	COUNT(CustomerId) AS TotalCustomers,
	COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
	FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

FROM 
	[Customer-Churn-Records] c
CROSS JOIN
	PointEarnedPercentile p

GROUP BY
	CASE
		WHEN [Point Earned] < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
		WHEN [Point Earned] >= p.Percentile25 AND [Point Earned] < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
		WHEN [Point Earned] >= p.Percentile50 AND [Point Earned] < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END
ORDER BY
	ChurnRate;
