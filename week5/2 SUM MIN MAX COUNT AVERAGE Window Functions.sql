create  database dbase;

USE DBase ;

  
  
  CREATE TABLE RegionalSales
  (
    SalesID INT NOT NULL Auto_Increment PRIMARY KEY,
	  SalesGroup VARCHAR(30) NOT NULL,
	    Country VARCHAR(30) NOT NULL,
		  AnnualSales INT NOT NULL
		  );
		  
		   
		   INSERT INTO RegionalSales 
		     (SalesGroup, Country, AnnualSales)
			 VALUES
			   ('North America', 'United States', 22000),
			     ('North America', 'Canada', 32000),
				   ('North America', 'Mexico', 28000),
				     ('Europe', 'France', 19000),
					   ('Europe', 'Germany', 22000),
					     ('Europe', 'Italy', 18000),
						   ('Europe', 'Greece', 16000),
						     ('Europe', 'Spain', 16000),
							   ('Europe', 'United Kingdom', 32000),
							     ('Pacific', 'Australia', 18000),
								   ('Pacific', 'China', 28000),
								     ('Pacific', 'Singapore', 21000),
									   ('Pacific', 'New Zealand', 18000),
									     ('Pacific', 'Thailand', 17000),
										   ('Pacific', 'Malaysia', 19000),
										     ('Pacific', 'Japan', 22000);
											 
#Aggregate Window Functions

#they support the ORDER BY subclause but optional
#Framing is supported but optional
#Partition By clause is always supported in all kinds of Window Functions
 
select * FROM
	 RegionalSales;

	  
SELECT 
 SalesGroup,
 Country,
 AnnualSales,
   COUNT(AnnualSales) OVER() AS CountryCount,
   SUM(AnnualSales) OVER() AS TotalSales,
   AVG(AnnualSales) OVER() AS AverageSales
FROM
 RegionalSales;

select COUNT(AnnualSales) AS CountryCount,
SUM(AnnualSales) AS TotalSales,
AVG(AnnualSales) AS AverageSales
FROM
	  RegionalSales;

SELECT 
 SalesGroup,
 Country,
 AnnualSales,
   COUNT(AnnualSales) OVER(PARTITION BY SalesGroup) AS CountryCount,
  SUM(AnnualSales) OVER(PARTITION BY SalesGroup) AS TotalSales,
AVG(AnnualSales) OVER(PARTITION BY SalesGroup
   ) AS AverageSales
	FROM
	  RegionalSales;


# After ORDER BY Subclause Default Framing is applied



SELECT 
 SalesGroup,
 Country,
 AnnualSales,
   COUNT(AnnualSales) OVER(PARTITION BY SalesGroup
ORDER BY AnnualSales DESC) AS CountryCount,
  SUM(AnnualSales) OVER(PARTITION BY SalesGroup
     ORDER BY AnnualSales DESC) AS TotalSales,
AVG(AnnualSales) OVER(PARTITION BY SalesGroup
    ORDER BY AnnualSales DESC) AS AverageSales
	FROM
	  RegionalSales;



	
#Default Framing is RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  

SELECT 
 SalesGroup,
   Country,
 AnnualSales,
   COUNT(AnnualSales) OVER(PARTITION BY SalesGroup
ORDER BY AnnualSales DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CountryCount,
  SUM(AnnualSales) OVER(PARTITION BY SalesGroup
      ORDER BY AnnualSales DESC  RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TotalSales
	FROM
	  RegionalSales;

#ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	  SELECT 
 SalesGroup,
   Country,
 AnnualSales,
   COUNT(AnnualSales) OVER(PARTITION BY SalesGroup
ORDER BY AnnualSales DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CountryCount,
  SUM(AnnualSales) OVER(PARTITION BY SalesGroup
      ORDER BY AnnualSales DESC  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TotalSales
	FROM
	  RegionalSales;




SELECT 
 SalesGroup,
 Country,
 AnnualSales,
 COUNT(AnnualSales) OVER(PARTITION BY SalesGroup 
 ORDER BY AnnualSales DESC rows BETWEEN 2 PRECEDING AND CURRENT ROW) AS CountryCount,
 SUM(AnnualSales) OVER(PARTITION BY SalesGroup
 ORDER BY AnnualSales DESC  rows BETWEEN 2 PRECEDING AND CURRENT ROW) AS TotalSales
FROM
	  RegionalSales;


