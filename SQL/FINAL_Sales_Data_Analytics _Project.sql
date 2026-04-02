
-- PERSONAL PROJECT SCRIPT: Adventure Works Sales

-- BEGGINING OF PERSONAL PROJECT SCRIPT.

-- Create and select the database
DROP DATABASE IF EXISTS adventure_works_db;
CREATE DATABASE IF NOT EXISTS adventure_works_db;
USE adventure_works_db;

-- Create the sales table
DROP TABLE IF EXISTS adventure_works_sales_tb;

CREATE TABLE IF NOT EXISTS adventure_works_sales_tb (
    Category VARCHAR(50) NOT NULL,
    Sub_Category VARCHAR(50) NOT NULL,
    Product_name VARCHAR(100) NOT NULL,
    Territory VARCHAR(30) NOT NULL,
    Sale_date DATETIME NOT NULL,
    List_Price DECIMAL(10,2) NOT NULL CHECK (List_Price >= 0),
    Quantity TINYINT UNSIGNED NOT NULL CHECK (Quantity > 0),
    Sales_amount DECIMAL(12,2) NOT NULL CHECK (Sales_amount >= 0),
    Region VARCHAR(50),
    Sales_year YEAR NOT NULL
);

-- View table structure
DESC adventure_works_sales_tb;

-- 1. Load CSV data into the table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\PERSONAL PROJECT\\KC-LECTURE 04_1- WildCard Operations.csv'
INTO TABLE adventure_works_sales_tb
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Verify row count and sample data
SELECT COUNT(*) AS Total_Rows
FROM adventure_works_sales_tb;

SELECT *
FROM adventure_works_sales_tb
LIMIT 5;


-- 2. Wildcard Analysis Examples

-- Example 1: Quantity and Revenue by product keyword
SELECT 'Finger' AS Product, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Finger%';

SELECT 'Frame' AS Product, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Frame%';

SELECT 'Tube' AS Product, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Tube%';

SELECT 'Mountain' AS Product, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Mountain%';

-- Example 2: Quantity and Revenue by product code or name prefix
SELECT 'HL' AS Product, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE 'HL%';

SELECT 'LL' AS Product, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE 'LL%';

SELECT 'ML' AS Product, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE 'ML%';

SELECT 'Touring' AS Product, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Touring%';

SELECT 'Road' AS Product, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Road%';

-- Example 3: Quantity and Revenue by Size
SELECT
    CASE
        WHEN Product_name LIKE '%, S' THEN 'Small'
        WHEN Product_name LIKE '%, M' THEN 'Medium'
        WHEN Product_name LIKE '%, L' THEN 'Large'
        WHEN Product_name LIKE '%, 38' THEN 'Size 38'
        WHEN Product_name LIKE '%, 40' THEN 'Size 40'
        WHEN Product_name LIKE '%, 42' THEN 'Size 42'
        WHEN Product_name LIKE '%, 44' THEN 'Size 44'
        WHEN Product_name LIKE '%, 46' THEN 'Size 46'
        WHEN Product_name LIKE '%, 48' THEN 'Size 48'
        WHEN Product_name LIKE '%, 50' THEN 'Size 50'
        WHEN Product_name LIKE '%, 52' THEN 'Size 52'
    END AS Size_Category,
    SUM(Quantity) AS Total_Quantity,
    SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%, S'
   OR Product_name LIKE '%, M'
   OR Product_name LIKE '%, L'
   OR Product_name LIKE '%, 38'
   OR Product_name LIKE '%, 40'
   OR Product_name LIKE '%, 42'
   OR Product_name LIKE '%, 44'
   OR Product_name LIKE '%, 46'
   OR Product_name LIKE '%, 48'
   OR Product_name LIKE '%, 50'
   OR Product_name LIKE '%, 52'
GROUP BY Size_Category
ORDER BY Total_Revenue DESC;

-- Example 4: Quantity and Revenue by Colour
SELECT 'Black' AS Colour, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Black%';

SELECT 'Red' AS Colour, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Red%';

SELECT 'Silver' AS Colour, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Silver%';

SELECT 'Yellow' AS Colour, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Yellow%';

SELECT 'Blue' AS Colour, SUM(Quantity) AS Total_Quantity, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
WHERE Product_name LIKE '%Blue%';

-- 3. Other Data Analysis tasks
-- A) To Show top 5 product categories and sub-categories drive the most revenue
-- and sales volume.
SELECT
    Category,
    Sub_Category,
    COUNT(*) AS Transaction_Count,
    SUM(Quantity) AS Total_Quantity,
    SUM(Sales_amount) AS Total_Sales_amount,
    AVG(List_Price) AS Avg_ListPrice
FROM adventure_works_sales_tb
GROUP BY Category, Sub_Category
ORDER BY Total_Sales_amount DESC
LIMIT 5;

-- B) Top 10 Products by Revenue
SELECT Product_name, SUM(Sales_amount) AS Total_Revenue
FROM adventure_works_sales_tb
GROUP BY Product_name
ORDER BY Total_Revenue DESC
LIMIT 10;

-- C) Revenue and Quantity by Territory
SELECT Territory, SUM(Sales_amount) AS Total_Revenue, SUM(Quantity) AS Total_Quantity
FROM adventure_works_sales_tb
GROUP BY Territory
ORDER BY Total_Revenue DESC;

-- D) Yearly Revenue Trend
SELECT Sales_year, SUM(Sales_amount) AS Total_Revenue, SUM(Quantity) AS Total_Quantity
FROM adventure_works_sales_tb
GROUP BY Sales_year
ORDER BY Sales_year;

-- END OF PERSONAL PROJECT SCRIPT