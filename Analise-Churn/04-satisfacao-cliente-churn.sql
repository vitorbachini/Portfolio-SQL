-- 4. Experiência e Satisfação do Cliente;
USE BankCustomers;

--- 4.1. Score de Satisfação

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

--- 4.2. Reclamações
	
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