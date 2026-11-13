# Dataset Understanding

## Project Title

**Retail Customer Behavior Analysis Using SQL**

## Dataset Overview

This project uses the **Online Retail II** dataset, which contains historical transaction records from a UK-based online retail business. The dataset helps analyze customer purchasing patterns, spending behavior, purchase frequency, and customer segments.

**Source:** Online Retail II dataset (UCI Machine Learning Repository).

## Original Dataset Details

* **Total Records:** 1,067,371
* **Distinct Customer IDs:** 5,942 (5,878 remain after cleaning; see Data Cleaning Findings)
* **Number of Countries:** 43
* **Date Range:** 1 December 2009 to 9 December 2011
* **Number of Columns:** 8
* **Currency:** Prices are recorded in pounds sterling (£).

## Dataset Grain

The dataset is structured at the **invoice-line level**. Each row represents one product line within an invoice. An invoice can contain multiple product lines because a customer may purchase different products in one order.

For order-frequency analysis, distinct invoice numbers are counted rather than individual rows.

## Column Description

| Column      | Description                                 | Business Meaning                                                                                                                                                                          |
| ----------- | ------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Invoice     | Invoice number assigned to each transaction | Identifies an invoice or order. Invoice numbers beginning with `C` indicate cancelled invoices.                                                                                           |
| StockCode   | Product code                                | Identifies the product purchased.                                                                                                                                                         |
| Description | Product description                         | Provides the name or description of the product.                                                                                                                                          |
| Quantity    | Number of units purchased                   | Represents the quantity of products in an invoice line. Negative quantities represent returned items or stock adjustments. These records are examined during data profiling and cleaning. |
| InvoiceDate | Date and time of the transaction            | Shows when the transaction occurred.                                                                                                                                                      |
| Price       | Unit price of the product                   | Unit selling price of a product recorded in an invoice line, expressed in pounds sterling (£).                                                                                            |
| Customer ID | Unique identifier assigned to a customer    | Helps identify and analyze individual customer purchasing behavior. Missing customer IDs cannot be directly associated with an identified customer for customer-level analysis.           |
| Country     | Customer's country                          | Identifies the country associated with the transaction.                                                                                                                                   |

## Key Analytical Fields

The following fields are important for customer behavior analysis:

* **Customer ID:** Used to identify individual customers.
* **InvoiceDate:** Used to analyze purchase dates and customer recency.
* **Invoice:** Used to calculate the number of distinct orders.
* **Quantity:** Used to measure the number of units purchased.
* **Price:** Used to calculate customer spending.

## Planned Analysis Areas

The project focuses on the following areas:

1. Purchase Frequency Analysis
2. Customer Frequency Segmentation
3. Customer Spending Analysis
4. Purchase Volume Analysis
5. Customer Recency Analysis
6. RFM Customer Segmentation
7. Revenue Contribution Analysis

## Business Objective

The main objective of this project is to understand customer purchasing behavior using historical retail transaction data.

The analysis focuses on identifying how frequently customers purchase, how much they spend, when they last purchased, and how customers can be grouped into meaningful segments.

It also examines customer spending patterns and revenue contribution to identify high-value customer groups and support better business decision-making.
