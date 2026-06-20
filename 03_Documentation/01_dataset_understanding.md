## Dataset Understanding

## Project Title :
# Retail Customer Behavior Analysis Using SQL

## Dataset Overview

- This project uses the Online Retail II dataset, which contains historical transaction records from a UK-based online retail business.
- The dataset captures customer purchases, product information, quantities ordered, transaction dates, prices, and customer identifiers.
- It provides enough transactional detail to analyze how customers purchase over time, how frequently they return, and how customer behavior influences overall revenue.
- The primary focus of this project is customer behavior analysis rather than product performance reporting.

## Dataset Grain

- The dataset is recorded at the invoice-line level.
- Each row represents a single product within an invoice.
- A single invoice may contain multiple products, which means one customer order can be represented by multiple rows.
**Because of this:**
- Total rows do not represent total orders.
- Invoice numbers represent purchase events.
- Customer behavior analysis must account for multiple rows belonging to the same order.

## Column Definitions :

### 1. Invoice

**Business Meaning :**
Unique identifier assigned to a transaction or customer order.
**Example**
536365
**How It Will Be Used**
- Count customer orders
- Measure purchase frequency
- Identify repeat purchases
- Investigate cancelled transactions

### 2. StockCode

**Business Meaning :**
Unique identifier assigned to a product.
**Example**
85123A
**How It Will Be Used**
- StockCode can support product-level analysis if required. Since the main objective of this project is customer behavior analysis, it will primarily serve as a supporting attribute rather than a core analytical field.

### 3. Description

**Business Meaning:**
Product name or product description.
**Example**
WHITE HANGING HEART T-LIGHT HOLDER
**How It Will Be Used**
- Provides business context when reviewing products involved in customer transactions.

### 4. Quantity

**Business Meaning:**
Number of units purchased within a transaction.
**Example**
12
**How It Will Be Used**
- Revenue calculations
- Customer purchasing behavior analysis
- Transaction validation

### Note
Negative quantities appear in the dataset and will be investigated during the data profiling stage to determine whether they represent returns or cancelled transactions.

### 5. InvoiceDate

**Business Meaning:**
Date and time when a transaction occurred.
**Example**
01-12-2010 08:26
**How It Will Be Used**
- This is one of the most important fields in the project because it enables:
- Measure customer recency
- Support RFM segmentation
- Track customer purchasing activity over time

### 6. Price

**Business Meaning:**
Unit selling price of a product.
**Example**
2.55
**How It Will Be Used**
- Calculate customer spending
- Identify high-value customers
- Support Monetary analysis in RFM segmentation

### 7. customer ID

**Business Meaning:**
Unique identifier assigned to a customer.
**Example**
17850
**How It Will Be Used**
- Customer ID is the key field used throughout the project because it allows transactions to be linked to individual customers.
**This field enables:**
- Identify unique customers
- Measure purchase frequency
- Analyze customer spending patterns
- Perform recency analysis
- Support RFM segmentation
Without Customer ID, customer behavior analysis would not be possible.

### 8. Country

**Business Meaning**
Country associated with the customer transaction.
**Example**
United Kingdom
**How It Will Be Used**
- Country is not a primary focus of this project but may be used for supporting analysis and geographic context where appropriate.

### Key Analytical Fields

**The project primarily relies on the following columns:**
- Customer ID
- InvoiceDate
- Invoice
- Quantity
- Price
These fields provide the foundation for customer behavior and revenue analysis.

### Planned Analysis Areas

**The dataset will be used to support:**
- Purchase Frequency Analysis
- Customer Spending Analysis
- Purchase Volume Analysis
- Customer Activity (Recency) Analysis
- RFM Customer Segmentation
- Revenue Contribution Analysis

### Business Objective
- The objective of this project is to understand customer purchasing behavior over time using transactional data.
- The analysis will focus on understanding how often customers purchase,how much they spend, how active they remain over time, and how different customergroups contribute to overall revenue.
- Rather than producing basic sales reports, the project aims to use SQL to build a behavioral view of customers and generate business insights that support data-driven decision-making.

