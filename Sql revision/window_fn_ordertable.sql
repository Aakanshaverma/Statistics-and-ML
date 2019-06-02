use hr;

SELECT * FROM
     (SELECT product_class_code, 
	COUNT(product_id) OVER(PARTITION BY product_class_code) AS prod_count
    FROM product) pc
JOIN product_class pcc
     on pc.product_class_code=pcc.product_class_code
WHERE prod_count>=5;


SELECT product_id, product_quantity_avail,
 COUNT(product_id) OVER(PARTITION BY product_class_code) AS prod_count
 FROM product;     
 
 
 # also add pct of each product qty available to total qty available in that product class
 # show it as a pct inventory
 
SELECT product_id, product_quantity_avail,
ROUND(product_quantity_avail*100/
   (SUM(product_quantity_avail) OVER(PARTITION BY product_class_code)),2) AS pct_inv
    FROM product
 ORDER BY product_class_code, pct_inv DESC;
 
 #using views
 CREATE VIEW prod_inv_view AS
 SELECT product_id, product_quantity_avail,
ROUND(product_quantity_avail*100/
   (SUM(product_quantity_avail) OVER(PARTITION BY product_class_code)),2) AS pct_inv
    FROM product
 ORDER BY product_class_code, pct_inv DESC;
