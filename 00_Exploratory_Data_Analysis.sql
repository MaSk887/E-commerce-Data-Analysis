/* Project: E-commerce Data Analysis
   Script: 00_Exploratory_Data_Analysis (Data Validation)
   Author: [ Mishael _ ashraf ]
   Description: Step 0 - Auditing raw data quality before starting the cleaning process.
*/

USE my_ecommerce_project;

-- 1. General Overview: Check total records and unique values
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT `Order ID`) AS unique_orders,
    COUNT(DISTINCT `Customer ID`) AS unique_customers
FROM `e commerce dataset (1)`;


-- 2. Null Values Check: Identifying missing data in critical columns
SELECT 
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS null_orders,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS null_customers,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN `Order Date` IS NULL THEN 1 ELSE 0 END) AS null_dates
FROM `e commerce dataset (1)`;


-- 3. Logical Validation: Checking for unrealistic values (Outliers)
-- Check for negative sales, profit, or quantity
SELECT * FROM `e commerce dataset (1)`
WHERE Sales <= 0 OR Quantity <= 0;


-- 4. Discount Validation: Ensure discount is within logical range (0 to 1 or 0 to 100%)
SELECT MIN(Discount) AS min_disc, MAX(Discount) AS max_disc
FROM `e commerce dataset (1)`
WHERE Discount < 0 OR Discount > 1;


-- 5. Date Consistency: Ensure Ship_Date is not before Order_Date
-- Note: Using the raw string format or converted format to check logic
SELECT `Order ID`, `Order Date`, `Ship Date`
FROM `e commerce dataset (1)`
WHERE STR_TO_DATE(`Ship Date`, '%m/%d/%Y') < STR_TO_DATE(`Order Date`, '%m/%d/%Y');


-- 6. Category Consistency: Check for typos or variations in Category names
SELECT DISTINCT Category, Sub_Category
FROM `e commerce dataset (1)`
ORDER BY Category;