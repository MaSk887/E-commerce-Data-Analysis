/* DATA MODELING: Star Schema Implementation
   Project: E-commerce Sales Analysis
   Description: This script defines the Dimensional Model (Star Schema) 
                consisting of Dimension tables and a central Fact table.
*/

-- 1. CUSTOMERS DIMENSION: Stores descriptive attributes of customers
CREATE TABLE `dim_customers` (
  `Customer_ID` varchar(20) NOT NULL,    -- Unique Identifier for each customer
  `Customer_Name` text,                  -- Full name of the customer
  `Segment` varchar(50) DEFAULT NULL,    -- Customer category (e.g., Consumer, Corporate)
  PRIMARY KEY (`Customer_ID`)            -- Unique key for relational integrity
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 2. LOCATION DIMENSION: Stores geographical details based on Postal Code
CREATE TABLE `dim_location` (
  `Postal_Code` varchar(20) NOT NULL,    -- Primary key for location lookup
  `City` varchar(100) DEFAULT NULL,      -- City name
  `State` varchar(100) DEFAULT NULL,     -- State/Province name
  `Region` varchar(50) DEFAULT NULL,     -- Geographic region (e.g., East, West, South)
  `Country` varchar(50) DEFAULT NULL,    -- Country name
  PRIMARY KEY (`Postal_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 3. PRODUCTS DIMENSION: Stores product hierarchy and categories
CREATE TABLE `dim_products` (
  `Product_Name` varchar(255) NOT NULL,  -- Unique name/ID for the product
  `Category` varchar(100) DEFAULT NULL,  -- Main product category
  `Sub_Category` varchar(100) DEFAULT NULL, -- Specific sub-category
  PRIMARY KEY (`Product_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 4. ORDERS FACT TABLE: The central table containing quantitative metrics (measures)
CREATE TABLE `fact_orders` (
  `Order_ID` varchar(25) DEFAULT NULL,   -- Business transaction ID
  `Customer_ID` varchar(20) DEFAULT NULL, -- Foreign Key to dim_customers
  `Product_Name` varchar(255) DEFAULT NULL, -- Foreign Key to dim_products
  `Postal_Code` varchar(20) DEFAULT NULL, -- Foreign Key to dim_location
  `Order_Date` date DEFAULT NULL,        -- Date when the order was placed
  `Ship_Date` date DEFAULT NULL,         -- Date when the order was shipped
  `Ship_Mode` varchar(50) DEFAULT NULL,  -- Shipping method (e.g., Standard, First Class)
  `Sales` decimal(10,2) DEFAULT NULL,    -- Total revenue for this transaction
  `Quantity` int DEFAULT NULL,           -- Number of units sold
  `Discount` decimal(5,2) DEFAULT NULL,  -- Applied discount percentage/value
  `Profit` decimal(10,2) DEFAULT NULL,   -- Net profit from the sale
  
  -- Indexing Foreign Keys for optimized Join performance
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Product_Name` (`Product_Name`),
  KEY `Postal_Code` (`Postal_Code`),
  
  -- Defining Referential Integrity (Foreign Key Constraints)
  CONSTRAINT `fact_orders_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `dim_customers` (`Customer_ID`),
  CONSTRAINT `fact_orders_ibfk_2` FOREIGN KEY (`Product_Name`) REFERENCES `dim_products` (`Product_Name`),
  CONSTRAINT `fact_orders_ibfk_3` FOREIGN KEY (`Postal_Code`) REFERENCES `dim_location` (`Postal_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* Project: E-commerce Data Analysis - Data Modeling (ETL)
Script: 02_Star_Schema_Data_Loading.sql
Description: Loading data from cleaned_dataset into Dimension and Fact tables.
*/

USE my_ecommerce_project;

-- 1. Populating DIM_Customers
-- Using INSERT IGNORE to avoid duplicates if a customer has multiple orders
INSERT IGNORE INTO dim_customers (Customer_ID, Customer_Name, Segment)
SELECT DISTINCT Customer_ID, Customer_Name, Segment
FROM cleaned_dataset;

-- 2. Populating DIM_Products
INSERT IGNORE INTO dim_products (Product_Name, Category, Sub_Category)
SELECT DISTINCT Product_Name, Category, Sub_Category
FROM cleaned_dataset;

-- 3. Populating DIM_Location
-- Using MAX for other columns to ensure one record per Postal_Code
INSERT IGNORE INTO dim_location (Postal_Code, City, State, Region, Country)
SELECT Postal_Code, MAX(City), MAX(State), MAX(Region), MAX(Country)
FROM cleaned_dataset
GROUP BY Postal_Code;

-- 4. Populating FACT_Orders
-- This is the core table that connects all dimensions
INSERT INTO fact_orders (
    Order_ID, Customer_ID, Product_Name, Postal_Code, 
    Order_Date, Ship_Date, Ship_Mode, Sales, Quantity, Discount, Profit
)
SELECT 
    Order_ID, Customer_ID, Product_Name, Postal_Code, 
    Order_Date, Ship_Date, Ship_Mode, Sales, Quantity, Discount, Profit
FROM cleaned_dataset;

-- Final Step: Verify the data loading
SELECT 'dim_customers' AS Table_Name, COUNT(*) AS Record_Count FROM dim_customers
UNION ALL
SELECT 'dim_products', COUNT(*) FROM dim_products
UNION ALL
SELECT 'dim_location', COUNT(*) FROM dim_location
UNION ALL
SELECT 'fact_orders', COUNT(*) FROM fact_orders;
