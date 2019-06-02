USE HR;

SELECT employee_id, UPPER(CONCAT(first_name, ' ', last_name)) AS full_name,
job_title, e.department_id, department_name, salary,
IFNULL(commission_pct, 0.02) AS commission_pct,
(salary + (salary * IFNULL(commission_pct, 0))) * 12 AS annual_gross_sal
FROM Employees e JOIN Departments d ON e.department_id = d.department_id
JOIN Jobs j ON e.job_id = j.job_id
WHERE e.employee_id BETWEEN 140 AND 150;

SELECT employee_id, UPPER(CONCAT(first_name, ' ', last_name)) AS full_name,
job_title, e.department_id, department_name, c.country_name, salary,
IFNULL(commission_pct, 0.02) AS commission_pct,
(salary + (salary * IFNULL(commission_pct, 0))) * 12 AS annual_gross_sal
FROM Employees e JOIN Departments d ON e.department_id = d.department_id
JOIN Jobs j ON e.job_id = j.job_id
JOIN Locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE country_name NOT LIKE '%America';


# BETTER QUERY
SELECT c.country_name, COUNT(employee_id) AS no_of_emp
FROM Employees e JOIN Departments d ON e.department_id = d.department_id
JOIN Locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE d.department_id IS NOT NULL 
GROUP BY c.country_name HAVING COUNT(employee_id)>10;
# NOT BETTER BECAUSE FIRST JOINED, SPACE AND MEMORY AND TIME USED AND THEN FILTERING
# THUS FILTERING FIRST AND THEN JOIN TO SAVE ALL ABOVE
SELECT c.country_name, COUNT(employee_id) AS no_of_emp
FROM Employees e JOIN Departments d ON e.department_id = d.department_id
JOIN Locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id 
GROUP BY c.country_name HAVING COUNT(employee_id)>10
AND c.country_name IS NOT NULL;

SELECT c.country_name, d.department_name, COUNT(employee_id) AS no_of_emp
FROM Employees e JOIN Departments d ON e.department_id = d.department_id
JOIN Locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE d.department_id IS NOT NULL 
GROUP BY c.country_name, d.department_name HAVING COUNT(employee_id)>1
ORDER BY c.country_name ASC, no_of_emp DESC;

SELECT c.country_name, IFNULL(d.department_name, 'No dept.') AS dept_name, COUNT(employee_id) AS no_of_emp
FROM Employees e RIGHT OUTER JOIN Departments d ON e.department_id = d.department_id AND e.department_id IS NOT NULL
RIGHT OUTER JOIN Locations l ON d.location_id = l.location_id
RIGHT OUTER JOIN countries c ON l.country_id = c.country_id
GROUP BY c.country_name, d.department_name ORDER BY no_of_emp DESC, country_name;

# SELF JOIN 
SELECT e.employee_id, e.first_name, e.last_name,
IFNULL(e.manager_id,'No Manager') AS 'manager_id', IFNULL(m.first_name,'NA') AS 'manager_frist_ame', IFNULL(m.last_name,'NA') AS 'manager_last_name'
FROM Employees e LEFT JOIN Employees m ON e.manager_id = m.employee_id;
# OR
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.manager_id, e2.first_name, e2.last_name
FROM Employees AS e1, Employees AS e2 WHERE e1.manager_id = e2.employee_id;

# FIND PEERS OF BRUCE
SELECT p.*
FROM Employees e JOIN Employees p
ON e.department_id = p.department_id AND e.job_id = p.job_id
WHERE e.employee_id = 104 AND p.employee_id NOT IN (104);
# OR
SELECT p.*
FROM Employees AS e, Employees AS p
WHERE e.department_id = p.department_id AND e.job_id = p.job_id AND e.employee_id = 104 AND p.employee_id NOT IN (104);

# FIND PEERS OF SHANTA VOLLMAN WHO DRAW SAME OR HIGHER SALARY THAN HER
SELECT p.*, e.salary AS 'Shanta`s salary'
FROM Employees e JOIN Employees p
ON e.department_id = p.department_id AND e.job_id = p.job_id
WHERE e.first_name = 'Shanta' AND e.last_name = 'Vollman' AND e.salary <= p.salary
AND p.first_name != 'Shanta' AND p.last_name != 'Vollman';

