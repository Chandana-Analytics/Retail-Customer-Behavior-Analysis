# Customer Behavior Analysis Findings

## 1. Purchase Frequency Analysis

I analyzed how frequently customers placed orders using the number of distinct invoices for each customer. Occasional Buyers formed the largest segment with 2,454 customers, followed by 1,623 One-Time Buyers. The analysis also identified 925 Frequent Buyers and 876 Very Frequent Buyers.

This showed that most customers purchased occasionally or only once, while a smaller group placed orders more frequently.

## 2. Customer Spending Analysis

I analyzed the total gross spending of each customer using their purchase quantities and unit prices. Customers 18102, 14646, and 14156 were among the highest-spending customers.

Customer 16446 also appeared among the highest-spending customers, with £168,472.50 in gross spending. However, £168,469.60 of this amount came from invoice 581483, which was cancelled through invoice C581484 on the same day (December 9, 2011). Since the original purchase transaction remained in the cleaned dataset while the cancellation was excluded, this amount is included in the spending calculation and should be interpreted with caution.

The results showed that a relatively small group of customers contributed a substantial share of total customer spending.

## 3. Purchase Volume Analysis

I compared the total quantities purchased by each customer. Customers 14646, 13902, 13694, 18102, and 14156 purchased the highest quantities of products.

When I compared these results with customer spending, I found that customers who purchased the largest quantities were not always the highest spenders.

## 4. Customer Recency Analysis

I calculated how many days had passed since each customer's last purchase. Several customers had recency values of 0 days, meaning they purchased on the latest transaction date available in the dataset.

The results also showed differences in customer activity, with some customers purchasing recently while others had longer gaps since their last purchase.

## 5. RFM Customer Segmentation Analysis

I used Recency, Frequency, and Monetary values to group customers based on their purchasing behavior.

The analysis identified the following customer segments:

| Customer Segment    | Customers | Customer Share | Gross Spending (£) | Gross Spending Contribution |
| ------------------- | --------: | -------------: | -----------------: | -------------------: |
| Champions           |     1,271 |         21.62% |      12,062,615.49 |               67.98% |
| Lost Customers      |     1,565 |         26.62% |         536,216.02 |                3.02% |
| Regular Customers   |       807 |         13.73% |         364,263.48 |                2.05% |
| Loyal Customers     |       608 |         10.34% |       1,812,648.63 |               10.22% |
| At Risk             |       586 |          9.97% |       1,263,919.46 |                7.12% |
| Potential Loyalists |       556 |          9.46% |         368,785.61 |                2.08% |
| Big Spenders        |       485 |          8.25% |       1,334,980.49 |                7.52% |
| **Total**           | **5,878** |     **100.00%** |  **17,743,429.18** |           **100.00%** |

Percentages are rounded.

Lost Customers formed the largest segment, representing 26.62% of customers. Champions represented 21.62% of customers but contributed 67.98% of total gross customer spending.

This showed that the percentage of customers in a segment and its contribution to total spending can be very different.

## 6. Revenue Contribution Analysis

I also analyzed how customer spending was distributed across different customer groups.

* **Top 20% of customers:** Contributed 77.26% of total gross customer spending.
* **Top 10% of customers:** Contributed 63.93% of total gross customer spending.
* **RFM Champions:** Contributed 67.98% of total gross customer spending.

The results showed that a relatively small group of customers accounted for a large share of total gross spending. The RFM segment analysis also showed the strong spending contribution of Champions.

These figures are based on retained transactions with positive quantities and positive prices. Cancelled invoice rows and negative-quantity return transactions were excluded. However, original purchases associated with cancelled invoices may remain if they were not themselves removed. Therefore, these figures represent gross customer spending, not net revenue after returns and cancellations.
