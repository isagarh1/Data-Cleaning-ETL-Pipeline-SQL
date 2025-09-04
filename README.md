## Project Title: Data Cleaning and ETL Pipeline
## Project Overview :

**This project involves an Extract, Transform, and Load (ETL) process to clean and transform raw data from a bronze layer and load it into a refined silver layer**. 

**The goal is to prepare the data for downstream analysis and reporting by standardizing formats, correcting inconsistencies, and handling missing values**. 

**The project leverages SQL to perform data manipulation and quality checks across various tables**.

## Data Sources :

**The source data is located in the bronze schema, which contains raw, uncleaned information from different systems. The tables used in this project are**:

- bronze.crm_cust_info: Customer relationship management data with customer details.

- bronze.crm_prd_info: Product information from the CRM system.

- bronze.crm_sales_details: Sales transaction records.

- bronze.erp_cust_az12: Customer data from an ERP system.

- bronze.erp_loc_a101: Location data from an ERP system.

- bronze.erp_px_cat_g1v2: Product category and maintenance information from an ERP system.


## Transformations and Cleaning :
**The following transformations were applied to the raw data before loading it into the silver schema**:

**silver.crm_cust_info**

- Data duplication: Used a window function (ROW_NUMBER()) to select the latest record for each cst_id, ensuring only the most recent customer information is retained.

- Text Cleaning: Trimmed leading and trailing whitespace from cst_firstname and cst_lastname.

- Standardization: Mapped single-letter codes for cst_marital_status ('S', 'M') and cst_gndr ('M', 'F') to full-word descriptions like 'Single', 'Married', 'Male', and 'Female'.

**silver.crm_prd_info**

- Data Extraction: Extracted the product category ID from prd_key and standardized it by replacing hyphens with underscores.

- Handling Missing Data: Replaced NULL values in prd_cost with 0.

- Standardization: Converted single-letter codes for prd_line to full descriptions (e.g., 'M' to 'Mountain').

- Date Transformation: Calculated the prd_end_dt using the LEAD() window function to determine the end date of a product's validity, based on the start date of the next version.

**silver.crm_sales_details**

- Data Validation and Correction: Corrected sls_sales and sls_price where the values were inconsistent or invalid.

- Sales Calculation: Recalculated sls_sales as sls_quantity * ABS(sls_price) if the original value was NULL, less than or equal to 0, or did not match the product of quantity and price.

- Price Calculation: Recalculated sls_price as sls_sales / NULLIF(sls_quantity, 0) if the original price was NULL or less than or equal to 0. NULLIF was used to prevent division by zero errors.

**silver.erp_cust_az12**

- ID Formatting: Removed the first three characters from the cid column.

- Date Validation: Set future dates in bdate to NULL, ensuring only valid birth dates are included.

- Standardization: Mapped various forms of gender ('F', 'FEMALE', 'M', 'MALE') to a consistent format ('Female', 'Male').

**silver.erp_loc_a101**

- ID Formatting: Removed hyphens from the cid column.

- Standardization: Mapped common country codes ('US', 'USA', 'DE') to their full names ('United States', 'Germany') and handled NULL or empty values.

**Tools and Technologies**

- SQL: The core language used for all data cleaning, transformation, and loading operations.

- PostgreSQL: The database system used.

- pgAdmin: The primary tool used to execute the SQL queries and manage the database.
