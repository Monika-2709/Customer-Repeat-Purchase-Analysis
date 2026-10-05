-- Customer Repeat Purchase Analysis
-- SQLite-compatible SQL

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    Order_ID INTEGER PRIMARY KEY,
    Customer_ID TEXT,
    Order_Date TEXT,
    Category TEXT,
    Country TEXT,
    Quantity INTEGER,
    Unit_Price REAL,
    Sales REAL
);

-- Load orders.csv into the table using your SQL client's CSV import feature.

-- 1. Repeat customer rate
WITH customer_orders AS (
    SELECT Customer_ID, COUNT(DISTINCT Order_ID) AS order_count
    FROM orders
    GROUP BY Customer_ID
)
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN order_count >= 2 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE WHEN order_count >= 2 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS repeat_rate_pct
FROM customer_orders;

-- 2. First-time vs repeat AOV
WITH customer_orders AS (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Order_ID) AS order_count,
        SUM(Sales) AS customer_sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT
    CASE WHEN order_count = 1 THEN 'First-time' ELSE 'Repeat' END AS customer_type,
    COUNT(*) AS customers,
    ROUND(AVG(customer_sales / order_count), 2) AS avg_order_value
FROM customer_orders
GROUP BY customer_type;

-- 3. Customer segment table
WITH customer_summary AS (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Order_ID) AS order_count,
        SUM(Sales) AS total_sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count BETWEEN 2 AND 3 THEN 'Repeat (2-3 orders)'
        ELSE 'Loyal (4+ orders)'
    END AS segment,
    COUNT(*) AS customers,
    ROUND(SUM(total_sales), 2) AS total_sales,
    ROUND(AVG(order_count), 2) AS avg_orders
FROM customer_summary
GROUP BY segment
ORDER BY customers DESC;

-- 4. Top repeat-oriented categories
SELECT
    Category,
    COUNT(DISTINCT Customer_ID) AS customers,
    COUNT(DISTINCT Order_ID) AS orders,
    ROUND(SUM(Sales), 2) AS sales
FROM orders
GROUP BY Category
ORDER BY sales DESC;