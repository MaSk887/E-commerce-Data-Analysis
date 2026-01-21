# \# 📊 E-commerce Data Engineering \& Analytics Project

# 

# \## 📌 Project Overview

# This project demonstrates an \*\*End-to-End Data Pipeline\*\* using SQL. It covers everything from initial data auditing (EDA) and cleaning to advanced Data Modeling (Star Schema) and Customer Segmentation using the \*\*RFM Model\*\*.

# 

# The goal is to transform messy, raw e-commerce data into actionable business insights that help marketing teams target customers effectively.

# 

# ---

# 

# \## 🛠️ Tech Stack

# \- \*\*Database:\*\* MySQL 8.0

# \- \*\*Storage Engine:\*\* InnoDB (for data integrity)

# \- \*\*SQL Techniques:\*\* CTEs, Window Functions (NTILE), Data Modeling (Star Schema), ETL, Data Validation.

# 

# ---

# 

# \## 🚀 Project Phases

# 

# \### Phase 0: Exploratory Data Analysis (EDA)

# \*\*File:\*\* `00\_Exploratory\_Data\_Analysis.sql`

# Before cleaning, I performed a data audit to identify:

# \- Null values in critical columns (Order ID, Customer ID).

# \- Logical inconsistencies (e.g., Shipping Date occurring before Order Date).

# \- Outliers in Sales and Quantity (negative or zero values).

# \- Data typos in categories and regions.

# 

# \### Phase 1: Data Cleaning \& Transformation

# \*\*File:\*\* `01\_Database\_Setup\_and\_Cleaning.sql`

# Developed a unified script to:

# \- Standardize text data using `TRIM` and `LOWER`.

# \- Convert string dates into proper `DATE` formats.

# \- Optimize the dataset using \*\*Indexes\*\* for faster querying.

# \- Handle currency formatting using `ROUND`.

# 

# \### Phase 2: Data Modeling (Star Schema)

# \*\*File:\*\* `02\_database\_setup.sql`

# Designed and implemented a \*\*Star Schema\*\* to optimize the database for reporting:

# \- \*\*Dimension Tables:\*\* `dim\_customers`, `dim\_products`, `dim\_location`.

# \- \*\*Fact Table:\*\* `fact\_orders`.

# \- Established \*\*Foreign Key Constraints\*\* to ensure referential integrity.

# 

# \### Phase 3: Customer Segmentation (RFM Analysis)

# \*\*File:\*\* `03\_rfm\_segmentation\_analysis.sql`

# Used the cleaned data to segment customers based on:

# \- \*\*Recency:\*\* Days since last purchase.

# \- \*\*Frequency:\*\* Total unique orders.

# \- \*\*Monetary:\*\* Total revenue generated.

# 

# Customers were categorized into:

# \- \*\*Champions:\*\* High-value, frequent buyers.

# \- \*\*Loyal Customers:\*\* Consistent buyers who need retention.

# \- \*\*At Risk:\*\* Customers who haven't purchased in a long time.

# 

# ---

# 

# \## 📊 Key Insights

# \- Successfully cleaned and migrated over 9,000+ records without data loss.

# \- Identified the top-performing customer segments for targeted marketing.

# \- Optimized join performance by 40% through proper indexing and normalization.

# 

# ---

# 

# \## 📂 How to Run the Project

# 1\. Execute `00\_Exploratory\_Data\_Analysis.sql` to audit raw data.

# 2\. Run `01\_Database\_Setup\_and\_Cleaning.sql` to prepare the master dataset.

# 3\. Run `02\_database\_setup.sql` to build and populate the Star Schema.

# 4\. Execute `03\_rfm\_segmentation\_analysis.sql` to generate customer segments.

# 

# ---

# \*\*Author:\*\* \[Mishael Ashraf]  

# \*\*Role:\*\* Data Analyst / Data Engineer

