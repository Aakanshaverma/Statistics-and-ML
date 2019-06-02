 #Analytical Window Functions
 #Only two analytical functions - FIRST_VALUE AND LAST_VALUE CAN USE FRAMING

 Use DBase;


SELECT 
  SalesGroup,
  Country,
  AnnualSales,
  FIRST_VALUE(AnnualSales) OVER(PARTITION BY SalesGroup
  ORDER BY AnnualSales DESC) AS HighestSales,
  LAST_VALUE(AnnualSales) OVER(PARTITION BY SalesGroup
  ORDER BY AnnualSales DESC) AS LowestSales
FROM
  RegionalSales;



SELECT 
  SalesGroup,
  Country,
  AnnualSales,
  FIRST_VALUE(AnnualSales) OVER(PARTITION BY SalesGroup
  ORDER BY AnnualSales DESC) AS HighestSales,
  LAST_VALUE(AnnualSales) OVER(PARTITION BY SalesGroup
  ORDER BY AnnualSales DESC
  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LowestSales
FROM
   RegionalSales;


SELECT 
  SalesGroup,
  Country,
  AnnualSales,
  LAG(AnnualSales, 1) OVER(PARTITION BY SalesGroup
  ORDER BY AnnualSales DESC) AS PreviousSale,
  LEAD(AnnualSales, 1) OVER(PARTITION BY SalesGroup
  ORDER BY AnnualSales DESC) AS NextSale
FROM
   RegionalSales;
					 






						