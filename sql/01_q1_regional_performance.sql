-- ==========================================
-- Global Superstore Sales Analysis
-- File 01: Regional performance (Q1)
-- Author: Diya Chakraborty | Tool: MySQL 8.0
-- ==========================================

USE superstore_project;

-- Q1: Which regions are high in sales but low in profit?
-- Approach: compare total sales, total profit and profit margin
--           (profit / sales) for each region.
-- Finding: Central leads in both sales and profit. South (2nd in sales,
--          9% margin) and Southeast Asia (2% margin) convert sales into
--          profit poorly. Canada has the lowest sales but the highest
--          margin (27%).

SELECT region,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit,
       ROUND(SUM(profit) / SUM(sales), 2) AS profit_margin
FROM superstore_sales
GROUP BY region
ORDER BY total_sales DESC;