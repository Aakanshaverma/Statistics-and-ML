USE test;


CREATE TABLE RankTest1(
	Name varchar(50) NULL,
	Sales int NULL,
	Location nchar(10) NULL
) 
;

INSERT INTO RankTest1
           (Name
           ,Sales
           ,Location)
     VALUES
           ('John',10000,'North'),('Mohit',12000,'North'),('Sagar',15000,'South'),('Nitin',10000,'North'),('Pooja',11000,'South')
;

select * from RankTest1



select name,sales,location,RANK() over (partition by location order by sales asc) as SalesRank from RankTest1

select name,sales,location,DENSE_RANK() over (partition by location order by sales asc) as SalesRank from RankTest1

select name,sales,location,row_number() over (partition by location order by sales asc) as RowNumber from RankTest1

select row_number() over (order by sales asc) as RowNumber,name,sales,location from RankTest1
select row_number() over (partition by location order by sales asc) as RowNumber,name,sales,location from RankTest1

select ntile(2) over (partition by location order by sales asc) as RowNumber,name,sales,location from RankTest1



