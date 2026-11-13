# Data Profiling Findings

Before starting the customer behavior analysis, I explored the raw dataset in Snowflake using SQL to understand its size, check data quality issues, and identify records that needed attention before cleaning.

## Dataset Size

* **Total transaction records:** 1,067,371

I checked the total number of records loaded into the raw table to understand the size of the dataset before starting the analysis.

## Customer Coverage

* **Unique Customer IDs:** 5,942
* **Records with missing Customer IDs:** 243,007

I found that many transactions did not have a Customer ID. Since my analysis focuses on individual customer purchasing behavior, these records cannot be linked to identified customers and were excluded during cleaning.

After cleaning, 5,878 customers remained for the analysis.

## Cancelled Transactions

* **Cancelled invoice records:** 19,494

I identified cancelled transactions by checking invoice numbers beginning with `C`. These records were excluded during cleaning because they do not represent completed purchases.

## Returns and Negative Quantities

* **Records with negative quantities:** 22,950

I found negative quantities in the dataset. These records represent returned items or stock adjustments. Around 19,500 were associated with cancelled or return invoices, while the remaining 3,457 records had no Customer ID.

Since the analysis focuses on completed purchases, all negative-quantity records were excluded during cleaning.

## Negative Prices

* **Records with negative prices:** 5

I found five records with negative prices. All five were already excluded by the missing Customer ID and cancelled-invoice conditions during cleaning. Therefore, they did not result in any additional row exclusions.

## Zero Prices and Zero Quantities

* **Records with zero prices:** 6,202
* **Records with zero quantities:** 0

I also checked for zero prices and zero quantities. There were 6,202 records with zero prices, while no records had zero quantities. Zero-price records were excluded during cleaning because the analysis retains only transactions with positive prices. Of the 6,202 zero-price records, 6,131 have no Customer ID, and 71 were removed by the price condition.

## Analysis Period

* **First transaction date:** 2009-12-01 07:45:00
* **Last transaction date:** 2011-12-09 12:50:00

The dataset covers approximately two years of retail transactions. This provides enough historical data to examine customer purchase frequency, spending patterns, and recency.

## Geographic Reach

* **Countries in the raw dataset:** 43
* **Countries represented after cleaning:** 41

I checked the Country column before and after cleaning. The raw dataset contained transactions from 43 countries, while 41 countries remained represented in the cleaned dataset.
