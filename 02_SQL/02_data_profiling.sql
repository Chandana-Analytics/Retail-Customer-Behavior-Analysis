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

-- Zero Prices
SELECT COUNT(*) AS zero_price_rows
FROM raw_transactions
WHERE price = 0;

-- Zero Quantities
SELECT COUNT(*) AS zero_quantity_rows
FROM raw_transactions
WHERE quantity = 0;

-- Transaction Period
SELECT
    MIN(invoicedate) AS first_transaction,
    MAX(invoicedate) AS last_transaction
FROM raw_transactions;

-- Countries Served
SELECT COUNT(DISTINCT country) AS countries_served
FROM raw_transactions;

-- Exact Duplicate Transaction Lines in Raw Dataset
WITH duplicate_check AS (
    SELECT COUNT(*) AS duplicate_count
    FROM raw_transactions
    GROUP BY
        invoice,
        stockcode,
        description,
        quantity,
        invoicedate,
        price,
        customer_id,
        country
    HAVING COUNT(*) > 1
)
SELECT
    COUNT(*) AS duplicate_groups,
    COALESCE(SUM(duplicate_count - 1), 0)
        AS extra_duplicate_rows
FROM duplicate_check;

-- Negative Quantity Records: Removal Breakdown
SELECT
    COUNT_IF(customer_id IS NULL) AS missing_customer_id,
    COUNT_IF(
        customer_id IS NOT NULL
        AND invoice LIKE 'C%'
    ) AS cancelled_invoices,
    COUNT_IF(
        customer_id IS NOT NULL
        AND invoice NOT LIKE 'C%'
    ) AS remaining_records
FROM raw_transactions
WHERE quantity < 0;