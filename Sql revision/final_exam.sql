use hr;

#5 Write a query to display last 5 records from Employee table.

select * from employees 
where employee_id > (select max(employee_id) - 5 from employees);

#6.	Write a query to display odd rows in a Student table. 

select * from student
where (rollno%2)=0;

#7.	Write a query to retrieve data of a Employee where Employee doesn’t belong to a department.
select * from employees 
where department_id is null;

#8.	Write a query to fetch all the records from Student table whose joining year is 2018.
select * from student 
where year_of_joining= 2018;

#9.	Write a query to retrieve students who were born in the same city and state where last name is ‘Adams’.

select *
from students
group by city, state
having count(*) > 1 and last_name= 'Adams'


 
 #10a)	Find the employee name who is getting lowest salary
 
 select concat(first_name,' ',last_name) as Name from employees
 order by salary  limit 1;
 
#b)	Find the department name which has highest average salary

select dept_name, avg(Salary) from  Employees 
group by dept_name 
order by Avg(salary) desc limit 1

#c)	Find all the departments where more than 60 employees are working

select dept_name
from employees
group by dept_name
having count(*)> '60'

#d)	Find all the employees whose salary is higher than the average salary of their department.


select first_name, dept_name, salary, avg(salary)
from employees
group by  dept_name, salary
having salary > avg(salary)