SELECT p.employee_id, p.first_name, p.last_name, p.salary, e.salary
FROM Employees e JOIN Employees p
ON e.department_id = p.department_id AND e.job_id = p.job_id
AND e.first_name = 'Kevin' AND e.salary <= p.salary
WHERE p.first_name != 'Kevin'; ##### DOUBT

SELECT first_name, COUNT(first_name)
FROM Employees
GROUP BY first_name HAVING COUNT(first_name)>1
ORDER BY 2 DESC;

SELECT COUNT(*), COUNT(employee_id), COUNT(department_id), COUNT(commission_pct) FROM Employees;
SELECT COUNT(*), COUNT(employee_id), COUNT(department_id), COUNT(DISTINCT department_id), COUNT(commission_pct) FROM Employees;
# So any Column that is stated as NOT NULL will give same count as * and PK.
# To see which describe the table 
DESCRIBE Employees;

# MIN, MAX FUNCTIONS
SELECT MIN(first_name), MAX(first_name), MIN(hire_date), MAX(hire_date) FROM Employees;

# DATE FUNCTIONS
SELECT employee_id, first_name, hire_date,
DATEDIFF(CURRENT_DATE(),hire_date) AS days_of_service
FROM Employees ORDER BY hire_date;

SELECT employee_id, first_name, hire_date,
ROUND(DATEDIFF(CURRENT_DATE(),hire_date)/365,2) AS yrs_of_service
FROM Employees ORDER BY hire_date DESC LIMIT 10;

# CANNOT USE the alias name in where clause because it is executed first 
SELECT employee_id, first_name, hire_date,
ROUND(DATEDIFF(CURRENT_DATE(),hire_date)/365,2) AS yrs_of_service
FROM Employees WHERE yrs_of_service > 20
ORDER BY hire_date DESC LIMIT 10; ##### ON PURPOSE ERROR
# THUS 
SELECT employee_id, first_name, hire_date,
ROUND(DATEDIFF(CURRENT_DATE(),hire_date)/365,2) AS yrs_of_service
FROM Employees WHERE ROUND(DATEDIFF(CURRENT_DATE(),hire_date)/365,2) > 20
ORDER BY hire_date DESC LIMIT 10;
# HOWEVER ORDER BY is executed in the end thus we can use alias there
SELECT employee_id, first_name, hire_date,
ROUND(DATEDIFF(CURRENT_DATE(),hire_date)/365,2) AS yrs_of_service
FROM Employees WHERE ROUND(DATEDIFF(CURRENT_DATE(),hire_date)/365,2) > 20
ORDER BY yrs_of_service DESC;

# CEIL, FLOOR, MOD FUNCTIONS
SELECT employee_id, first_name, hire_date, salary,
FLOOR(salary/500) AS 'Rs500 Required', MOD(salary,500) AS 'Remaining Amount'
FROM Employees;

SELECT employee_id, first_name, hire_date, salary,
FLOOR(salary/500) AS 'Rs500 Required', FLOOR(MOD(salary,500)/200) AS 'Rs200 Required', MOD(MOD(salary,500),200)/100 AS 'Rs100 Required'
FROM Employees;

# ROUND FUNCTIONS
SELECT ROUND(123.456), ROUND(123.456, 1), ROUND(123.456, 2), ROUND(123.456, -1), ROUND(123.456, -2), ROUND(149,-2), ROUND(150,-2); 

# CONCAT, SUBSTRING, REPLACE FUNCTION
SELECT employee_id, first_name, last_name, hire_date, salary,
LOWER(CONCAT(last_name,SUBSTR(first_name,1,1))) AS new_email
FROM Employees;
# Now deal with space
SELECT employee_id, first_name, last_name, hire_date, salary,
LOWER(CONCAT(REPLACE(last_name,' ','_'),SUBSTR(first_name,1,1))) AS new_email
FROM Employees;
# Last character of first name 
SELECT first_name, SUBSTR(first_name,-1) FROM Employees;
# First names ending in a vowel
SELECT first_name, SUBSTR(first_name,-1) FROM Employees
WHERE SUBSTR(first_name,-1) IN ('a','e','i','o','u');
# First name and Last name both ending in a vowel
SELECT first_name, last_name FROM Employees
WHERE SUBSTR(first_name,-1) IN ('a','e','i','o','u')
AND SUBSTR(last_name,-1) IN ('a','e','i','o','u');

