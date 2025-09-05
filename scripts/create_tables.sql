-- Create database: Data_warehouse

-- Create Schemas:

CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;

-- Creating Tables : bronze layer - crm

CREATE TABLE bronze.crm_cust_info(
	cst_id					INT,
	cst_key					VARCHAR(55),
	cst_firstname			VARCHAR(55),
	cst_lastname			VARCHAR(55),
	cst_marital_status		VARCHAR(10),	
	cst_gndr				VARCHAR(10),
	cst_create_date			DATE
);

CREATE TABLE bronze.crm_prd_info(
	prd_id					INT,
	prd_key					VARCHAR(100),
	prd_nm					VARCHAR(100),
	prd_cost				NUMERIC,
	prd_line				VARCHAR(10),
	prd_start_dt			DATE,
	prd_end_dt				DATE
);

CREATE TABLE bronze.crm_sales_details(
	sls_ord_num				VARCHAR(100),
	sls_prd_key				VARCHAR(100),
	sls_cust_id				INT,
	sls_order_dt			DATE,
	sls_ship_dt				DATE,
	sls_due_dt				DATE,
	sls_sales				NUMERIC,
	sls_quantity			INT,
	sls_price				NUMERIC
);

-- Creating Tables : bronze layer - erp

CREATE TABLE bronze.erp_cust_az12(
	cid						VARCHAR(100),		
	bdate					DATE,
	gen						VARCHAR(20)
);

CREATE TABLE bronze.erp_loc_a101(
	cid						VARCHAR(100),	
	cntry					VARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2(
	id 						VARCHAR(25),	
	cat						VARCHAR(50),
	subcat					VARCHAR(50),
	maintenance				VARCHAR(10)
);

=======================================================

-- Creating Tables : silver layer - crm

CREATE TABLE silver.crm_cust_info(
	cst_id					INT,
	cst_key					VARCHAR(55),
	cst_firstname			VARCHAR(55),
	cst_lastname			VARCHAR(55),
	cst_marital_status		VARCHAR(10),	
	cst_gndr				VARCHAR(10),
	cst_create_date			DATE
);
-- DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info(
	prd_id					INT,
	prd_key					VARCHAR(100),
	prd_cat_id				VARCHAR(50),
	prd_nm					VARCHAR(100),
	prd_cost				NUMERIC,
	prd_line				VARCHAR(10),
	prd_start_dt			DATE,
	prd_end_dt				DATE
);

-- TRUNCATE TABLE silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details(
	sls_ord_num				VARCHAR(100),
	sls_prd_key				VARCHAR(100),
	sls_cust_id				INT,
	sls_order_dt			DATE,
	sls_ship_dt				DATE,
	sls_due_dt				DATE,
	sls_sales				NUMERIC,
	sls_quantity			INT,
	sls_price				NUMERIC
);

-- Creating Tables : silver layer - erp

CREATE TABLE silver.erp_cust_az12(
	cid						VARCHAR(100),		
	bdate					DATE,
	gen						VARCHAR(20)
);

CREATE TABLE silver.erp_loc_a101(
	cid						VARCHAR(100),	
	cntry					VARCHAR(50)
);

CREATE TABLE silver.erp_px_cat_g1v2(
	id 						VARCHAR(25),	
	cat						VARCHAR(50),
	subcat					VARCHAR(50),
	maintenance				VARCHAR(10)
);




