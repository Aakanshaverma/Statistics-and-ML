USE  test 




CREATE TABLE   EmployeeDetails (
	 Emp_No   int   primary key,
	 Name   varchar (50) NULL,
	 DOB   varchar (50) NULL,
	 Gender   char (10) NULL,
	 Salary   int  NULL,
	 City   varchar (20) NULL
)





INSERT      
INTO            EmployeeDetails(Emp_No, Name, DOB, Gender, Salary, City)
VALUES     (100,'Mahesh','1965-12-01','Male',30000,'Delhi'),
(101,'Suresh','1963-11-14','Male',34000,'Delhi'),
(102,'Rajat','1969-12-21','Male',23000,'Shimla'),
(103,'Kalpana','1961-12-01','Female',40000,'Goa'),
(104,'Neha','1971-12-01','Female',19000,'Goa'),
(105,'Sunita','1958-12-01','Female',50000,'Delhi')





select * from EmployeeDetails

select name,gender,city from EmployeeDetails

--To display the records in ascending  and descending order

select name,gender,city from EmployeeDetails order by Name

select name,gender,city from EmployeeDetails order by Name desc

select city from EmployeeDetails

Select distinct city from EmployeeDetails

#To display all the employees whose salary is in between 30000 to 40000

select * from EmployeeDetails where (Salary between 30000 and 40000)
--OR
select * from EmployeeDetails where Salary>=30000 and Salary<=40000


# Underscores represents the fixed length & % represents variable length characters
select * from EmployeeDetails where DOB like '196_______'

select * from EmployeeDetails where DOB like '196%'

select * from EmployeeDetails where City in ('Shimla','Goa') 



# Inbuild functions of the sql to calculate maximum,minimum,average,sum etc as salary,as TotalSalary etc are called aliases

select MAX(salary) as Salary from EmployeeDetails;
select AVG(salary) as Average from EmployeeDetails;
select sum(salary) as TotalSalary from EmployeeDetails;
select min(salary) as Minimumsalary from EmployeeDetails;
select COUNT(*) as TotalEmployees from EmployeeDetails;
select COUNT(city) from EmployeeDetails;
SELECT 
    COUNT(DISTINCT city)
FROM
    EmployeeDetails;	
    
    
    
insert into EmployeeDetails (Emp_No, Name, DOB, Gender, City) values(106,'Sunita','1958-12-01','Female','Delhi');

select * from EmployeeDetails;

select COUNT(*) from EmployeeDetails;

select COUNT(Salary) from EmployeeDetails;

select * from EmployeeDetails where Salary=30000

select * from EmployeeDetails where Salary is null;

#For changing the rows of the table we use update command

SET SQL_SAFE_UPDATES=0;

update EmployeeDetails set salary = 30000 where salary is null
update EmployeeDetails set salary = 30000 where Emp_No=104
select * from EmployeeDetails

delete from EmployeeDetails where Salary=30000
delete from  EmployeeDetails where Emp_No=104

#To delete all the records on the table
delete from EmployeeDetails

#To delete the table
drop table EmployeeDetails
    
select  gender, sum(salary) as Total from EmployeeDetails group by gender


select city,gender,count(*) as totalemployees from employeedetails
group by city,gender
order by city;

select distinct city,gender from employeedetails;