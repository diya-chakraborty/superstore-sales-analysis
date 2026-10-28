-- ==========================================
-- Global Superstore Sales Analysis
-- File 00: Database setup and data import
-- Author: Diya Chakraborty | Tool: MySQL 8.0
-- ==========================================

-- Step 1: Create and select the database
CREATE DATABASE IF NOT EXISTS superstore_project;
USE superstore_project;

-- Step 2: Create the table (drop first so the script can be re-run)
DROP TABLE IF EXISTS superstore_sales;

CREATE TABLE superstore_sales (
    order_id VARCHAR(30),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    state VARCHAR(100),
    country VARCHAR(100),
    market VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DOUBLE,
    quantity INT,
    discount DOUBLE,
    profit DOUBLE,
    shipping_cost DOUBLE,
    order_priority VARCHAR(20),
    year INT
);

-- Step 3: Load the CSV
-- Note: the CSV must be placed in MySQL's secure upload folder.
-- Dates are converted from DD-MM-YYYY text to DATE format.
-- Sales values contain thousands separators (e.g. "1,234"), so commas are removed before loading.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Project 1 dataset.csv'
INTO TABLE superstore_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id, @order_date, @ship_date, ship_mode, customer_name,
    segment, state, country, market, region, product_id,
    category, sub_category, product_name, @sales, quantity,
    discount, profit, shipping_cost, order_priority, year
)
SET
    order_date = STR_TO_DATE(@order_date, '%d-%m-%Y'),
    ship_date  = STR_TO_DATE(@ship_date, '%d-%m-%Y'),
    sales      = REPLACE(@sales, ',', '');

-- Step 4: Verify the import (expected: 51,290 rows)
SELECT COUNT(*) AS total_rows
FROM superstore_sales;