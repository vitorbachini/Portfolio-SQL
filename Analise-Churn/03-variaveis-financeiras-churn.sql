-- 3. Churn por Variáveis Financeiras;
USE BankCustomers;

--- 3.1. Score de Crédito

WITH CreditScorePercentile AS (
	SELECT DISTINCT
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY CreditScore) OVER () AS Percentile25,
		PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY CreditScore) OVER () AS Percentile50,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CreditScore) OVER () AS Percentile75
	FROM 
		[Customer-Churn-Records]
)

SELECT
	CASE
		WHEN CreditScore < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
		WHEN CreditScore >= p.Percentile25 AND CreditScore < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
		WHEN CreditScore >= p.Percentile50 AND CreditScore < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END AS CreditScoreRange,

	COUNT(CustomerId) AS TotalCustomers,
	COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
	FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

FROM 
	[Customer-Churn-Records] c
CROSS JOIN
	CreditScorePercentile p

GROUP BY
	CASE
		WHEN CreditScore < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
		WHEN CreditScore >= p.Percentile25 AND CreditScore < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
		WHEN CreditScore >= p.Percentile50 AND CreditScore < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END
ORDER BY
	ChurnRate;



--- 3.2. Faixa de Saldo

WITH BalancePercentile AS (
	SELECT DISTINCT
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Balance) OVER () AS Percentile25,
		PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Balance) OVER () AS Percentile50,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Balance) OVER () AS Percentile75
	FROM 
		[Customer-Churn-Records]
)

SELECT
	CASE
		WHEN Balance = 0 THEN 'Zero Balance'
		WHEN Balance > 0 AND Balance < p.Percentile50 THEN CONCAT('1-', p.Percentile50 - 1)
		WHEN Balance >= p.Percentile50 AND Balance < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END AS BalanceRange,

	COUNT(CustomerId) AS TotalCustomers,
	COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
	FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

FROM 
	[Customer-Churn-Records] c
CROSS JOIN
	BalancePercentile p

GROUP BY
	CASE
		WHEN Balance = 0 THEN 'Zero Balance'
		WHEN Balance > 0 AND Balance < p.Percentile50 THEN CONCAT('1-', p.Percentile50 - 1)
		WHEN Balance >= p.Percentile50 AND Balance < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END
ORDER BY
	ChurnRate;

--- 3.3. Faixa de Salário

WITH SalaryPercentile AS (
	SELECT DISTINCT
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY EstimatedSalary) OVER () AS Percentile25,
		PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY EstimatedSalary) OVER () AS Percentile50,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY EstimatedSalary) OVER () AS Percentile75
	FROM 
		[Customer-Churn-Records]
)

SELECT
	CASE
		WHEN EstimatedSalary < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
		WHEN EstimatedSalary >= p.Percentile25 AND EstimatedSalary < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
		WHEN EstimatedSalary >= p.Percentile50 AND EstimatedSalary < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END AS SalaryRange,

	COUNT(CustomerId) AS TotalCustomers,
	COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
	FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

FROM 
	[Customer-Churn-Records] c
CROSS JOIN
	SalaryPercentile p

GROUP BY
	CASE
		WHEN EstimatedSalary < p.Percentile25 THEN CONCAT('0-', p.Percentile25 - 1)
		WHEN EstimatedSalary >= p.Percentile25 AND EstimatedSalary < p.Percentile50 THEN CONCAT(p.Percentile25, '-', p.Percentile50 - 1)
		WHEN EstimatedSalary >= p.Percentile50 AND EstimatedSalary < p.Percentile75 THEN CONCAT(p.Percentile50, '-', p.Percentile75 - 1)
		ELSE CONCAT(p.Percentile75, '+')
	END
ORDER BY
	ChurnRate;