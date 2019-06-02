USE hr;

SELECT oc.customer_id, customer_fname, customer_lname, p.product_desc, SUM(oi.product_quantity) AS total_qty, SUM(oi.product_quantity * p.product_price) AS total_amt
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
WHERE oc.customer_id = 10
GROUP BY oc.customer_id, p.product_desc;

SELECT oc.customer_id, customer_fname, customer_lname, p.product_desc, SUM(oi.product_quantity) AS total_qty, SUM(oi.product_quantity * p.product_price) AS total_amt
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id
JOIN address a ON oc.address_id = a.address_id
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
WHERE state='Delhi'
GROUP BY oc.customer_id, p.product_desc
ORDER BY 1;

SELECT oc.customer_id, customer_fname, customer_lname, p.product_desc, SUM(oi.product_quantity) AS total_qty, SUM(oi.product_quantity * p.product_price) AS total_amt
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id AND oh.order_status = 'Shipped'
JOIN address a ON oc.address_id = a.address_id
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
WHERE state='Delhi'
GROUP BY oc.customer_id, p.product_desc
ORDER BY 1;

SELECT oc.customer_id, customer_fname, customer_lname, p.product_desc, SUM(oi.product_quantity) AS total_qty, SUM(oi.product_quantity * p.product_price) AS total_amt
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id AND oh.order_status = 'Shipped'
JOIN address a ON oc.address_id = a.address_id
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
WHERE state='Delhi'
GROUP BY oc.customer_id, p.product_desc WITH ROLLUP;

SELECT oc.customer_id, CONCAT(customer_fname, customer_lname) AS fullname, SUM(oi.product_quantity) AS total_qty, SUM(oi.product_quantity * p.product_price) AS total_amt
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id AND oh.order_status = 'Shipped'
JOIN address a ON oc.address_id = a.address_id
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
WHERE state='Delhi'
GROUP BY oc.customer_id, fullname WITH ROLLUP;

SELECT oc.customer_id, CONCAT(customer_fname, customer_lname) AS fullname,
IFNULL(pc.product_class_desc,'>>> CUSTOMER TOTAL >>> ') AS 'product_class_desc',
IFNULL(p.product_desc,CONCAT('>>> ', pc.product_class_desc,' TOTAL >>> ')) AS 'product_desc', 
SUM(oi.product_quantity) AS total_qty, SUM(oi.product_quantity * p.product_price) AS total_amt
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id AND oh.order_status = 'Shipped'
JOIN address a ON oc.address_id = a.address_id
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
JOIN product_class pc ON p.product_class_code = pc.product_class_code
WHERE a.state = 'Delhi'
GROUP BY oc.customer_id, pc.product_class_desc, p.product_desc WITH ROLLUP;

SELECT oc.customer_id, CONCAT(customer_fname, customer_lname) AS fullname,
SUM(oi.product_quantity) AS total_qty, SUM(oi.product_quantity * p.product_price) AS total_amt
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id
JOIN address a ON oc.address_id = a.address_id
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
GROUP BY oc.customer_id
HAVING SUM(oi.product_quantity * p.product_price)  =
(
SELECT SUM(oi.product_quantity * p.product_price) AS 'total'
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id GROUP BY oc.customer_id
ORDER BY total DESC LIMIT 1
);

SELECT SUM(oi.product_quantity * p.product_price) AS 'total'
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id GROUP BY oc.customer_id
ORDER BY total DESC LIMIT 1,3;

# PRODUCT IN HIGHEST DEMAND
SELECT p.product_id, p.product_desc, SUM(oi.product_quantity) AS total_qty
FROM order_header oh JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
GROUP BY p.product_id HAVING total_qty =
(
SELECT SUM(oi.product_quantity) AS total_qty
FROM order_header oh JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id GROUP BY p.product_id
ORDER BY total_qty DESC LIMIT 1
);

SELECT p.product_id, p.product_desc, SUM(oi.product_quantity) AS total_qty
FROM order_header oh JOIN order_items oi ON oh.order_id = oi.order_id AND oh.order_status = 'Shipped'
JOIN product p ON oi.product_id = p.product_id
GROUP BY p.product_id HAVING total_qty =
(
SELECT SUM(oi.product_quantity) AS total_qty
FROM order_header oh JOIN order_items oi ON oh.order_id = oi.order_id AND oh.order_status = 'Shipped'
JOIN product p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_qty DESC LIMIT 1
);
# Amon
SELECT p.product_id, p.product_desc, SUM(oi.product_quantity) AS total_qty
FROM order_header oh JOIN order_items oi ON oh.order_id = oi.order_id AND oh.order_status = 'Shipped'
JOIN product p ON oi.product_id = p.product_id
WHERE p.product_price>1000
GROUP BY p.product_id HAVING total_qty =
(
SELECT SUM(oi.product_quantity) AS total_qty
FROM order_header oh JOIN order_items oi ON oh.order_id = oi.order_id AND oh.order_status = 'Shipped'
JOIN product p ON oi.product_id = p.product_id
WHERE p.product_price>1000
GROUP BY p.product_id
ORDER BY total_qty DESC LIMIT 1
);

# Total Revenue generated by the most expensive product
SELECT SUM(oi.product_quantity * p.product_price) AS 'Total'
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id AND oh.order_status = 'Shipped'
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
WHERE p.product_price = (SELECT MAX(product_price) FROM product p);
# Total Revenue by all products
SELECT SUM(oi.product_quantity * p.product_price) AS 'Total'
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id AND oh.order_status = 'Shipped'
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id;

SELECT 
(
SELECT SUM(oi.product_quantity * p.product_price) AS 'Total'
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id AND oh.order_status = 'Shipped'
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
WHERE p.product_price = (SELECT MAX(product_price) FROM product p)
)
/
(
SELECT SUM(oi.product_quantity * p.product_price) AS 'Total'
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id AND oh.order_status = 'Shipped'
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
) AS RATIO;

