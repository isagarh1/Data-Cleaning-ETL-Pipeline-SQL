## Project Title: Data Cleaning and ETL Pipeline

📌 Project Overview :

**This project demonstrates a SQL-based ETL pipeline using the Medallion Architecture (Bronze → Silver → Gold layers)**.

**The objective is to extract raw data, clean/transform it, and prepare business-ready datasets for analytics and reporting**.

- Bronze Layer: Stores raw ingested data from multiple sources (CRM & ERP).

- Silver Layer: Cleans and standardizes the data (handling nulls, data types, business rules).

- Gold Layer: Creates final aggregated and business-ready views for reporting and analytics.

🔹 **Bronze Layer** :

- Stores raw data from CRM and ERP systems.

- No transformations applied.

- Tables created

**Before loading data into the Silver Layer, multiple quality checks are performed to ensure accuracy, consistency, and standardization**.

**Data Quality Checks**

✅ Checks Performed

- Null & Duplicate Detection

        Ensures primary keys (like cst_id, prd_id) are unique and not null.
        
        Unwanted Spaces & Case Standardization
        
        Trimmed text fields (gender, marital_status, country).

- Data Standardization

        Replaced codes with meaningful values (M → Male, S → Single).
        
        Invalid or Missing Values
        
        Checked for negative/NULL product costs.

Recalculated sales if sales ≠ quantity × price.

- Date Validations
        
        Ensured no invalid future birthdates (bdate > current_date).
        
        Checked product date ranges (end_date < start_date).
        
        Low Cardinality Consistency
        
        Verified small categorical fields (gender, marital status, country) have standardized values.

🔹 **Silver Layer** :

- Data cleaning & transformation applied

- Standardized column names.

- Data type corrections.

- Null/duplicate handling.

🔹 **Gold Layer** :

- Final business-ready datasets.

- Created using SQL Views (aggregations, KPIs, joins across CRM & ERP).

- Used for reporting in BI tools (Power BI / Tableau).

## License  
This project is licensed under the [MIT License](LICENSE).  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
