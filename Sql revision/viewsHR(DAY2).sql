use hr;
# to find the level of eseniority on basis of hire date in a dept

SELECT employee_id, first_name, last_name, job_id, department_id, salary,
ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY hire_date) dept_l
FROM Employees
Where department_id IN (50,80);


# same done wrt salary
SELECT employee_id, first_name, last_name, job_id, department_id, salary,
ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) dept_sl
FROM Employees
Where department_id IN (50,80);

# same done using rank and dense rank

SELECT employee_id, first_name, last_name, job_id, department_id, salary,
RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) rank_sal,
DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) drank_sal
FROM Employees
Where department_id IN (50,80);

#use of lead and lag

SELECT employee_id, first_name, last_name, job_id,department_id, salary,
LEAD(salary,1, 'NONE')OVER(PARTITION BY department_id ORDER BY salary DESC) next_lower_salary,
LAG(salary,1,'NONE') OVER(PARTITION BY department_id ORDER BY salary DESC) prev_higher_salary
FROM Employees
Where department_id IN (50,80);

# cummulative dist of salaries
SELECT employee_id, first_name, last_name,department_id, salary,
 ROUND(CUME_DIST() OVER (PARTITION BY Department_id ORDER BY salary DESC),4) AS cum_sal
 FROM Employees
Where department_id IS NOT NULL;

# manipulating a simple view
CREATE VIEW basic_emp_info_view AS
SELECT employee_id,first_name,last_name,job_id, manager_id,department_id
FROM employees
;
Select* from basic_emp_info_view where employee_id= 103;

update basic_emp_info_view set manager_id=101 where employee_id=103;
 #view of employees hired before yr 2000 in proper format
CREATE OR REPLACE VIEW basic_emp_info_view AS
SELECT employee_id,first_name,last_name,job_id, manager_id,department_id
FROM employees
WHERE hire_date < '2000-01-01';

#if i want to specify my own format

CREATE OR REPLACE VIEW basic_emp_info_view AS
SELECT employee_id,first_name,last_name,job_id, manager_id,department_id,hire_date
FROM employees
WHERE hire_date < STR_TO_DATE('15-01-99','%d-%m-%y');





CREATE OR REPLACE VIEW basic_emp_info_view AS
SELECT employee_id,first_name,last_name,job_id, manager_id,department_id,hire_date
FROM employees
WHERE hire_date < '2000-01-15';


Select* from basic_emp_info_view ;

update basic_emp_info_view set hire_date= current_date() where employee_id=100;
Select* from employees where employee_id= 199;


CREATE OR REPLACE VIEW basic_emp_info_view AS
SELECT employee_id,first_name,last_name,job_id, manager_id,department_id,hire_date
FROM employees
WHERE hire_date < '2000-01-15'
WITH CHECK OPTION ;
update basic_emp_info_view set hire_date= current_date() where employee_id=199;



#CREATE VIEW TO SHOW SHIPPER WISE TOTAL QUANTITY AND VOLUME OF ITEMS SHIPPED
# shipper id , shipper name and shipper city
SELECT* FROM shipper;
SELECT* FROM product;

SELECT* FROM address;
SELECT* FROM order_items;
SELECT* FROM order_header;


CREATE OR REPLACE VIEW shipper_view AS
SELECT  s.shipper_id, s.shipper_name, a.city,p.product_desc,
SUM((p.len*p.width*p.height*oi.product_quantity)* power(10,-9)) AS Volume, SUM(oi.product_quantity) AS total_qty
FROM shipper s 
JOIN address a
    ON s.shipper_address=a.address_id
JOIN order_header oh
    ON s.shipper_id=oh.shipper_id
    AND order_status='Shipped'
JOIN order_items oi
     ON oh.order_id=oi.order_id
JOIN product p
	ON oi.product_id=p.product_id
group by s.shipper_id;

select * from shipper_view;

# query to identify the optimum carton id for a given order to ship all its item at once

SELECT* FROM shipper;
SELECT* FROM product;

SELECT* FROM address;
SELECT* FROM order_items;
SELECT* FROM order_header;
SELECT* FROM carton;
SELECT* FROM online_customer;



Select carton_id,
((len*width*height)* power(10,-9)) AS cart_vol 
FROM carton
WHERE
((len*width*height)* power(10,-9))>=
(SELECT SUM((product_quantity*len*width*height)* power(10,-9)) AS ord_volume
FROM order_items oi JOIN product p
     ON oi.product_id=p.product_id
     AND oi.order_id=10001)
order by cart_vol ASC LIMIT 1;



Select carton_id, ROUND((len*width*height)* power(10,-9),2) FROM carton;






SELECT carton_id FROM carton
WHERE (len*width*height)/1000000000 = 
(SELECT (len*width*height)/1000000000 as carton_vol FROM carton
WHERE (len*width*height)/1000000000 >=
(SELECT SUM(product_quantity*len*width*height)/1000000000 AS ord_volume
FROM order_items oi join product p
on oi.product_id=p.product_id
and oi.order_id=10001
order by carton_vol limit 1)
);
