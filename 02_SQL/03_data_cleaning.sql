-- ==========================================================
-- Project : Retail Sales and Customer Behavior Analysis Using SQL
-- Phase   : Data Cleaning
-- ==========================================================

USE DATABASE RETAIL_CUSTOMER_BEHAVIOR_DB;
USE SCHEMA RETAIL_ANALYSIS;

-- Create dataset for customer behavior analysis
CREATE OR REPLACE TABLE clean_transactions AS
SELECT
    invoice,
    stockcode,
    description,
    quantity,
    invoicedate,
    price,
    customer_id,
    country
FROM raw_transactions
WHERE customer_id IS NOT NULL
    AND invoice NOT LIKE 'C%'
    AND quantity > 0
    AND price > 0;
    
-- Verify the number of cleaned records
SELECT COUNT(*) AS clean_records
FROM clean_transactions;    
    