# Data Cleaning Findings

After profiling the raw dataset, I identified records that needed to be removed before starting the customer behavior analysis. I used SQL in Snowflake to apply the cleaning conditions and prepare the dataset for further analysis.

## Cleaning Rules Applied

The following conditions were used to create the cleaned dataset:

* Excluded transactions with missing Customer IDs because they could not be linked to individual customers.
* Excluded cancelled invoices identified by invoice numbers starting with `C`.
* Excluded transactions with zero or negative quantities. Negative quantities may represent returned items or stock adjustments.
* Excluded transactions with zero or negative prices because the analysis focused on transactions with positive prices.

## Records Removed by Reason

I checked how many records were excluded under each cleaning condition. The counts below show the records removed at each step, without counting the same record more than once.

| Cleaning Condition          | Records Excluded |
| --------------------------- | --------------: |
| Missing Customer IDs        |         243,007 |
| Cancelled invoices          |          18,744 |
| Zero or negative quantities |               0 |
| Zero or negative prices     |              71 |
| **Total records excluded**  |     **261,822** |

The five records with negative prices were already excluded by the missing Customer ID and cancelled-invoice conditions. Therefore, they did not result in any additional row exclusions.

During profiling, I identified 22,950 records with negative quantities. Of these, 4,206 had missing Customer IDs and 18,744 were associated with cancelled invoices. All these records were already excluded by the earlier cleaning conditions, so the quantity condition did not remove any additional records.


## Cleaning Summary

* **Total records in raw dataset:** 1,067,371
* **Total records after cleaning:** 805,549
* **Records excluded during cleaning:** 261,822
* **Distinct customers remaining:** 5,878

After applying the cleaning conditions, 805,549 transaction records remained in the cleaned dataset.

## Records Kept on Purpose

I also made some decisions to retain certain records and values rather than removing them unnecessarily.

* **Non-product stock codes:** Retained because codes such as `POST`, `M`, and `C2` were not automatically removed.
* **Gross customer spending:** Calculated using retained transactions with positive quantities and positive prices. This represents gross spending, not net revenue after returns and cancellations.
* **Duplicate transaction lines:** Retained rather than automatically removed because identical-looking records were not necessarily confirmed data errors. The raw dataset contained 32,907 duplicate groups with 34,335 extra duplicate rows. After cleaning, 24,712 duplicate groups with 26,124 extra duplicate rows remained.


These decisions helped avoid removing records without sufficient reason.

## Price Data Type

The `PRICE` column was stored using `NUMBER(10,3)` in Snowflake to preserve prices recorded up to three decimal places. This avoids losing precision when prices contain values such as £0.001.

## Final Dataset

The cleaned dataset was used for all subsequent customer behavior analyses, including purchase frequency, customer frequency segmentation, customer spending, purchase volume, recency, RFM segmentation, and customer spending contribution analysis.

The total gross customer spending was **£17,743,429.18**, calculated from retained transactions with positive quantities and positive prices.

Cancelled invoice rows and negative-quantity transactions were excluded. However, original purchase transactions associated with cancelled invoices may remain if they were not themselves removed. Therefore, this amount should not be interpreted as net revenue after returns and cancellations.
