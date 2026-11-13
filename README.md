# Retail Customer Behavior Analysis Using SQL

## Project Overview

This project analyzes customer purchasing behavior using the Online Retail II dataset from the UCI Machine Learning Repository. The objective is to understand how customers interact with a retail business by examining purchase frequency, customer spending, purchase volume, recency, and RFM segmentation.

I used Snowflake SQL to profile and clean the raw transaction data, calculate customer-level metrics, identify purchasing patterns, and segment customers based on their behavior. I also analyzed how gross customer spending was distributed across different customer groups.

The project concludes with business findings, overall insights, and recommendations based on the analysis.

## Business Problem

Retail businesses collect transaction data from customer purchases, but transaction records alone do not clearly explain customer behavior.

It can be difficult to identify:
- Which customers purchase most frequently?
- Which customers contribute the highest gross spending?
- Which customers purchase the largest quantities?
- How recently have customers made purchases?
- Which customer groups have different purchasing patterns and spending behavior?

The objective of this project was to transform raw transaction data into meaningful customer-level insights using SQL.

## Project Objectives

- Profile and clean retail transaction data before analysis.
- Analyze customer purchasing behavior using frequency, spending, purchase volume, and recency.
- Identify customer groups based on purchasing frequency.
- Apply RFM analysis to understand customer value and purchasing activity.
- Analyze gross spending contribution across customer groups.
- Develop business insights and recommendations from the analytical results.

## Dataset Overview

**Dataset:** Online Retail II  
**Source:** UCI Machine Learning Repository  
**Business type:** UK-based online retail business  
**Time period:** December 1, 2009 – December 9, 2011  
**Original records:** 1,067,371  
**Original columns:** 8  
**Currency:** GBP (£)

Each record represents an individual product transaction associated with an invoice. The dataset includes invoice number, stock code, product description, quantity, invoice date, unit price, customer ID, and country.

Since one invoice can contain multiple products, I aggregated transaction-level records into customer-level metrics for the analysis.

## Data Profiling and Cleaning

I examined the original dataset to identify missing customer IDs, cancelled invoices, negative quantities, and invalid prices.

The cleaning process excluded records based on the following conditions:

| Removal Category | Records Removed |
|---|---:|
| Missing Customer IDs | 243,007 |
| Cancelled Invoices | 18,744 |
| Invalid Quantities | 0 |
| Invalid Prices | 71 |
| **Total Excluded** | **261,822** |

Although 22,950 records with negative quantities were identified during profiling, they had already been excluded by the earlier missing Customer ID and cancelled-invoice conditions. Therefore, no additional records were removed at the quantity-cleaning step.

**Final cleaned dataset:**

- Original records: 1,067,371
- Excluded records: 261,822
- Retained records: 805,549
- Distinct customers after cleaning: 5,878

The original dataset contained 5,942 distinct Customer IDs, including IDs that appeared only in records excluded during cleaning. After cleaning, 5,878 customers remained.

## Analytical Approach

The project followed a structured workflow:

1. **Data Profiling:** Examined the dataset structure, missing values, duplicates, invalid values, and transaction details.
2. **Data Cleaning:** Removed missing customer IDs, cancelled invoice rows, and invalid transaction records.
3. **Customer-Level Metric Creation:** Calculated purchase frequency, spending, purchase volume, and recency for each customer.
4. **Customer Frequency Segmentation:** Grouped customers according to the number of distinct invoices.
5. **RFM Analysis:** Calculated Recency, Frequency, and Monetary metrics, assigned scores, and classified customers into seven segments.
6. **Revenue Contribution Analysis:** Examined gross customer spending across the top 20%, customer deciles, and RFM segments.
7. **Business Insights:** Interpreted the results and developed recommendations based on the findings.

## SQL Techniques Used