### TRYYY
# PARETO - 80% of Revenue is generated by top 20% of Products

#### WINDOWING FUNCTIONS ####
SELECT product_class_code, COUNT(product_id) OVER(PARTITION BY product_class_code) AS prod_count
FROM product;

SELECT product_class_code, COUNT(product_id) AS prod_count
FROM product
GROUP BY product_class_code;

# INLINE VIEWS - PC becomes a table itself
SELECT * FROM 
(SELECT product_class_code, COUNT(product_id) OVER(PARTITION BY product_class_code) AS prod_count FROM product) PC
WHERE prod_count >=5
ORDER BY prod_count DESC;

SELECT pc.product_class_code, product_class_desc, pc.prod_count FROM 
(SELECT product_class_code, COUNT(product_id) OVER(PARTITION BY product_class_code) AS prod_count FROM product) PC
JOIN product_class pcc ON pc.product_class_code = pcc.product_class_code
WHERE prod_count >=5
ORDER BY prod_count DESC;

SELECT product_id, COUNT(product_id) OVER(PARTITION BY product_class_code) AS prod_count , product_quantity_avail
FROM product;

# Percentage of each product available in its class
SELECT product_class_code, SUM(product_quantity_avail) OVER(PARTITION BY product_class_code) AS prod_count
FROM product; 

SELECT product_id, product_class_code, product_quantity_avail,
COUNT(product_id) OVER(PARTITION BY product_class_code) AS prod_count,
SUM(product_quantity_avail) OVER(PARTITION BY product_class_code) AS total_class_inv,
product_quantity_avail/(SUM(product_quantity_avail) OVER(PARTITION BY product_class_code)) AS per_inv
FROM product
ORDER BY product_class_code, per_inv DESC; 

CREATE VIEW Prod_Inv_View AS SELECT product_id, product_class_code, product_quantity_avail,
COUNT(product_id) OVER(PARTITION BY product_class_code) AS prod_count,
SUM(product_quantity_avail) OVER(PARTITION BY product_class_code) AS total_class_inv,
product_quantity_avail/(SUM(product_quantity_avail) OVER(PARTITION BY product_class_code)) AS per_inv
FROM product
ORDER BY product_class_code, per_inv DESC;

SELECT product_id, per_inv FROM Prod_Inv_View;

# CREATE a view to show shipper wise total quantity & volume of items shipped
SELECT s.shipper_id, s.shipper_name, a.city AS shipper_city,
SUM(oi.product_quantity) AS total_qty, ROUND(SUM(oi.product_quantity * p.len * p.width * p.height * POWER(10,-9)),2) AS total_volume
FROM shipper s JOIN order_header oh ON s.shipper_id = oh.shipper_id
JOIN address a ON a.address_id = s.shipper_address
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
GROUP BY s.shipper_id;
# SEE the below query - window function doesn't take ROUND OR DISTINCT and thus doesn't reduce the number of rows.
SELECT s.shipper_id, s.shipper_name, a.city AS shipper_city,
SUM(oi.product_quantity) OVER (PARTITION BY s.shipper_id) AS total_qty,
SUM(oi.product_quantity * p.len * p.width * p.height * POWER(10,-9)) OVER (PARTITION BY s.shipper_id) AS total_volume
FROM shipper s JOIN order_header oh ON s.shipper_id = oh.shipper_id
JOIN address a ON a.address_id = s.shipper_address
JOIN order_items oi ON oh.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id;


INSERT INTO shipper VALUES(50007, 'Kohli Movers', 9845457864, 1001);
# NOW SHOWING a newly added shipper also who hasn't shipped anything yet
SELECT s.shipper_id, s.shipper_name, a.city AS shipper_city,
IFNULL(SUM(oi.product_quantity),0) AS total_qty, IFNULL(ROUND(SUM(oi.product_quantity * p.len * p.width * p.height * POWER(10,-9)),2),0) AS total_volume
FROM shipper s LEFT JOIN order_header oh ON s.shipper_id = oh.shipper_id
LEFT JOIN address a ON a.address_id = s.shipper_address
LEFT JOIN order_items oi ON oh.order_id = oi.order_id
LEFT JOIN product p ON oi.product_id = p.product_id
GROUP BY s.shipper_id;

# Query to identify the optimum carton id for a given order to ship all items in it at once
SELECT carton_id, c.len*c.width*c.height* power(10,-9) AS Carton_Volume_m3 FROM Carton c 
WHERE c.len*c.width*c.height >= 
(
SELECT SUM(oi.product_quantity * p.len * p.width * p.height) AS total_volume
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id
JOIN order_items oi ON oi.order_id = oh.order_id
JOIN product p ON p.product_id = oi.product_id
WHERE oh.order_id = 10001
)
ORDER BY 2 LIMIT 1;

# If all cartons with same length also
SELECT carton_id, len*width*height* power(10,-9) AS Carton_Volume_m3 
FROM Carton 
WHERE len*width*height* power(10,-9) =
(
SELECT c.len*c.width*c.height* power(10,-9) FROM Carton c 
WHERE c.len*c.width*c.height >= 
(
SELECT SUM(oi.product_quantity * p.len * p.width * p.height) AS total_volume
FROM online_customer oc JOIN order_header oh ON oc.customer_id = oh.customer_id
JOIN order_items oi ON oi.order_id = oh.order_id
JOIN product p ON p.product_id = oi.product_id
WHERE oh.order_id = 10001
)
ORDER BY 1 LIMIT 1
);

SELECT * FROM Product
WHERE MOD(product_price,2)=1;





