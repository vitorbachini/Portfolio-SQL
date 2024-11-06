-------------------------------------------------

			-- Consultas Avançadas -- 

-------------------------------------------------

-- 1. Identificar os 5 funcionários que mais venderam no ano de 2013;

USE AdventureWorksDW2019;

SELECT TOP 5
	s.EmployeeKey,
	e.FirstName,
	e.LastName,
	SUM(s.SalesAmount) AS 'Total_Vendas',
	YEAR(s.OrderDate)  AS 'Ano'

FROM 
	FactResellerSales AS s
JOIN 
	DimEmployee       AS e
ON 
	s.EmployeeKey = e.EmployeeKey

WHERE 
	YEAR(s.OrderDate) = 2013
GROUP BY 
	s.EmployeeKey, YEAR(s.OrderDate), e.FirstName, e.LastName
ORDER BY 
	SUM(s.SalesAmount) DESC;


-- 2. Identificar quais regiões realizaram mais compras a fim de determinar o público alvo;

SELECT
	s.SalesTerritoryKey,
	t.SalesTerritoryRegion,
	t.SalesTerritoryCountry,
	t.SalesTerritoryGroup,
	COUNT(s.SalesAmount) AS 'Qtd_Vendas'

FROM 
	FactResellerSales AS s
JOIN 
	DimSalesTerritory AS t
ON 
	s.SalesTerritoryKey = t.SalesTerritoryKey

GROUP BY
	s.SalesTerritoryKey, t.SalesTerritoryRegion, t.SalesTerritoryCountry, t.SalesTerritoryGroup
ORDER BY 
	COUNT(s.SalesAmount) DESC;

-- 3. Identificar a quantidade de vendas por região a partir de um produto específico, com o objetivo de analisar a distribuição de vendas de um determinado produto;

SELECT
	s.ProductKey,
	p.EnglishProductName,
	s.SalesTerritoryKey,
	t.SalesTerritoryRegion,
	t.SalesTerritoryCountry,
	COUNT(s.SalesAmount) AS 'Qtd_Vendas'

FROM 
	FactResellerSales AS s
JOIN 
	DimSalesTerritory AS t
ON 
	s.SalesTerritoryKey = t.SalesTerritoryKey
JOIN 
	DimProduct        AS p
ON 
	s.ProductKey = p.ProductKey

WHERE 
	s.ProductKey = 270 -- chave do produto
GROUP BY
	s.ProductKey, p.EnglishProductName, s.SalesTerritoryKey, t.SalesTerritoryRegion, t.SalesTerritoryCountry
ORDER BY 
	COUNT(s.SalesAmount) DESC;


-- 4. Realizar o ranqueamento das lojas parceiras revendedoras que mais realizaram vendas;

SELECT *
FROM(
	SELECT
		r.ResellerKey,
		r.ResellerName,
		COUNT(s.SalesAmount) AS 'Qtd_Vendas',
		DENSE_RANK() OVER (ORDER BY COUNT(s.SalesAmount) DESC) AS 'Ranking_Vendas'

	FROM 
		DimReseller       AS r
	JOIN 
		FactResellerSales AS s
	ON 
		r.ResellerKey = s.ResellerKey

	GROUP BY 
		r.ResellerKey, r.ResellerName
) AS SalesData
WHERE 
	Ranking_Vendas BETWEEN 1 AND 10;


-- 5. Criar uma CTE (Common Table Expression) a fim de facilitar as buscas relacionadas a vendas e regiões;

WITH RegionSalesSummary AS (
	SELECT
	s.ProductKey,
	p.EnglishProductName,
	s.SalesTerritoryKey,
	t.SalesTerritoryRegion,
	t.SalesTerritoryCountry,
	t.SalesTerritoryGroup,
	s.SalesAmount

	FROM 
		FactResellerSales AS s
	JOIN 
		DimSalesTerritory AS t
	ON 
		s.SalesTerritoryKey = t.SalesTerritoryKey
	JOIN 
		DimProduct        AS p
	ON 
		s.ProductKey = p.ProductKey
)

SELECT
	SalesTerritoryKey,
	SalesTerritoryRegion,
	SalesTerritoryCountry,
	SalesTerritoryGroup,
	COUNT(SalesAmount) AS 'Qtd_Vendas'

FROM 
	RegionSalesSummary
GROUP BY
	SalesTerritoryKey, 
	SalesTerritoryRegion, 
	SalesTerritoryCountry, 
	SalesTerritoryGroup
ORDER BY 
	Qtd_Vendas DESC;