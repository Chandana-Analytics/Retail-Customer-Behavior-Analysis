-- ==========================================================
-- Project : Retail Customer Behavior Analysis Using SQL
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
    
-- Verify the cleaned dataset
SELECT
    COUNT(*) AS clean_records,
    COUNT(DISTINCT customer_id) AS clean_customers,
    ROUND(SUM(quantity * price), 2) AS total_revenue
FROM clean_transactions;  
    
-- ==========================================
-- CLEANING VERIFICATION: RECORDS REMOVED
-- ==========================================

WITH removal_check AS (
    SELECT
        COUNT_IF(customer_id IS NULL) AS missing_customer_id,

        COUNT_IF(
            customer_id IS NOT NULL
            AND invoice LIKE 'C%'
        ) AS cancelled_invoices,

        COUNT_IF(
            customer_id IS NOT NULL
            AND invoice NOT LIKE 'C%'
            AND quantity <= 0
        ) AS invalid_quantities,

        COUNT_IF(
            customer_id IS NOT NULL
            AND invoice NOT LIKE 'C%'
            AND quantity > 0
            AND price <= 0
        ) AS invalid_prices
    FROM raw_transactions
)
SELECT
    missing_customer_id,
    cancelled_invoices,
    invalid_quantities,
    invalid_prices,
    missing_customer_id
        + cancelled_invoices
        + invalid_quantities
        + invalid_prices AS total_excluded
FROM removal_check;