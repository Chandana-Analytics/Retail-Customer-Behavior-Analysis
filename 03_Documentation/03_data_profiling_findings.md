# Data Profiling Findings

Before starting the analysis, I reviewed the raw dataset to identify any data quality issues and understand what records should be included in the customer behavior study.
## 1. Dataset Size
- Total transaction records loaded: 1,067,371
- The dataset is large enough to perform meaningful customer behavior analysis and identify long-term purchasing patterns.

## 2. Customer Coverage
- Unique customers identified: 5,942
- Records with missing Customer_ID: 243,007
- Since the main focus of this project is customer behavior, transactions without a customer identifier cannot be linked to an individual customer. These records will therefore be excluded from customer-level analyses.

## 3. Cancelled Transactions
- Cancelled transaction records: 19,494
- Invoices beginning with 'C' were identified as cancelled transactions. Including these records in purchase behavior calculations could distort metrics such as purchase frequency and retention. Therefore, they will be excluded from customer behavior analyses.

## 4. Returns and Negative Quantities
- Records with negative quantities: 22,950
- Negative quantities were treated as returns or order adjustments. Since the focus of this project is purchasing behavior, these records were excluded from the customer behavior dataset.

## 5. Negative Prices
- Records with negative prices: 5
- Only a very small number of records contained negative prices. Due to their negligible impact and uncertainty regarding their business meaning, these records will be excluded from the analytical datasets.

## 6. Analysis Period
- First transaction date: 2009-12-01 07:45:00
- Last transaction date: 2011-12-09 12:50:00
- The dataset covers approximately two years of retail activity, making it suitable for customer lifecycle analysis, repeat purchase analysis, and cohort analysis.

## 7. Geographic Reach
- Countries represented in the dataset: 43
- Customers were spread across 43 countries, showing that the business serves an international customer base.

