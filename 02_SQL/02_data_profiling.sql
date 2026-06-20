-- ==========================================================
-- Project : Retail Customer Behavior Analysis Using SQL
-- Phase : Data Profiling
-- ==========================================================

USE DATABASE RETAIL_CUSTOMER_BEHAVIOR_DB;
USE SCHEMA RETAIL_ANALYSIS;

-- Total Records
SELECT COUNT(*) AS total_rows
FROM raw_transactions;

-- Unique Customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM raw_transactions;

-- Missing Customer IDs
SELECT COUNT(*) AS missing_customer_records
FROM raw_transactions
WHERE customer_id IS NULL;

-- Cancelled Transactions
SELECT COUNT(*) AS cancelled_invoice_rows
FROM raw_transactions
WHERE invoice LIKE 'C%';

-- Negative Quantities
SELECT COUNT(*) AS negative_quantity_rows
FROM raw_transactions
WHERE quantity < 0;

-- Negative Prices
SELECT COUNT(*) AS negative_price_rows
FROM raw_transactions
WHERE price < 0;

-- Transaction Period
SELECT
    MIN(invoicedate) AS first_transaction,
    MAX(invoicedate) AS last_transaction
FROM raw_transactions;

-- Countries Served
SELECT COUNT(DISTINCT country) AS countries_served
FROM raw_transactions;

