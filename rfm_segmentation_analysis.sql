/* Project: E-commerce Data Analysis
Task: Customer Segmentation using RFM Model (Recency, Frequency, Monetary)
Tools: CTEs, Window Functions (NTILE), Subqueries, Case Statements
*/

-- STEP 1: Calculate Base RFM Metrics per Customer
WITH Customers_Stats AS (
    SELECT 
        Customer_ID,
        -- Calculate days since the last purchase (Recency)
        DATEDIFF((SELECT MAX(Order_Date) FROM fact_orders), MAX(Order_Date)) AS Recency,
        -- Total unique orders per customer (Frequency)
        COUNT(DISTINCT Order_ID) AS Frequency,
        -- Total spend per customer (Monetary)
        SUM(Sales) AS Monetary
    FROM fact_orders
    GROUP BY Customer_ID
), 

-- STEP 2: Assign Scores (1-4) using Quartiles (NTILE)
RFM_Scores AS (
    SELECT *, 
        -- Lower Recency is better, so we use DESC to give higher score to lower days
        NTILE(4) OVER (ORDER BY Recency DESC) AS R,
        -- Higher Frequency/Monetary is better, so we use ASC
        NTILE(4) OVER (ORDER BY Frequency ASC) AS F,
        NTILE(4) OVER (ORDER BY Monetary ASC) AS M
    FROM Customers_Stats
)   

-- STEP 3: Final Segmentation based on Total RFM Score
SELECT *, 
       (R + F + M) AS Total_Score, 
       CASE 
           WHEN (R + F + M) >= 10 THEN 'Champions'
           WHEN (R + F + M) BETWEEN 6 AND 9 THEN 'Loyal'
           ELSE 'At Risk'
       END AS Customer_Segment
FROM RFM_Scores
ORDER BY Total_Score DESC;