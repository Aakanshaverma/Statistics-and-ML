CREATE TABLE   EmployeeDetails (
	 Emp_No   int   primary key,
	 Name   varchar (50) NULL,
	 DOB   varchar (50) NULL,
	 Gender   char (10) NULL,
	 Salary   int  NULL,
	 City   varchar (20) NULL,
     departmentid int
);

create table Department
(departmentid int,departmentname varchar(30))


select * from department


INSERT      
INTO            EmployeeDetails(Emp_No, Name, DOB, Gender, Salary, City,departmentid)
VALUES     (100,'Mahesh','1965-12-01','Male',30000,'Delhi',1),
(101,'Suresh','1963-11-14','Male',34000,'Delhi',2),
(102,'Rajat','1969-12-21','Male',23000,'Shimla',1),
(103,'Kalpana','1961-12-01','Female',40000,'Goa',2),
(104,'Neha','1971-12-01','Female',19000,'Goa',1),
(105,'Sunita','1958-12-01','Female',50000,'Delhi',2)

insert into  Department values (1,'IT'),(2,'Sales')



#Questions

#Return employee record with maximum salary
#Return an emloyee with the highest salary and the employee's department name

select * from employeedetails where salary =(select max(salary) from employeedetails);



select e.emp_no, e.name, d.departmentname 
from employeedetails e 
join department d
on 
e.departmentid=d.departmentid 
where salary =(select max(salary) from employeedetails) 

#Return highest salary, employee_name,Gender,City, department_name for each department

select * from employeedetails A
inner join
(select d.departmentname, d.departmentid, max(salary) as maxsal
from employeedetails e inner join department d
on e.departmentid=d.departmentid
group by d.departmentname, d.departmentid) T
on A.departmentid=T.departmentid and T.MaxSal=A.salary