-- ==========================================
-- Global Superstore Sales Analysis
-- File 03: Discounting vs margin (Q4) and seasonality (Q5, Q6)
-- Author: Diya Chakraborty | Tool: MySQL 8.0
-- ==========================================

USE superstore_project;

-- Q4: Which categories are over-discounted relative to their profit margin?
-- Approach: compare average discount with profit margin for each category.
-- Finding: Furniture has the highest average discount (17%) but the lowest
--          margin (7%). Office Supplies and Technology both sit at a 14%
--          discount and 14% margin.
SELECT category,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit,
       ROUND(SUM(profit) / SUM(sales), 2) AS profit_margin,
       ROUND(AVG(discount), 2) AS average_discount
FROM superstore_sales
GROUP BY category
ORDER BY category;


-- Q5: Which months have the highest and lowest sales? Is there a seasonal pattern?
-- Note: all years are combined to show the repeating yearly pattern.
-- Finding: low season Jan-Apr, high season Aug-Dec. February is the lowest
--          month and December the highest (nearly 3x February).
SELECT MONTH(order_date) AS month,
       SUM(sales) AS monthly_sales
FROM superstore_sales
GROUP BY month
ORDER BY month ASC;


-- Q6: Are some categories seasonal while others stay flat?
-- Finding: all three categories follow the same seasonal pattern, so
--          seasonality is driven by general shopping periods rather than
--          category-specific demand. The size of the swing differs by category.
SELECT category,
       MONTH(order_date) AS month,
       SUM(sales) AS monthly_sales
FROM superstore_sales
GROUP BY category, month
ORDER BY category, month;