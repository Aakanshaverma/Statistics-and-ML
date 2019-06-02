Use hr;

SELECT employee_id, CONCAT(first_name,' ',last_name) AS full_name,
job_title,department_name,salary,IFNULL(commission_pct,0) AS commission_pct,
(salary+ (salary*IFNULL(commission_pct,0)))*12 AS annual_gross_sal
FROM Employees e JOIN Departments d
	 ON e.department_id=d.department_id
JOIN Jobs j
     ON e.job_id=j.job_id
WHERE e.employee_id BETWEEN 140 AND 150;

#if you want to show name in capital

SELECT employee_id, UPPER(CONCAT(first_name,' ',last_name)) AS full_name,
job_title,department_name,salary,IFNULL(commission_pct,0) AS commission_pct,
(salary+ (salary*IFNULL(commission_pct,0)))*12 AS annual_gross_sal
FROM Employees e JOIN Departments d
	 ON e.department_id=d.department_id
JOIN Jobs j
     ON e.job_id=j.job_id
WHERE e.employee_id BETWEEN 140 AND 150;

# display employees with country other than america

SELECT employee_id, CONCAT(first_name,' ',last_name) AS full_name,
job_title,department_name,country_name,salary,IFNULL(commission_pct,0) AS commission_pct,
(salary+ (salary*IFNULL(commission_pct,0)))*12 AS annual_gross_sal
FROM Employees e JOIN Departments d
	 ON e.department_id=d.department_id
JOIN Jobs j
     ON e.job_id=j.job_id
JOIN locations l
     ON d.location_id=l.location_id
JOIN countries c
	 ON l.country_id=c.country_id
WHERE country_name NOT LIKE '%America';


# counts no. of employees in each country
SELECT c.country_name, COUNT(employee_id) AS no_of_emp
FROM Employees e JOIN Departments d
     ON e.department_id=d.department_id
JOIN Locations l
     ON d.location_id=l.location_id
JOIN Countries c
     ON l.country_id=c.country_id
GROUP BY c.country_name

SELECT * FROM  regions JOIN countries;

# to print name of country with more than 10 employees
SELECT c.country_name, COUNT(employee_id) AS no_of_emp
FROM Employees e JOIN Departments d
     ON e.department_id=d.department_id
JOIN Locations l
     ON d.location_id=l.location_id
JOIN Countries c
     ON l.country_id=c.country_id
GROUP BY c.country_name
HAVING COUNT(employee_id) > 10;

SELECT c.country_name, COUNT(employee_id) AS no_of_emp
FROM Employees e JOIN Departments d
     ON e.department_id=d.department_id
JOIN Locations l
     ON d.location_id=l.location_id
JOIN Countries c
     ON l.country_id=c.country_id
GROUP BY c.country_name
HAVING COUNT(employee_id) > 10
AND c.country_name IS NOT NULL;

# having cant have agregate fn so we use where before having

# here it will print no. of emp, country wise and department wise, sorted in decendding order on country name 
SELECT c.country_name,d.department_name, COUNT(employee_id) AS no_of_emp
FROM Employees e JOIN Departments d
     ON e.department_id=d.department_id
JOIN Locations l
     ON d.location_id=l.location_id
RIGHT OUTER JOIN Countries c
     ON l.country_id=c.country_id
#WHERE c.country_name IS NOT NULL
GROUP BY c.country_name,d.department_name
#HAVING COUNT(employee_id) > 1 
ORDER BY c.country_name,no_of_emp DESC;

# still some countries are left, how do we find that??
SELECT c.country_name, IFNULL(d.department_name, 'NO DEPT') AS Department_name,COUNT(employee_id) AS no_of_emp
FROM Employees e RIGHT OUTER JOIN Departments d
     ON e.department_id=d.department_id
     AND e.department_id IS NOT NULL
RIGHT OUTER JOIN Locations l
     ON d.location_id=l.location_id
RIGHT OUTER JOIN Countries c
     ON l.country_id=c.country_id
#WHERE e._name IS NOT NULL
GROUP BY c.country_name,d.department_name
#HAVING COUNT(employee_id) > 1 
ORDER BY no_of_emp DESC,c.country_name;

