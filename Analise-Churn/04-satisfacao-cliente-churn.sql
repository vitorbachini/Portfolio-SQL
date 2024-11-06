-- 4. Experi�ncia e Satisfa��o do Cliente;
USE BankCustomers;

--- 4.1. Score de Satisfa��o

	SELECT
		[Satisfaction Score],
		COUNT(CustomerId) AS TotalCustomers,
		COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
		FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

	FROM 
		[Customer-Churn-Records]

	GROUP BY 
		[Satisfaction Score]
	ORDER BY
		ChurnRate;

--- 4.2. Reclama��es
	
	SELECT
		Complain,
		COUNT(CustomerId) AS TotalCustomers,
		COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
		FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

	FROM 
		[Customer-Churn-Records]
	
	GROUP BY 
		Complain
	ORDER BY
		ChurnRate;