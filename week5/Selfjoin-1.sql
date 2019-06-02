USE test;


CREATE TABLE Employee(
	EmpID int,
	EmpName varchar(50) NULL,
	MgrID int NULL
) ;

insert into Employee(EmpID,EmpName) values(1,'ashish');
insert into Employee(EmpID,EmpName,MgrID) values(2,'arun',1),(3,'naveen',1),(4,'sanjay',3),(5,'ankit',3),(6,'rajesh',4);


select * from Employee;
select * from Employee;


select EmpID,EmpName,'No Manager' as Manager from employee where MgrID is null
union 
select e.EmpID,e.EmpName,ifnull(m.EmpName,'No Manager') as Manager
from
employee e  join  employee m
on
e.MgrID=m.EmpID;