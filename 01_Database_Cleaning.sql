/* Project: E-commerce Data Analysis - Data Cleaning Pipeline
Script: 01_Database_Cleaning.sql
Author: [ Mishael _ ashraf ]
Description: This script creates the database and performs unified cleaning 
             and transformation on the raw dataset.
*/

-- 1. DATABASE SETUP
CREATE DATABASE IF NOT EXISTS my_ecommerce_project;
USE my_ecommerce_project;

-- 2. STRUCTURE DEFINITION (The Cleaned Table)
DROP TABLE IF EXISTS cleaned_dataset;
CREATE TABLE cleaned_dataset (
    Row_ID INT,
    Order_ID VARCHAR(25),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Category VARCHAR(100),
    Sub_Category VARCHAR(100),
    Product_Name VARCHAR(255),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(4,2),
    Profit DECIMAL(10,2)
);

-- 3. UNIFIED DATA MIGRATION & TRANSFORMATION
-- Disable safe updates for bulk operations
SET SQL_SAFE_UPDATES = 0;

INSERT INTO cleaned_dataset (
    Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, 
    Customer_ID, Customer_Name, Segment, Country, City, 
    State, Postal_Code, Region, Category, Sub_Category, 
    Product_Name, Sales, Quantity, Discount, Profit
)
SELECT 
    `Row ID`, 
    `Order ID`, 
    STR_TO_DATE(`Order Date`, '%m/%d/%Y'),      -- Converting Order Date
    STR_TO_DATE(TRIM(`Ship Date`), '%m/%d/%Y'), -- Converting & Trimming Ship Date
    LOWER(TRIM(`Ship Mode`)),                   -- Standardizing to Lowercase
    TRIM(`Customer ID`),                        -- Removing whitespace
    LOWER(TRIM(`Customer Name`)),
    LOWER(TRIM(Segment)),
    LOWER(TRIM(Country)),
    LOWER(TRIM(City)),
    LOWER(TRIM(State)),
    CAST(`Postal Code` AS CHAR),                -- Preserving Postal Code as String
    LOWER(TRIM(Region)),
    LOWER(TRIM(Category)),
    LOWER(TRIM(`Sub-Category`)),
    LOWER(TRIM(`Product Name`)),
    ROUND(Sales, 2),                            -- Formatting Currency
    Quantity,
    ROUND(Discount, 2),
    ROUND(Profit, 2)
FROM `e commerce dataset (1)`;

-- 4. OPTIMIZATION
-- Creating indexes after insertion for maximum performance
CREATE INDEX idx_clean_order ON cleaned_dataset (Order_ID(20));
CREATE INDEX idx_customer_id ON cleaned_dataset (Customer_ID);

-- Re-enable safe updates
SET SQL_SAFE_UPDATES = 1;

-- Verification
SELECT * FROM cleaned_dataset LIMIT 10;