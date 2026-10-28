-- ==========================================
-- Global Superstore Sales Analysis
-- File 02: Category profitability (Q2) and discount impact (Q3)
-- Author: Diya Chakraborty | Tool: MySQL 8.0
-- ==========================================

USE superstore_project;

-- Q2: Which product categories are losing money?

-- Q2a: Total profit by category
-- Finding: no category is negative overall, but Furniture is the
--          weakest by a wide margin.
SELECT category,
       SUM(profit) AS category_profit
FROM superstore_sales
GROUP BY category
ORDER BY category_profit ASC;

-- Q2b: Drill-down into Furniture sub-categories
-- Finding: Tables is losing money (about -$64K), while Chairs and
--          Bookcases are profitable enough to keep Furniture positive.
SELECT sub_category,
       SUM(profit) AS sub_category_profit
FROM superstore_sales
WHERE category = 'Furniture'
GROUP BY sub_category
ORDER BY sub_category_profit ASC;


-- Q3: Is there a relationship between discount level and profit?

-- Exploration: check which discount values exist, to choose sensible
-- bucket cutoffs (values range from 0 to 0.85).
SELECT DISTINCT discount
FROM superstore_sales
ORDER BY discount;

-- Q3: Profit by discount band
-- Bands: No Discount (0), Low (up to 20%), Medium (20-40%), High (above 40%)
-- Finding: profit turns negative once discounts exceed 20%.
--          High discounts lose about $90 per order on average.
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.2 THEN 'Low'
        WHEN discount <= 0.4 THEN 'Medium'
        ELSE 'High'
    END AS discount_range,
    SUM(profit) AS total_profit,
    ROUND(AVG(profit), 2) AS avg_profit_per_order
FROM superstore_sales
GROUP BY discount_range
ORDER BY discount_range;