# SHOW EMPLOYEE ID, FIRST NAME, LAST NAME, MANAGER ID, MANAGER S FIRST AND LAST  NAMe
SELECT e.employee_id, e.first_name, e.last_name, IFNULL(e.manager_id, 'NO MANAGER') AS manager_id, IFNULL(m.first_name,'NA'), IFNULL( m.last_name, 'NA')
FROM Employees e RIGHT OUTER JOIN Employees m 
     ON e.employee_id=m.manager_id;
     
#LIST PEERS OF BRUCE ERNST

SELECT e.employee_id, e.first_name, e.last_name, e.department_id, e.job_id
FROM Employees e JOIN Employees p
     ON e.department_id=p.department_id AND e.job_id=p.job_id AND p.first_name='Bruce' AND p.last_name='Ernst'
WHERE e.first_name!= 'Bruce'


#list peers of shanta vollman who draws higher salary than her

SELECT e.*
FROM Employees e JOIN Employees p
     ON e.department_id=p.department_id AND e.job_id=p.job_id AND p.first_name='Shanta' AND p.last_name='Vollman'
WHERE e.first_name!= 'Shanta' AND e.salary> p.salary;

SELECT e.employee_id, p.first_name, p.last_name, p.salary,e.salary, e.department_id,p.department_id,e.job_id
from Employees e JOIN Employees p
ON e.department_id=p.department_id AND e.job_id=p.job_id
AND e.first_name='Kevin'
AND e.salary<=p.salary
ORDER BY 2;


#show all the employees with duplicate first names/ SAME JOB ID/ SALARY

SELECT first_name, COUNT(first_name)
FROM Employees 
GROUP BY first_name
HAVING COUNT(first_name)>1 ORDER BY 2 DESC;

SELECT salary, COUNT(salary)
FROM Employees 
GROUP BY salary
HAVING COUNT(salary)>1 ORDER BY 2 DESC;



SELECT COUNT(*), COUNT(	employee_id), COUNT(department_id), COUNT(commission_pct)
FROM employees


SELECT COUNT(*), COUNT(	employee_id), COUNT(department_id), COUNT(commission_pct), COUNT(DISTINCT department_id)
FROM employees;

DESC employees;

SELECT MAX(hire_date) FROM EMPLOYEES

# PRINT YEARS OF EXPERIENCE OF EMPLOYEES
SELECT 	employee_id, first_name, last_name, hire_date,salary,
ROUND(DATEDIFF(CURRENT_DATE(), hire_date)/365,2) AS Years_of_Service
FROM Employees ORDER BY hire_date DESC;

# PRINT EMPLOYEES WITH EXP>20YRS

SELECT 	employee_id, first_name, last_name, hire_date,
ROUND(DATEDIFF(CURRENT_DATE(), hire_date)/365,2) AS Years_of_Service
FROM Employees 
WHERE ROUND(DATEDIFF(CURRENT_DATE(), hire_date)/365,2)>20
ORDER BY hire_date DESC;


SELECT 	employee_id, first_name, last_name, hire_date,salary,
FLOOR(salary/500) AS 500_reqd,
MOD(salary, 500) as remaining_amt
FROM Employees;


SELECT 	employee_id, first_name, last_name, hire_date,salary,
FLOOR(salary/500) AS 500_reqd,
MOD(salary, 500) as remaining_amt1
FLOOR(remaining_amt1/200) AS 200_reqd,
FROM Employees;


SELECT ROUND(123.456), ROUND(123.456,1),ROUND(123.456,2),ROUND(123.456,-1),ROUND(123.456,-2),ROUND(150,-2);



SELECT 	employee_id, first_name, last_name, LOWER(CONCAT(REPLACE(last_name,' ',''), SUBSTR(first_name,1,1))) AS new_email
FROM employees;

SELECT	first_name, SUBSTR(first_name,-1) FROM employees;

#EXTRACT FIRST NAMES WHICH END WITH VOWELS
SELECT first_name, last_name, LENGTH(last_name) FROM employees
WHERE SUBSTR(first_name,-1) IN ('a','e','i','o','u')
AND SUBSTR(last_name,-1) IN ('a','e','i','o','u');


