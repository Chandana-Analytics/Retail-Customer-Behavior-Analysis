-- ==========================================================
-- Project : Retail Customer Behavior Analysis Using SQL
-- Phase : Data Loading
-- ==========================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS RETAIL_CUSTOMER_BEHAVIOR_DB;

-- Create Schema
CREATE SCHEMA IF NOT EXISTS RETAIL_ANALYSIS;

USE  DATABASE RETAIL_CUSTOMER_BEHAVIOR_DB;
USE SCHEMA RETAIL_ANALYSIS;

-- Create Raw Transaction Table
CREATE OR REPLACE TABLE raw_transactions (
    invoice VARCHAR,
    stockcode VARCHAR,
    description VARCHAR,
    quantity NUMBER,
    invoicedate TIMESTAMP,
    price NUMBER(10,3),
    customer_id NUMBER,
    country VARCHAR
);

-- Create File Format
CREATE OR REPLACE FILE FORMAT retail_csv_format
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
TRIM_SPACE = TRUE
EMPTY_FIELD_AS_NULL = TRUE
NULL_IF = ('');

-- Create Stage
CREATE OR REPLACE STAGE retail_stage
FILE_FORMAT = retail_csv_format
DIRECTORY = (ENABLE = TRUE)
ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');

-- Upload online_retail_II.csv to the stage in Snowsight
-- then run the statements below.

-- Check the uploaded file name
LIST @retail_stage;

-- Load the data into the raw table
COPY INTO raw_transactions
FROM @retail_stage/online_retail_II.csv
FILE_FORMAT = (FORMAT_NAME = retail_csv_format);

-- Verify the number of loaded records (1,067,371 expected)
SELECT COUNT(*) AS total_rows
FROM raw_transactions;


