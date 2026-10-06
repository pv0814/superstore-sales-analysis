CREATE DATABASE superstore;
USE superstore;

CREATE TABLE orders (
  row_id INT, order_id VARCHAR(20), order_date DATE, ship_date DATE,
  ship_mode VARCHAR(30), customer_id VARCHAR(20), customer_name VARCHAR(60),
  segment VARCHAR(20), country VARCHAR(30), city VARCHAR(40), state VARCHAR(40),
  postal_code VARCHAR(10), region VARCHAR(20), product_id VARCHAR(30),
  category VARCHAR(30), sub_category VARCHAR(30), product_name VARCHAR(200),
  sales DECIMAL(10,4), quantity INT, discount DECIMAL(4,2), profit DECIMAL(12,4)
);
-- Q1. What are total sales and total profit?
SELECT ROUND(SUM(sales),0) AS total_sales, ROUND(SUM(profit),0) AS total_profit
FROM orders;
-- Q2. How do sales and profit differ by category?
SELECT category, ROUND(SUM(sales),0) AS sales, ROUND(SUM(profit),0) AS profit
FROM orders
GROUP BY category
ORDER BY profit DESC;
-- Q3. Which sub-categories lose money?
SELECT sub_category, ROUND(SUM(profit),0) AS total_profit
FROM orders
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit;
-- Q4. How have sales and profit changed each year?
SELECT YEAR(order_date) AS year, ROUND(SUM(sales),0) AS sales, ROUND(SUM(profit),0) AS profit
FROM orders
GROUP BY YEAR(order_date)
ORDER BY year;
-- Q5. How does discount level affect profit?
SELECT CASE
         WHEN discount = 0 THEN 'No discount'
         WHEN discount <= 0.2 THEN 'Up to 20%'
         WHEN discount <= 0.4 THEN '20-40%'
         ELSE 'Over 40%'
       END AS discount_band,
       COUNT(*) AS orders, ROUND(SUM(profit),0) AS profit
FROM orders
GROUP BY discount_band
ORDER BY profit DESC;
-- Q6. Which region has the best profit margin?
SELECT region, ROUND(SUM(profit)/SUM(sales)*100,1) AS margin_pct
FROM orders
GROUP BY region
ORDER BY margin_pct DESC;
-- Q7. Who are the top 10 customers by sales?
SELECT customer_name, ROUND(SUM(sales),0) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;
-- Q8. Which 5 states lose the most money?
SELECT state, ROUND(SUM(profit),0) AS total_profit
FROM orders
GROUP BY state
ORDER BY total_profit
LIMIT 5;
-- Q9. Which customers spent more than the average customer? (subquery)
SELECT customer_name, ROUND(SUM(sales),0) AS total_sales
FROM orders
GROUP BY customer_name
HAVING SUM(sales) > (
  SELECT AVG(cust_total) FROM (
    SELECT SUM(sales) AS cust_total FROM orders GROUP BY customer_id
  ) AS t
)
ORDER BY total_sales DESC;
-- Q10. What are the top 3 products by profit in each category?
SELECT * FROM (
  SELECT category, product_name, ROUND(SUM(profit),0) AS profit,
         RANK() OVER (PARTITION BY category ORDER BY SUM(profit) DESC) AS rnk
  FROM orders
  GROUP BY category, product_name
) ranked
WHERE rnk <= 3;
-- Q11. What is the year-over-year sales growth?
SELECT year, sales,
       ROUND((sales - LAG(sales) OVER (ORDER BY year)) / LAG(sales) OVER (ORDER BY year) * 100, 1) AS growth_pct
FROM (
  SELECT YEAR(order_date) AS year, SUM(sales) AS sales
  FROM orders GROUP BY YEAR(order_date)
) yearly;
-- Q12. Are there missing values or duplicates?
SELECT COUNT(*) AS rows_total,
       COUNT(DISTINCT row_id) AS unique_rows,
       SUM(sales IS NULL) AS null_sales,
       SUM(profit IS NULL) AS null_profit
FROM orders;