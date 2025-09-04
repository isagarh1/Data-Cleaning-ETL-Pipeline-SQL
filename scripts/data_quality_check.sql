--Quality Checks :
--Purpose:
/* 
	Performs quality checks for data consitency, acurracy,standardization
	It includes checks for:
	-Nulls and duplicate 
	-Unwanted spaces 
	-Data standardization and consistency
	-Invalid date ranges
*/	

SELECT * FROM bronze.crm_cust_info
-- Check nulls and duplicates in priamry key: 

SELECT 
	cst_id,
	COUNT(*) AS duplicate
FROM bronze.crm_cust_info
GROUP BY 1
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check unwanted spaces:

SELECT 
	cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)
	
-- Data Consitency in low cardinality:

SELECT
	DISTINCT cst_marital_status
FROM bronze.crm_cust_info
==========================================================

SELECT * FROM bronze.crm_prd_info
--Check deuplicates: 
SELECT 
	prd_id,
	COUNT(*) AS duplicate
FROM bronze.crm_prd_info
GROUP BY 1
HAVING COUNT(*) >1 ;

-- Check nulls or negative numbers

SELECT 
	prd_cost	
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data consitency/Normalize 
SELECT 
	DISTINCT prd_line
FROM bronze.crm_prd_info

-- Invalid dates  
SELECT 
	prd_id,
	prd_key,
	prd_nm,
	prd_start_dt,
	prd_end_dt
	--LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS prd_end_dt 
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt
==========================================================

SELECT DISTINCT
	sls_sales,
	sls_quantity,
	sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <=0 OR sls_price <=0
ORDER BY sls_sales,sls_quantity,sls_price

==========================================================

SELECT * FROM bronze.erp_cust_az12
WHERE bdate > CURRENT_DATE

--Check data consistency low cardinality

SELECT DISTINCT
	gen
FROM bronze.erp_cust_az12

==========================================================
SELECT * FROM bronze.erp_loc_a101

--Check low cardinality -- Normalize
SELECT 
	DISTINCT cntry
FROM bronze.erp_loc_a101

==========================================================
SELECT * FROM bronze.erp_px_cat_g1v2
LIMIT 100;
