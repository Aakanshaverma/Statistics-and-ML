USE test;




CREATE TABLE Product(
	ProductId int NOT NULL,
	PName varchar(50) NULL,
	SID int NULL,
    Primary Key (ProductId)
 )



insert into Product(ProductId,PName,SID) values(1,'Keyboard',1),(2,'Monitor',2),(3,'AC',2),(4,'Bikes',3),(5,'Bulb',3),(6,'Processor',7)



CREATE TABLE Supplier(
	SupplierID int NULL,
	CompanyName varchar(50) NULL
) 



insert into Supplier values(1,'TVSGold'),(2,'LG'),(3,'Bajaj'),(4,'Maruti'),(5,'Orient'),(6,'Tata')


select * from product;
select * from supplier

select product.*,supplier.companyname
from
product inner join supplier
on
product.sid=supplier.supplierID


select p.*,s.companyname
from
product p  inner join supplier s
on
p.sid=s.supplierID
where productid<3

select p.*,s.companyname
from
product p  right outer join supplier s
on
p.sid=s.supplierID



select s.companyname
from
product p  right outer join supplier s
on
p.sid=s.supplierID
where 
p.PName is Null




select p.*,s.companyname
from
product p  cross join supplier s






