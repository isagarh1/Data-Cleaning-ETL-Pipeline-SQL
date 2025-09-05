/*
	Create Gold Views :
	
	- Gold layer represents final dimension and fact tables (star schema)
	
	- Each view performs transformations and combines data from silver layer 
	  to produce , clean enriched and business ready dataset 

	Usage:-
	- These views can be query directly for analytics and reporting
	
*/

-- Create View for Gold layer :

CREATE VIEW gold.dim_customers AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_num,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	ci.cst_marital_status AS marital_status,
	ci.cst_gndr AS gender,
	ci.cst_create_date AS create_date,
	ea.bdate AS bdate,
	el.cntry AS country
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ea
ON ci.cst_key = ea.cid
LEFT JOIN silver.erp_loc_a101 AS el
ON ci.cst_key = el.cid;

SELECT * FROM gold.dim_customers;

--

CREATE VIEW gold.dim_products AS 
SELECT 
	ROW_NUMBER() OVER(ORDER BY prd_id) AS product_key,
	pi.prd_id AS product_id,
	pi.prd_key AS product_num,
	pi.prd_cat_id AS category_id,
	pi.prd_nm AS product_name,
	pi.prd_cost AS cost,
	pi.prd_line AS product_line,
	pi.prd_start_dt AS start_dt, 
	pc.cat AS category,
	pc.subcat AS sub_category,
	pc.maintenance
FROM silver.crm_prd_info AS pi
LEFT JOIN silver.erp_px_cat_g1v2 AS pc
ON pi.prd_cat_id = pc.id
WHERE pi.prd_end_dt IS NULL

SELECT * FROM gold.dim_products

--

CREATE VIEW gold.fact_sales AS
SELECT 
	sd.sls_ord_num AS order_num,
	gp.product_key,
	gc.customer_key,
	sd.sls_order_dt AS order_dt,
	sd.sls_ship_dt AS ship_dt,
	sd.sls_due_dt AS due_dt,
	sd.sls_sales AS sales_amount,
	sd.sls_quantity AS quantity,
	sd.sls_price AS price
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_products AS gp
ON sd.sls_prd_key = gp.product_num
LEFT JOIN gold.dim_customers AS gc
ON sd.sls_cust_id = gc.customer_id;

SELECT * FROM gold.fact_sales
