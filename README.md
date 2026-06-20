\# Retail Customer Behavior Analysis using SQL



\## Project Overview



This project analyzes customer purchasing behavior using online retail transaction data. The objective was to understand how customers interact with the business by examining purchase frequency, customer spending, purchase volume, recent purchasing activity, and RFM segmentation.



The project began with data profiling and cleaning to identify records that could affect the analysis, including cancelled transactions, missing customer IDs, and invalid values. After preparing the data, customer-level analyses were performed to identify purchasing patterns, customer value, and differences in customer activity.



The analysis provides a clearer understanding of customer behavior and supports business decision-making through structured findings, overall insights, and data-driven recommendations.



\## Business Problem



Retail businesses collect transaction data from every customer purchase, but transaction records alone do not explain customer behavior. It is difficult to identify which customers purchase most frequently, generate the highest revenue, remain active, or have stopped purchasing over time.



The objective of this project was to transform raw transaction data into meaningful customer-level insights using SQL, helping the business better understand customer purchasing behavior and customer value.



\## Project Objectives



\* Clean and prepare retail transaction data for reliable customer-level analysis.

\* Analyze customer purchasing behavior using frequency, spending, purchase volume, and recency metrics.

\* Identify customer segments using RFM analysis to better understand customer value and engagement.

\* Transform analytical results into meaningful business insights and recommendations to support data-driven decision-making.

\* Provide a structured understanding of customer behavior to support customer-focused business decisions.



\## Dataset Overview



This project uses the \*\*Online Retail\*\* dataset, which contains transactional records from a UK-based online retail business. Each record represents an individual product purchased as part of a customer invoice and includes information such as invoice number, product description, quantity, invoice date, unit price, customer ID, and country.



Since a single invoice can contain multiple products, the dataset was transformed from transaction-level records into customer-level metrics to support customer behavior analysis.



\## Analytical Approach



The project followed a structured analytical workflow to transform raw transaction data into meaningful customer-level insights:



1\. \*\*Data Profiling and Cleaning\*\* – Examined the dataset to identify missing customer IDs, cancelled transactions, negative quantities, and invalid price records before preparing the data for analysis.



2\. \*\*Customer-Level Metric Creation\*\* – Aggregated transaction-level records into customer-level metrics, including purchase frequency, customer spending, purchase volume, and recency.



3\. \*\*Customer Behavior Analysis\*\* – Analyzed purchase frequency, customer spending, purchase volume, and recent purchasing activity to understand different aspects of customer behavior.



4\. \*\*Customer Segmentation\*\* – Applied RFM analysis to classify customers into meaningful segments based on purchasing behavior and customer value.



5\. \*\*Business Insights and Recommendations\*\* – Converted the analytical results into business findings, overall insights, and recommendations to support data-driven decision-making.





\## SQL Techniques Used



The project applies a range of SQL techniques to transform transaction-level data into customer-level insights, including:



\* Common Table Expressions (CTEs) to build modular and readable queries.

\* Aggregate functions to calculate customer-level metrics such as purchase frequency, customer spending, purchase volume, and recency.

\* Window functions to rank customers and calculate RFM scores.

\* CASE expressions to classify customers into meaningful segments.

\* Date functions to measure customer recency.

\* GROUP BY and DISTINCT to aggregate transaction-level records into customer-level metrics.

\* ORDER BY and LIMIT to rank customers and identify top-performing customers.

\* Data cleaning techniques to remove invalid and incomplete records before analysis.



\## Business Questions Answered



This project answers the following business questions:



\* Which customers purchase most frequently?

\* Which customers contribute the highest revenue?

\* Which customers purchase the largest quantities of products?

\* Which customers have purchased recently, and which customers have become inactive?

\* How can customers be segmented based on their purchasing behavior using RFM analysis?



\## Key Findings



\* Most customers placed only one or a few orders, while a relatively small group of customers made frequent purchases.

\* Customer revenue was concentrated among a relatively small number of customers, with only a few customers generating substantially higher revenue than the rest of the customer base.

\* Customers purchasing the largest product quantities were not always the highest revenue contributors.

\* Customer activity varied across the customer base, with both active and inactive purchasing patterns observed.

\* RFM segmentation identified distinct customer groups with different purchasing behaviors and customer value, including Champions, Loyal Customers, and Lost Customers.



\## How to Run the Project



1\. Download the original \*\*Online Retail\*\* dataset from Kaggle.

2\. Load the dataset into Snowflake by running `data\_loading.sql`.

3\. Execute `data\_profiling.sql` to examine the dataset and identify data quality issues.

4\. Run `data\_cleaning.sql` to prepare the dataset for analysis.

5\. Execute `customer\_behavior\_analysis.sql` to perform customer behavior analysis and RFM segmentation.

6\. Review the documentation files for detailed findings, overall project insights, and business recommendations.



\## Project Conclusion



This project successfully transformed raw retail transaction data into meaningful customer-level insights using SQL. Through data profiling, data cleaning, customer behavior analysis, and RFM segmentation, the project identified purchasing patterns, high-value customers, and differences in customer activity across the customer base. The resulting findings, insights, and business recommendations demonstrate how SQL can be used to support customer analysis and informed business decision-making.







