--GLOBAL ELECTRONICS RETAILER 2016–2021 - SALES & PROFITABILITY ANALYSIS

--SQL ANALYSIS

--Tool: Google BigQuery

--================================================================================
-- 1. SALES TREND
--================================================================================
SELECT
     EXTRACT(YEAR FROM S.`Order Date`) AS Year,
     COUNT(DISTINCT S.`CustomerKey`) AS Total_Customers,
     COUNT(DISTINCT S.`Order Number`) AS Order_Volume,
     ROUND(COUNT(DISTINCT S.`Order Number`) /  COUNT(DISTINCT S.`CustomerKey`), 2) AS Average_Orders_Per_Customer,
     ROUND(SUM(P.`Unit Price USD` * S.Quantity)) AS Revenue
FROM
     `reinhardproject.Retail_Dataset.Sales_Table` AS S   
INNER JOIN 
     `reinhardproject.Retail_Dataset.Products_Table` AS P    
ON
     S.ProductKey = P.Productkey 
GROUP BY
      EXTRACT(YEAR FROM S.`Order Date`);




--===================================================================================
-- 2. SEASONALITY
--===================================================================================
WITH Monthly_Totals AS (
SELECT
     EXTRACT(YEAR FROM S.`Order Date`) AS Year,
     EXTRACT(MONTH FROM S.`Order Date`) AS Month,
     COUNT(DISTINCT S.`CustomerKey`) AS Total_Customers,
     COUNT(DISTINCT S.`Order Number`) AS Order_Volume,
     ROUND(COUNT(DISTINCT S.`Order Number`) /  COUNT(DISTINCT S.`CustomerKey`), 2) AS Average_Orders_Per_Customer,
     ROUND(SUM(P.`Unit Price USD` * S.Quantity)) AS Revenue
FROM
     `reinhardproject.Retail_Dataset.Sales_Table` AS S   
INNER JOIN 
     `reinhardproject.Retail_Dataset.Products_Table` AS P    
ON
     S.ProductKey = P.Productkey 
GROUP BY
      EXTRACT(YEAR FROM S.`Order Date`),
      EXTRACT(MONTH FROM S.`Order Date`)
),
Number_Rows AS(
     SELECT
           Year,
           Month,
           Total_Customers,
           Order_Volume,
           Average_Orders_Per_Customer,
           Revenue,
           RANK() OVER (PARTITION BY YEAR ORDER BY Revenue DESC) AS Monthly_Rank
     FROM
          Monthly_Totals
)
     SELECT
            *
     FROM
           Number_Rows
       WHERE
           Monthly_Rank IN (1, 12);
          



--==================================================================================
-- 3. ONLINE VS IN-STORE PERFORMANCE
--==================================================================================
WITH Online_Analysis AS (
SELECT
      COUNT(DISTINCT `Order Number`) AS Online_Orders,
      ROUND(SUM(S.Quantity * P.`Unit Price USD`), 2) AS Online_Revenue,
      ROUND(SUM(S.Quantity * P.`Unit Price USD`) / COUNT(DISTINCT `Order Number`), 2) AS Online_AOV
FROM
      `reinhardproject.Retail_Dataset.Sales_Table` AS S    
INNER JOIN
      `reinhardproject.Retail_Dataset.Stores_Table` AS ST    
ON
      S.StoreKey = ST.StoreKey
INNER JOIN
      `reinhardproject.Retail_Dataset.Products_Table` AS P  
ON
      S.ProductKey = P.ProductKey
WHERE
     ST.StoreKey = 0 
),
  In_Store_Analysis AS (
SELECT
      COUNT(DISTINCT `Order Number`) AS In_Store_Orders,
      ROUND(SUM(S.Quantity * P.`Unit Price USD`), 2) AS In_Store_Revenue,
      ROUND(SUM(S.Quantity * P.`Unit Price USD`) / COUNT(DISTINCT `Order Number`), 2) AS In_Store_AOV
FROM
      `reinhardproject.Retail_Dataset.Sales_Table` AS S    
INNER JOIN
      `reinhardproject.Retail_Dataset.Stores_Table` AS ST    
ON
      S.StoreKey = ST.StoreKey
INNER JOIN
      `reinhardproject.Retail_Dataset.Products_Table` AS P  
ON
      S.ProductKey = P.ProductKey
WHERE
     ST.StoreKey <> 0
  )
       SELECT
             Online_Orders,
             Online_Revenue,
             Online_AOV,
             In_store_Orders,
             In_Store_Revenue,
             In_Store_Aov
        FROM
             Online_Analysis
        CROSS JOIN
             In_Store_Analysis;




