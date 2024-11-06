-- 2. Churn por Ades�o aos Produtos;
USE BankCustomers;

--- 2.1. N�mero de Produtos

	SELECT
		NumOfProducts,
		COUNT(CustomerId) AS TotalCustomers,
		COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
		FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

	FROM 
		[Customer-Churn-Records]
	GROUP BY 
		NumOfProducts
	ORDER BY
		ChurnRate;

--- 2.2. Possui Cart�o de Cr�dito

	SELECT
		HasCrCard,
		COUNT(CustomerId) AS TotalCustomers,
		COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
		FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

	FROM 
		[Customer-Churn-Records]
	GROUP BY 
		HasCrCard
	ORDER BY
		ChurnRate;

--- 2.3. Cliente Ativo
	
	SELECT
		IsActiveMember,
		COUNT(CustomerId) AS TotalCustomers,
		COUNT(CASE WHEN Exited = 1 THEN 1 END) AS ChurnedCustomers,
		FORMAT((COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0) / COUNT(CustomerId), 'N2') AS ChurnRate

	FROM 
		[Customer-Churn-Records]
	GROUP BY 
		IsActiveMember
	ORDER BY
		ChurnRate;