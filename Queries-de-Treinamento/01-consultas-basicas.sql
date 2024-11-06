-------------------------------------------------

			-- Consultas Básicas -- 

-------------------------------------------------

-- Realizando consultas na tabela de vendas, a fim de extrair informações relevantes para o negócio.

-- 1. Realizar uma consulta inicial, para conhecer a tabela;

USE AdventureWorksDW2019;
Select TOP 10 *
FROM 
	FactResellerSales;


-- 2. Identificar e ordenar os produtos que tiveram vendas a cima de 20.000;

SELECT
	ProductKey,
	SalesAmount

FROM 
	FactResellerSales
WHERE 
	SalesAmount > 20000
ORDER BY 
	SalesAmount DESC;


-- 3. Descobrir a quantidade de vendas que cada produto teve;

SELECT
	ProductKey,
	COUNT(ProductKey) AS 'Qtd_Vendas'

FROM 
	FactResellerSales
GROUP BY 
	ProductKey
ORDER BY 
	COUNT(ProductKey) DESC;


-- 4. Selecionar os 10 produtos que tiveram o maior total em vendas;

SELECT TOP 10
	ProductKey,
	SUM(SalesAmount) AS 'Total_Vendido'

FROM 
	FactResellerSales
GROUP BY 
	ProductKey
ORDER BY
	SUM(SalesAmount) DESC;


-- 5. Descobrir qual foi a média de vendas do ano de 2012 por cada mês;

SELECT
	MONTH(OrderDate) AS 'Mes',
	AVG(SalesAmount) AS 'Media_Vendas'

FROM 
	FactResellerSales
WHERE 
	YEAR(OrderDate) = 2012
GROUP BY 
	MONTH(OrderDate)
ORDER BY 
	MONTH(OrderDate) ASC;

-- 6. Selecionar o total de vendas por dia no mês de outubro de 2012;

SELECT
	DAY(OrderDate) AS 'Dia',
	SUM(SalesAmount) AS 'Total_Vendas'

FROM 
	FactResellerSales
WHERE 
	YEAR(OrderDate) = 2012 
AND   
	MONTH(OrderDate) = 10
GROUP 
	BY DAY(OrderDate)
ORDER BY 
	DAY(OrderDate);


-- 7. Descobrir qual foi o produto com o maior total em vendas em 2011;

SELECT
	ProductKey,
	YEAR(OrderDate) AS 'Ano',
	SUM(SalesAmount) AS 'Total_Vendas'

FROM 
	FactResellerSales
WHERE 
	YEAR(OrderDate) = 2011
GROUP BY 
	ProductKey, YEAR(OrderDate)
ORDER BY 
	SUM(SalesAmount) DESC;


-- 8. Identificar os produtos que tenham tido 400 vendas ou mais;

SELECT
	ProductKey,
	COUNT(SalesAmount) AS 'Qtd_Vendas'

FROM 
	FactResellerSales
GROUP BY 
	ProductKey
HAVING 
	COUNT(SalesAmount) >= 400
ORDER BY 
	COUNT(SalesAmount) ASC;