--==============================================================================
-- 4. CONTINENTAL PERFORMANCE
--==============================================================================
WITH Continent_Totals AS (
SELECT
     C.Continent,
     COUNT(DISTINCT `Order Number`) AS Total_Orders,
     ROUND(SUM(S.Quantity * P.`Unit Cost USD`), 2) AS Cost_Price,
     ROUND(SUM(S.Quantity * P.`Unit Price USD`), 2) AS Revenue
FROM
     `reinhardproject.Retail_Dataset.Customers_Table` AS C 
INNER JOIN
      `reinhardproject.Retail_Dataset.Sales_Table` AS S 
ON
     C.CustomerKey = S.CustomerKey
INNER JOIN
     `reinhardproject.Retail_Dataset.Products_Table` AS P 
ON
     S.ProductKey = P.ProductKey
GROUP BY
     C.Continent
)
     SELECT
           Continent,
           Total_Orders,
           Revenue,
           ROUND(Revenue - Cost_Price, 2) AS Gross_Profit,
           ROUND(((Revenue - Cost_Price) / Revenue) * 100, 2) AS Profit_Margin,
           ROUND(Revenue / (
                     SELECT
                           SUM(Revenue)
                     FROM
                          Continent_Totals
           ) * 100, 2) AS Percentage_Contribution
     FROM
          Continent_Totals;




--==================================================================================
-- 5. NORTH AMERICA CATEGORY PERFORMANCE
--==================================================================================
WITH Continent_Totals AS (
SELECT
     C.Continent,
     P.Category,
     COUNT(DISTINCT `Order Number`) AS Total_Orders,
     ROUND(SUM(S.Quantity * P.`Unit Cost USD`), 2) AS Cost_Price,
     ROUND(SUM(S.Quantity * P.`Unit Price USD`), 2) AS Revenue
FROM
     `reinhardproject.Retail_Dataset.Customers_Table` AS C 
INNER JOIN
      `reinhardproject.Retail_Dataset.Sales_Table` AS S 
ON
     C.CustomerKey = S.CustomerKey
INNER JOIN
     `reinhardproject.Retail_Dataset.Products_Table` AS P 
ON
     S.ProductKey = P.ProductKey
WHERE
      C.Continent = 'North America'
GROUP BY
     C.Continent,
     P.Category
),
Continent_Performance AS (
     SELECT
           Continent,
           Category,
           Total_Orders,
           Revenue,
           ROUND(Revenue - Cost_Price, 2) AS Gross_Profit,
           ROUND(((Revenue - Cost_Price) / Revenue) * 100, 2) AS Profit_Margin,
           ROUND(Revenue / (
                     SELECT
                           SUM(Revenue)
                     FROM
                          Continent_Totals
           ) * 100, 2) AS Category_Contribution
     FROM
          Continent_Totals
)
       SELECT
             *
       FROM
             Continent_Performance
       ORDER BY
             Revenue DESC;
      



             
--========================================================================================
-- 6. DELIVERY PERFORMANCE
--========================================================================================
WITH Delivery_Time AS (
SELECT
    `Order Number`,
    EXTRACT(YEAR FROM MIN(`Order Date`)) AS Year,
    DATE_DIFF(MIN(`Delivery Date`), MIN(`Order Date`), DAY) AS Days
FROM
    `reinhardproject.Retail_Dataset.Sales_Table`
WHERE 
    `Delivery Date` IS NOT NULL
GROUP BY
    `Order Number`
)
    SELECT
         Year,
         ROUND(AVG(Days), 2) AS Delivery_Days
    FROM
         Delivery_Time
    GROUP BY
         Year;