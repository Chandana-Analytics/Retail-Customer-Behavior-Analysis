# Data Cleaning Findings

After profiling the raw dataset, I identified records that needed to be removed before starting the customer behavior analysis. I used SQL in Snowflake to apply the cleaning conditions and prepare the dataset for further analysis.

## Cleaning Rules Applied

The following conditions were used to create the cleaned dataset:

* Removed transactions with missing Customer IDs because they could not be linked to individual customers.
* Excluded cancelled invoices identified by invoice numbers starting with `C`.
* Removed transactions with zero or negative quantities. Negative quantities represented returned items or stock adjustments.
* Removed transactions with zero or negative prices because the analysis focused on transactions with positive prices.

## Records Removed by Reason

I checked how many records were excluded under each cleaning condition. The counts below show the records removed at each step, without counting the same record more than once.

| Cleaning Condition          | Records Removed |
| --------------------------- | --------------: |
| Missing Customer IDs        |         243,007 |
| Cancelled invoices          |          18,744 |
| Zero or negative quantities |               0 |
| Zero or negative prices     |              71 |
| **Total records excluded**  |     **261,822** |

The five records with negative prices were already excluded by the missing Customer ID and cancelled-invoice conditions. Therefore, they did not result in additional row exclusions.

Although 22,950 records with negative quantities were identified during profiling, they had already been excluded by the earlier missing Customer ID and cancelled-invoice conditions. Therefore, no additional records were removed at the quantity-cleaning step.


## Cleaning Summary

* **Total records in raw dataset:** 1,067,371
* **Total records after cleaning:** 805,549
* **Records excluded during cleaning:** 261,822
* **Distinct customers remaining:** 5,878

After applying the cleaning conditions, 805,549 transaction records remained in the cleaned dataset.

## Records Kept on Purpose

I also made some decisions to retain certain records and values rather than removing them unnecessarily.

* **Duplicate transaction lines:** Retained because identical-looking invoice lines were not automatically treated as errors.
* **Non-product stock codes:** Retained because codes such as `POST`, `M`, and `C2` were not automatically removed.
* **Gross customer spending:** Calculated using the retained transactions with positive quantities and positive prices.

These decisions helped avoid removing records without sufficient reason.

## Price Data Type

The `PRICE` column was stored using `NUMBER(10,3)` in Snowflake to preserve prices recorded up to three decimal places. This avoids losing precision when prices contain values such as £0.001.

## Final Dataset

The cleaned dataset was used for all subsequent customer behavior analyses, including purchase frequency, customer frequency segmentation, customer spending, purchase volume, recency, RFM segmentation, and revenue contribution analysis.

The total gross customer spending was **£17,743,429.18**, calculated from retained transactions with positive quantities and positive prices.

Cancelled invoice rows and negative-quantity return transactions were excluded. However, original purchase transactions associated with cancelled invoices may remain if they were not themselves removed. Therefore, this amount should not be interpreted as net revenue after returns and cancellations.