# Longest Full name
SELECT first_name, last_name, LENGTH(CONCAT(first_name,REPLACE(last_name,' ',''))) AS 'LONGEST LENGTH'
FROM Employees;

SELECT MAX(LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ','')))) FROM Employees;

###
SELECT CONCAT(first_name,' ',last_name) AS 'full_name', LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ',''))) AS 'length',
CASE
	WHEN LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ',''))) = 
    (SELECT MAX(LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ','')))) FROM Employees)
    THEN 'Max Length'
    WHEN LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ',''))) =
    (SELECT MIN(LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ','')))) FROM Employees)
    THEN 'Min Length'
END AS 'length_type'
FROM Employees
WHERE LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ',''))) IN
(SELECT MAX(LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ','')))) FROM Employees)
OR LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ',''))) IN
(SELECT MIN(LENGTH(CONCAT(REPLACE(first_name,' ',''),REPLACE(last_name,' ','')))) FROM Employees)
ORDER BY 2;
###

SELECT MAX(LENGTH(CONCAT(first_name,REPLACE(last_name,' ','')))) AS 'LONGEST LENGTH' FROM Employees;
# Shortest Full name
SELECT MIN(LENGTH(CONCAT(first_name,REPLACE(last_name,' ','')))) AS 'SHORTEST LENGTH' FROM Employees;

# Avg range difference of salary of different types of managers and clerks
SELECT job_title, AVG(max_salary-min_salary)
FROM Jobs
GROUP BY job_title 
HAVING job_title LIKE '%Manager%' OR job_title LIKE '%Clerk%';

SELECT AVG(max_salary-min_salary)
FROM Jobs
WHERE job_title LIKE '%Manager%' OR job_title LIKE '%Clerk%'
GROUP BY SUBSTR(job_title,INSTR(job_title,'Manager')); ##### DOUBT

SELECT 'Manager', AVG(max_salary-min_salary)
FROM Jobs
WHERE job_title LIKE '%Manager%'
GROUP BY SUBSTR(job_title,INSTR(job_title,'Manager'))
UNION 
SELECT 'Clerk', AVG(max_salary-min_salary)
FROM Jobs
WHERE job_title LIKE '%Clerk%'
GROUP BY SUBSTR(job_title,INSTR(job_title,'Clerk'));

# INSTR FUNCTION
SELECT job_title, INSTR(job_title,'Manager') FROM Jobs;

# CASE STATEMENT
SELECT employee_id, first_name, salary,
CASE
	WHEN salary < 5001 THEN 'Low'
    WHEN salary BETWEEN 5000 AND 10001 THEN 'Medium'
    WHEN salary > 10001 THEN 'High'
END AS sal_level
FROM Employees;

SELECT 
CASE
	WHEN INSTR(job_title, 'Manager') > 0 THEN 'Manager'
    WHEN INSTR(job_title, 'Clerk') > 0 THEN 'Clerk'
END AS emp_role,
AVG(max_salary-min_salary) AS avg_sal_range
FROM Jobs
WHERE job_title LIKE '%Manager%' OR job_title LIKE '%Clerk%'
GROUP BY emp_role;

SELECT 
CASE
	WHEN INSTR(job_title, 'Manager') > 0 THEN 'Manager'
    WHEN INSTR(job_title, 'Clerk') > 0 THEN 'Clerk'
    WHEN INSTR(job_title, 'Representative') > 0 THEN 'Representative'
    ELSE 'Others'
END AS emp_role,
AVG(max_salary-min_salary) AS avg_sal_range
FROM Jobs
GROUP BY emp_role
ORDER BY avg_sal_range;

### TRYYY ###
# SELECT employee_id,salary,cummulative salary
SELECT employee_id,salary,(SELECT SUM(salary) FROM Employees WHERE employee_id<=e.employee_id) AS cumm_salary FROM Employees e;

SELECT employee_id, first_name, department_id, salary,
ROUND(CUME_DIST() OVER (PARTITION BY department_id ORDER BY salary DESC),4) AS cume_dist_emp_ineach_dept
FROM Employees
WHERE department_id IS NOT NULL;

# Display those dept names where some employees exist
SELECT DISTINCT d.department_id, d.department_name
FROM Employees e JOIN Departments d ON e.department_id = d.department_id;
# OR
SELECT * FROM Departments WHERE department_id IN (SELECT DISTINCT department_id FROM Employees WHERE department_id IS NOT NULL);
# NOT IN was not working if we don't remove null, this is because IN takes OR while NOT IN takes AND, and nulling with AND gives all NULL.
SELECT * FROM Departments WHERE department_id NOT IN (SELECT DISTINCT department_id FROM Employees WHERE department_id IS NOT NULL);
# OR
SELECT * FROM Departments WHERE department_id NOT IN (SELECT DISTINCT IFNULL(department_id,0) FROM Employees);


SELECT employee_id, first_name, last_name, department_id, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

SELECT IFNULL(department_id,0), AVG(salary) FROM Employees GROUP BY department_id;

SELECT employee_id, first_name, last_name, department_id, salary
FROM Employees e
WHERE salary > (SELECT AVG(salary) FROM Employees WHERE department_id = e.department_id)
ORDER BY department_id, employee_id;


SELECT employee_id, first_name, last_name, job_id, department_id, salary, 
ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) Row_num,
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) Ranked,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) Dense_Ranked,
LEAD(salary,1,0) OVER (PARTITION BY department_id ORDER BY salary DESC) Lead_Func_NextLowerSal,
LAG(salary,1,'None') OVER (PARTITION BY department_id ORDER BY salary DESC) Lag_Func_PrevHigherSal
FROM Employees
WHERE department_id IN(50,80);


CREATE VIEW basic_emp_info AS
SELECT employee_id, first_name, last_name, job_id, manager_id, department_id
FROM Employees;

SELECT * FROM basic_emp_info;

UPDATE basic_emp_info SET manager_id = 101 WHERE employee_id = 103;
SELECT * FROM basic_emp_info WHERE employee_id = 103;
SELECT * FROM Employees WHERE employee_id = 103; # Employee Table affected due to Update in View
# So it depends who we want to give those rights to while sharing view
ROLLBACK;
UPDATE basic_emp_info SET manager_id = 102 WHERE employee_id = 103;
UPDATE basic_emp_info SET manager_id = 100 WHERE employee_id = 102;
SELECT * FROM basic_emp_info WHERE employee_id = 103;
SELECT * FROM Employees WHERE employee_id = 103;
# THUS WE NEED TO MAKE THE VIEW IN READ ONLY FORMAT

# DATE FUNCTIONS
SELECT DATE_FORMAT(CURRENT_DATE(),'%d-%m-%Y') AS CAP_Y, DATE_FORMAT(CURRENT_DATE(),'%d-%m-%y') AS LOWER_y;

SELECT employee_id, first_name, last_name, hire_date, job_id, manager_id, department_id
FROM Employees WHERE hire_date < STR_TO_DATE('15-01-2000','%d-%m-%Y');

SELECT employee_id, first_name, last_name, hire_date, job_id, manager_id, department_id
FROM Employees WHERE hire_date < STR_TO_DATE('15-01-99','%d-%m-%y');

SELECT employee_id, first_name, last_name, hire_date, job_id, manager_id, department_id
FROM Employees WHERE hire_date < '2000-01-15'; # DEFAULT FORMAT

CREATE VIEW old_emp_view AS
SELECT employee_id, first_name, last_name, hire_date, job_id, manager_id, department_id
FROM Employees WHERE hire_date < '2000-01-15';

DROP VIEW old_emp_view;

CREATE VIEW old_emp_view AS
SELECT employee_id, first_name, last_name, hire_date, job_id, manager_id, department_id
FROM Employees WHERE hire_date < '2000-01-15'
WITH CHECK OPTION;
# OTHER than mysql, WITH READ ONLY
UPDATE old_emp_view SET hire_date = CURRENT_DATE() WHERE employee_id = 199; ## ERROR
# Error Code: 1369. CHECK OPTION failed 'hr.old_emp_view'
# So it will not Update




