- **Common Table Expressions (CTEs):** Organized complex queries into readable steps.
- **Aggregate Functions:** Used SUM, COUNT, MIN, and MAX to calculate customer-level metrics.
- **Window Functions:** Used PERCENT_RANK, NTILE, and windowed SUM calculations for RFM scoring and revenue contribution analysis.
- **CASE Expressions:** Classified customers into frequency groups and RFM segments.
- **Date Functions:** Used DATEDIFF and date conversions to calculate customer recency.
- **GROUP BY and DISTINCT:** Aggregated transaction-level data and counted unique invoices.
- **ORDER BY:** Ranked and sorted customer analysis results.
- **Data Cleaning Conditions:** Filtered incomplete and invalid transaction records.

## Business Questions Answered

- Which customers place orders most frequently?
- How are customers distributed across purchase frequency groups?
- Which customers have the highest gross spending?
- Which customers purchase the largest quantities?
- How recently have customers made purchases?
- How can customers be classified using RFM analysis?
- What percentage of gross customer spending comes from the top 20% and top 10% of customers?
- How is gross spending distributed across customer deciles and RFM segments?

## Key Findings

### 1. Customer Purchase Frequency

The analysis identified four customer frequency groups:

| Customer Type | Customers | Customer Share |
|---|---:|---:|
| Occasional Buyer | 2,454 | 41.75% |
| One-Time Buyer | 1,623 | 27.61% |
| Frequent Buyer | 925 | 15.74% |
| Very Frequent Buyer | 876 | 14.90% |
| **Total** | **5,878** | **100.00%** |

Note: Percentages are rounded. 

Occasional Buyers formed the largest group, followed by One-Time Buyers. This showed that most customers placed orders occasionally or only once.

### 2. Customer Spending

Customers 18102, 14646, and 14156 were among the highest-spending customers.

Customer 16446 had £168,472.50 in calculated gross spending. However, £168,469.60 came from invoice 581483, which was cancelled through invoice C581484 on the same day, December 9, 2011. The original purchase remained in the cleaned dataset while the cancellation was excluded. This amount should therefore be interpreted with caution.

### 3. Purchase Volume

Customers 14646, 13902, 13694, 18102, and 14156 purchased the largest quantities of products.

The analysis showed that customers purchasing the largest quantities were not necessarily the highest spenders.

### 4. Customer Recency

Customer recency was calculated using the latest transaction date available in the cleaned dataset, December 9, 2011.

A recency value of zero means that a customer made a purchase on that latest available transaction date. The results showed differences in the time gaps between customers' purchases.

### 5. RFM Customer Segmentation

RFM analysis grouped 5,878 customers into seven segments:

| Customer Segment | Customers | Customer Share | Gross Spending (£) | Spending Contribution |
|---|---:|---:|---:|---:|
| Champions | 1,271 | 21.62% | 12,062,615.49 | 67.98% |
| Lost Customers | 1,565 | 26.62% | 536,216.02 | 3.02% |
| Regular Customers | 807 | 13.73% | 364,263.48 | 2.05% |
| Loyal Customers | 608 | 10.34% | 1,812,648.63 | 10.22% |
| At Risk | 586 | 9.97% | 1,263,919.46 | 7.12% |
| Potential Loyalists | 556 | 9.46% | 368,785.61 | 2.08% |
| Big Spenders | 485 | 8.25% | 1,334,980.49 | 7.52% |
| **Total** | **5,878** | **100.00%** | **17,743,429.18** | **100.00%** |

Note: Percentages are rounded.

Champions represented 21.62% of customers but contributed 67.98% of total gross customer spending.

Lost Customers formed the largest segment, representing 26.62% of the customer base.

### 6. Revenue Contribution Analysis

The analysis examined spending concentration across different customer groups:

- **Top 20% of customers:** Contributed 77.26% of total gross customer spending.
- **Top 10% of customers:** Contributed 63.93% of total gross customer spending.
- **RFM Champions:** Contributed 67.98% of total gross customer spending.

These findings showed that a relatively small group of customers accounted for a large share of total gross spending.

## Business Recommendations

Based on the findings:

