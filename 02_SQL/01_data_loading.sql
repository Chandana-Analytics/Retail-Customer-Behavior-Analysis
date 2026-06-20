-- ==========================================================
-- Project : Retail Customer Behavior Analysis Using SQL
-- Phase : Data Loading
-- ==========================================================

-- Create Database
CREATE DATABASE RETAIL_CUSTOMER_BEHAVIOR_DB;

-- Create Schema
CREATE SCHEMA RETAIL_ANALYSIS;

USE  DATABASE RETAIL_CUSTOMER_BEHAVIOR_DB;
USE SCHEMA RETAIL_ANALYSIS;

-- Create Raw Transaction Table
CREATE OR REPLACE TABLE raw_transactions (
    invoice VARCHAR,
    stockcode VARCHAR,
    description VARCHAR,
    quantity NUMBER,
    invoicedate TIMESTAMP,
    price NUMBER(10,2),
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
FILE_FORMAT = retail_csv_format;