SELECT employee_id,first_name, last_name,LENGTH(CONCAT(first_name,'',last_name))
FROM Employees
WHERE (LENGTH(CONCAT(first_name,'',last_name)))=MAX(LENGTH(CONCAT(first_name,'',last_name)));

SELECT CONCAT(first_name,' ',last_name) AS full_name,
LENGTH(CONCAT(first_name,' ',last_name)) AS name_len,
CASE
    WHEN LENGTH(CONCAT(first_name,' ',last_name))=(SELECT MAX(LENGTH(CONCAT(first_name,' ',last_name))) FROM EMPLOYEES )THEN 'MAX_LEN'
    WHEN LENGTH(CONCAT(first_name,' ',last_name))=(SELECT MIN(LENGTH(CONCAT(first_name,' ',last_name))) FROM EMPLOYEES) THEN 'MIN_LEN'
END AS len_spec
FROM Employees
WHERE LENGTH(CONCAT(first_name,' ',last_name))=(SELECT MAX(LENGTH(CONCAT(first_name,' ',last_name))) FROM EMPLOYEES ) 
OR 
LENGTH(CONCAT(first_name,' ',last_name))= (SELECT MIN(LENGTH(CONCAT(first_name,' ',last_name))) FROM EMPLOYEES)
ORDER BY 2;



#WHAT IS THE AVG SALARY RANGE(DIFF BTW MIN AND MAX SALARY) OF ALL TYPES OF MANAGERS AND CLERKS 
#OP: ROLE, ABG SAL RANGE DIFFERENCE

# to print employee role and avg salary range
SELECT * FROM jobs;

SELECT * FROM employees

Select e.employee_id,e.salary, IFNULL(m.manager_id, 'no manager') AS manager_id, m.salary, j.job_id, avg(j.max_salary-j.min_salary)
from employees e join employees m
on e.employee_id=m.employee_id and e.manager_id=m.manager_id
join jobs j
on m.job_id=j.job_id;



SELECT SUBSTR(job_title,-7), AVG(max_salary-min_salary)
FROM jobs
WHERE job_title LIKE '%Manager' OR job_title LIKE '%Clerk'
GROUP BY SUBSTR(job_title,-7);

SELECT SUBSTR(job_title,-8), AVG(max_salary-min_salary)
FROM jobs
WHERE job_title LIKE '%Manager' 
GROUP BY SUBSTR(job_title,-8);



SELECT job_title, INSTR(job_title,'Manager'), avg(max_salary-min_salary)
FROM jobs
WHERE job_title LIKE '%Manager' 
GROUP BY INSTR(job_title,'Manager');


#case function

SELECT employee_id, first_name, last_name, salary,
CASE 
     WHEN salary<5000 THEN 'LOW'
     WHEN salary BETWEEN 5000 AND 10000 THEN 'MEDIUM'
     WHEN salary>10000 THEN 'HIGH'
END AS sal_level
FROM Employees;


SELECT CASE
           WHEN INSTR(job_title, 'Manager')>0 THEN 'Manager'
           WHEN INSTR(job_title, 'Clerk')>0 THEN 'Clerk'
           WHEN INSTR(job_title, 'Rep')>0 THEN 'Representative'
           ELSE 'Others'
END AS emp_role,
AVG(max_salary-min_salary) AS avg_sal_range
FROM Jobs
GROUP BY emp_role ORDER BY emp_role;


# extract emp id salary and cumulative salary

Select employee_id, salary, 	






#departments where employees are working using sub query
Select * from Departments
Where department_id in 
(select department_id from employees);
 
 
 # print employee salary more than avg sal
Select * from Departments
Where department_id not in 
(select department_id from employees where department_id IS NOT NULL);
#OR


Select * from Departments
Where department_id not in 
(select IFNULL(department_id,0) from employees);


# print salary of emp more than avg salary within their dept, used correlated sub query
SELECT employee_id, first_name, last_name, salary, department_id
from employees e
where salary> (select avg(salary) from employees where department_id = e.department_id )
order by department_id, employee_id