1. **Encourage Repeat Purchases:** Study the purchasing patterns of Occasional and One-Time Buyers to identify opportunities to encourage repeat purchases.
2. **Monitor High-Contributing Customers:** Track spending patterns among high-contributing customers and maintain strong customer relationships.
3. **Evaluate Multiple Customer Metrics:** Consider both purchase quantity and gross spending when evaluating customer value.
4. **Understand Inactive Customer Behavior:** Examine the historical purchasing patterns of Lost Customers and identify possible re-engagement opportunities.
5. **Use Segment-Based Strategies:** Develop different approaches for Champions, Loyal Customers, Potential Loyalists, Big Spenders, At Risk, Lost Customers, and Regular Customers.

## Project Structure

### SQL Files

| File | Description |
|---|---|
| `01_data_loading.sql` | Loads the original dataset into Snowflake. |
| `02_data_profiling.sql` | Examines data quality and dataset characteristics. |
| `03_data_cleaning.sql` | Cleans transaction data and validates record removals. |
| `04_customer_behavior_analysis.sql` | Performs customer behavior analysis, RFM segmentation, and revenue contribution analysis. |

### Documentation Files

| File | Description |
|---|---|
| `01_dataset_understanding.md` | Dataset overview and column descriptions. |
| `02_project_overview.md` | Project purpose, scope, and workflow. |
| `03_data_profiling_findings.md` | Data profiling results. |
| `04_data_cleaning_findings.md` | Data cleaning findings and validation results. |
| `05_customer_behavior_findings.md` | Detailed customer behavior analysis results. |
| `06_Overall_Project_Insights.md` | Overall insights from the analysis. |
| `07_Business_Recommendations.md` | Business recommendations based on the findings. |

### Output Files

The following CSV files contain the results of the customer-level analyses:

| File | Description |
|---|---|
| `01_Purchase_Frequency_Results.csv` | Customer-level purchase frequency results. |
| `02_Customer_Frequency_Segmentation_Results.csv` | Customer counts and percentages by purchase frequency group. |
| `03_Customer_Spending_Results.csv` | Gross spending for each customer. |
| `04_Purchase_Volume_Results.csv` | Total purchase quantity for each customer. |
| `05_Customer_Recency_Results.csv` | Last purchase dates and recency values. |
| `06_RFM_Segmentation_Results.csv` | Customer RFM scores and assigned segments. |
| `07_Top_20_Percent_Revenue_Contribution.csv` | Gross spending contribution of customer groups divided into fifths. |
| `08_Customer_Decile_Revenue_Analysis.csv` | Gross spending contribution across ten customer groups. |
| `09_RFM_Segment_Revenue_Contribution.csv` | Customer counts and gross spending contribution by RFM segment. |

## How to Run the Project

1. Download the [Online Retail II dataset](https://archive.ics.uci.edu/dataset/502/online+retail+ii) from the UCI Machine Learning Repository.
2. Load the dataset into Snowflake by running `01_data_loading.sql`.
3. Execute `02_data_profiling.sql` to examine the dataset and identify data quality issues.
4. Run `03_data_cleaning.sql` to prepare and validate the cleaned transaction table.
5. Execute `04_customer_behavior_analysis.sql` to perform customer behavior analysis, RFM segmentation, and revenue contribution analysis.
6. Review the CSV output files for the individual analysis results.
7. Refer to the documentation files for detailed findings, overall insights, and business recommendations.

## Spending Calculation Note

All spending and revenue contribution figures in this project represent **gross customer spending**, calculated from retained transactions with positive quantities and positive prices.

Cancelled invoice rows and negative-quantity transactions were excluded. However, some original purchase transactions associated with cancelled invoices may remain if they were not themselves removed.

For example, customer 16446's original invoice of £168,469.60 remained in the cleaned data, even though the corresponding cancellation invoice was excluded.

Therefore, the reported spending figures should not be interpreted as net revenue after returns and cancellations.

## Project Conclusion

This project transformed raw retail transaction data into customer-level insights using Snowflake SQL. Through data profiling, cleaning, purchase behavior analysis, frequency segmentation, RFM analysis, and spending contribution analysis, I identified customer purchasing patterns and differences in customer value.

The findings showed that spending was concentrated among a relatively small group of customers, while the RFM analysis highlighted distinct customer groups with different purchasing behaviors.

This project demonstrates how SQL can be used to prepare data, analyze customer behavior, and generate findings that support business decision-making.