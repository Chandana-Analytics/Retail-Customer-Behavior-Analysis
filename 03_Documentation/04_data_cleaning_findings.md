\# Data Cleaning Findings



The raw dataset contained cancelled orders, transactions without customer identifiers, and a small number of records with invalid quantity or price values. To ensure that the analysis reflected genuine purchasing behavior, these records were excluded from the final dataset.



\## The following cleaning rules were applied:



\- Removed transactions with missing Customer\_ID values.

\- Excluded cancelled orders identified by invoice numbers starting with 'C'.

\- Removed transactions with negative quantities, as they represented returns rather than completed purchases.

\- Removed transactions with negative prices because they did not represent valid sales transactions.



\## Cleaning Summary



\- Total records in raw dataset: 1,067,371

\- Total records after cleaning: 805,531

\- Records excluded during cleaning: 261,840



After applying these rules, the cleaned dataset contained 805,531 valid purchase records. This dataset was used for all subsequent analyses in the project, including customer purchasing patterns, sales trends, and business insights.

