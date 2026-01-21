/* Project: E-commerce Data Analysis
   Script: 04_Business_Insights_Analysis
   Author: [ Mishael _ ashraf ]
   Description: Querying the Star Schema to answer key business questions 
                and provide actionable insights.
*/

USE my_ecommerce_project;

-- 1. Which product categories are the most profitable? (Profitability Analysis)
SELECT 
    p.Category, 
    ROUND(SUM(f.Sales), 2) AS Total_Sales, 
    ROUND(SUM(f.Profit), 2) AS Total_Profit,
    ROUND((SUM(f.Profit) / SUM(f.Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM fact_orders f
JOIN dim_products p ON f.Product_Name = p.Product_Name
GROUP BY p.Category
ORDER BY Total_Profit DESC;


-- 2. Top 10 High-Value Customers (Revenue Generators)
SELECT 
    c.Customer_Name, 
    c.Segment,
    ROUND(SUM(f.Sales), 2) AS Total_Spent,
    COUNT(f.Order_ID) AS Total_Orders
FROM fact_orders f
JOIN dim_customers c ON f.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name, c.Segment
ORDER BY Total_Spent DESC
LIMIT 10;


-- 3. Sales Performance by Region & State (Geographic Analysis)
SELECT 
    l.Region, 
    l.State, 
    ROUND(SUM(f.Sales), 2) AS Total_Sales
FROM fact_orders f
JOIN dim_location l ON f.Postal_Code = l.Postal_Code
GROUP BY l.Region, l.State
ORDER BY Total_Sales DESC;


-- 4. Shipping Mode Efficiency (Which shipping method is used most for high-value orders?)
SELECT 
    Ship_Mode, 
    COUNT(Order_ID) AS Order_Count,
    ROUND(AVG(Sales), 2) AS Average_Order_Value
FROM fact_orders
GROUP BY Ship_Mode
ORDER BY Order_Count DESC;


-- 5. Monthly Sales Trend (Seasonality Check)
SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month, 
    ROUND(SUM(Sales), 2) AS Monthly_Revenue
FROM fact_orders
GROUP BY Order_Month
ORDER BY Order_Month;