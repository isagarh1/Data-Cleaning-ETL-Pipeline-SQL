/* 
Load data into Silver from bronze:
	Purpose:
	Performs ETL process Extract Transform Load to populate silver schema from bronze schema
	Actions:
	Truncate table silver
	Insert Transformed and Cleaned data from bronze to silver
*/	

--Inserting Cleaned data into silver crm:
====================================================================================
INSERT INTO silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,cst_create_date
)
SELECT
	cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname ,
	TRIM(cst_lastname) AS cst_lastname,
	CASE WHEN cst_marital_status ='S' THEN 'Single'
		 WHEN cst_marital_status = 'M' THEN 'Married'
		 ELSE 'N/A'
	END AS cst_marital_status,
	CASE WHEN cst_gndr ='M' THEN 'Male'
		 WHEN cst_gndr = 'F' THEN 'Female'
		 ELSE 'N/A'
	END AS cst_gndr,
	cst_create_date
FROM 
(SELECT *,
	ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS rn
FROM bronze.crm_cust_info
)
WHERE rn =1;

--TRUNCATE silver.crm_cust_info 
SELECT * FROM silver.crm_cust_info
LIMIT 100;

====================================================================================

INSERT INTO silver.crm_prd_info(
	prd_id,
	prd_cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
SELECT 
	prd_id,
	REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
	SUBSTRING(prd_key,7,LENGTH(prd_key)) AS prd_key,
	prd_nm,
	COALESCE(prd_cost,0) AS prd_cost,
	CASE UPPER(TRIM(prd_line)) 
		 WHEN 'M' THEN 'Mountain'
		 WHEN 'R' THEN 'Road'
		 WHEN 'S' THEN 'Sports'
		 WHEN 'T' THEN 'Touring'
		 ELSE 'N/A'
	END AS prd_line,	 
	prd_start_dt,
	LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS prd_end_dt
FROM bronze.crm_prd_info;

SELECT * FROM silver.crm_prd_info
LIMIT 100;

====================================================================================

INSERT INTO silver.crm_sales_details(
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
SELECT 
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
	 THEN sls_quantity * ABS(sls_price)
	 ELSE sls_sales
END AS sls_sales,	 
	sls_quantity,
CASE WHEN sls_price IS NULL OR sls_price <=0	
	 THEN sls_sales / NULLIF(sls_quantity,0)
	 ELSE sls_price
END AS sls_price	 
FROM bronze.crm_sales_details;

SELECT * FROM silver.crm_sales_details;

====================================================================================

--Inserting Cleaned data into silver erp:

INSERT INTO silver.erp_cust_az12(
	cid,
	bdate,gen
)
SELECT 
	SUBSTRING(cid,4,LENGTH(cid)) AS cid,
	CASE WHEN bdate > CURRENT_DATE THEN NULL
	ELSE bdate
	END AS bdate,
	CASE WHEN UPPER(TRIM(gen)) IN('F','FEMALE') THEN 'Female' 
		 WHEN UPPER(TRIM(gen)) IN('M','MALE') THEN 'Male'
	ELSE 'N/A'
	END AS gen
FROM bronze.erp_cust_az12;

====================================================================================

INSERT INTO silver.erp_loc_a101(
	cid,
	cntry
)
SELECT
	REPLACE(cid,'-','') AS cid,
	CASE WHEN TRIM(cntry) IN('US','USA') THEN 'United States'
		 WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'N/A'
		 ELSE cntry
	END AS cntry	 
FROM bronze.erp_loc_a101;

====================================================================================

INSERT INTO silver.erp_px_cat_g1v2(
	id,
	cat,
	subcat,
	maintenance
)
SELECT
	id,
	cat,
	subcat,
	maintenance
FROM bronze.erp_px_cat_g1v2;
