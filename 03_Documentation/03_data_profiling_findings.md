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

I identified cancelled transactions by checking invoice numbers beginning with `C`. The raw dataset contained 19,494 such records. Some of these records also had missing Customer IDs. After accounting for missing Customer IDs first, 18,744 additional records were excluded because they belonged to cancelled invoices.

## Returns and Negative Quantities

* **Records with negative quantities:** 22,950

I found negative quantities in the dataset. These records may represent returned items or stock adjustments.

After checking these records, I found that 4,206 had missing Customer IDs, while 18,744 were associated with cancelled invoices. All negative-quantity records were covered by these two conditions.

Since the analysis focuses on completed purchases, all negative-quantity records were excluded during cleaning. However, they were already covered by the missing Customer ID and cancelled-invoice conditions, so the positive quantity condition did not remove any additional records.

## Negative Prices

* **Records with negative prices:** 5

I found five records with negative prices. All five were already excluded by the missing Customer ID or cancelled-invoice conditions during cleaning. Therefore, the negative price condition did not result in any additional row exclusions.

## Zero Prices and Zero Quantities

* **Records with zero prices:** 6,202
* **Records with zero quantities:** 0

I also checked for zero prices and zero quantities. There were 6,202 records with zero prices, while no records had zero quantities. Zero-price records were excluded during cleaning because the analysis retains only transactions with positive prices. Of the 6,202 zero-price records, 6,131 had missing Customer IDs, and the remaining 71 were excluded by the price condition.

## Analysis Period

* **First transaction date:** 2009-12-01 07:45:00
* **Last transaction date:** 2011-12-09 12:50:00

The dataset covers approximately two years of retail transactions. This provides enough historical data to examine customer purchase frequency, spending patterns, and recency.

## Geographic Reach

* **Countries in the raw dataset:** 43
* **Countries represented after cleaning:** 41

I checked the Country column before and after cleaning. The raw dataset contained transactions from 43 countries, while 41 countries remained represented in the cleaned dataset.

## Exact Duplicate Transaction Lines

During data profiling, I identified 32,907 duplicate groups containing 34,335 extra duplicate rows in the raw dataset by comparing all eight transaction columns.

These extra rows represent additional occurrences beyond the first record in each duplicate group.

Exact duplicate transaction lines were not automatically removed during cleaning because identical-looking records were not necessarily confirmed data errors. They were retained for the analysis.

