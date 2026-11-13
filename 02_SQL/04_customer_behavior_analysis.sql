/*====================================================
Customer Purchase Frequency Analysis
====================================================*/
-- Business Question:
-- How often do customers make purchases?
SELECT
    customer_id,
    COUNT(DISTINCT invoice) AS total_orders
FROM clean_transactions
GROUP BY customer_id
ORDER BY total_orders DESC;

/*====================================================
Customer Frequency Segmentation
====================================================*/

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice) AS total_orders
    FROM clean_transactions
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time Buyer'
        WHEN total_orders BETWEEN 2 AND 5 THEN 'Occasional Buyer'
        WHEN total_orders BETWEEN 6 AND 10 THEN 'Frequent Buyer'
        ELSE 'Very Frequent Buyer'
    END AS customer_type,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage
FROM customer_orders
GROUP BY customer_type
ORDER BY customer_count DESC;

/*====================================================
Customer Spending Analysis
====================================================*/
-- Business Question:
-- Which customers contribute the highest gross spending?
--
-- Calculates gross spending from retained positive-quantity,
-- positive-price transactions in clean_transactions.
-- Cancelled invoice rows and negative-quantity return rows
-- are excluded.
SELECT
    customer_id,
    ROUND(
        SUM(quantity * price),
        2
    ) AS total_spent
FROM clean_transactions
GROUP BY customer_id
ORDER BY total_spent DESC;


/*====================================================
Customer Purchase Volume Analysis
====================================================*/
-- Business Question:
-- Which customers purchase the largest quantities of products?
SELECT
    customer_id,
    SUM(quantity) AS total_quantity_purchased
FROM clean_transactions
GROUP BY customer_id
ORDER BY total_quantity_purchased DESC;

/*====================================================
Customer Recency Analysis
====================================================*/
-- Business Question:
-- How recently have customers made purchases?

SELECT
    customer_id,
    TO_VARCHAR(
     MAX(invoicedate),
     'YYYY-MM-DD HH24:MI:SS'
) AS last_purchase_date,
    DATEDIFF(
        DAY,
        MAX(invoicedate),
        (
            SELECT MAX(invoicedate)
            FROM clean_transactions
        )
    ) AS recency_days
FROM clean_transactions
GROUP BY customer_id
ORDER BY recency_days;



/*====================================================
RFM Customer Value Segmentation Analysis
====================================================*/
-- Business Question:
-- How can customers be segmented based on Recency, Frequency, and Monetary behavior?
-- Calculate Customer-level RFM metrics
WITH reference_date AS (
    SELECT MAX(invoicedate) AS latest_purchase_date
    FROM clean_transactions
)
SELECT
    customer_id,
    DATEDIFF(
        DAY,
        MAX(invoicedate),
        (SELECT latest_purchase_date FROM reference_date)
    ) AS recency,
    COUNT(DISTINCT invoice) AS frequency,
    ROUND(
        SUM(quantity * price),
        2
    ) AS monetary
FROM clean_transactions
GROUP BY customer_id;

-- Validate RFM Metric ranges

WITH reference_date AS (
    SELECT MAX(invoicedate) AS latest_purchase_date
    FROM clean_transactions
),
rfm_metrics AS (
    SELECT
        customer_id,
        DATEDIFF(
            DAY,
            MAX(invoicedate),
            (SELECT latest_purchase_date FROM reference_date)
        ) AS recency,
        COUNT(DISTINCT invoice) AS frequency,
        ROUND(SUM(quantity * price), 2) AS monetary
    FROM clean_transactions
    GROUP BY customer_id
)
SELECT
    MIN(recency) AS min_recency,
    MAX(recency) AS max_recency,
    MIN(frequency) AS min_frequency,
    MAX(frequency) AS max_frequency,
    MIN(monetary) AS min_monetary,
    MAX(monetary) AS max_monetary
FROM rfm_metrics;

-- Create RFM Scores

CREATE OR REPLACE TABLE rfm_scores AS
WITH reference_date AS (
    SELECT MAX(invoicedate) AS latest_purchase_date
    FROM clean_transactions
),
rfm_metrics AS (
    SELECT
        customer_id,
        DATEDIFF(
            DAY,
            MAX(invoicedate),
            (SELECT latest_purchase_date
             FROM reference_date)
        ) AS recency,
        COUNT(DISTINCT invoice) AS frequency,
        ROUND(SUM(quantity * price),2) AS monetary
    FROM clean_transactions
    GROUP BY customer_id
)
SELECT
    customer_id,
    recency,
    frequency,
    monetary,
        6 - LEAST(
        5,
        1 + FLOOR(5 * PERCENT_RANK() OVER (ORDER BY recency))
    ) AS recency_score,

    LEAST(
        5,
        1 + FLOOR(5 * PERCENT_RANK() OVER (ORDER BY frequency))
    ) AS frequency_score,

    LEAST(
        5,
        1 + FLOOR(5 * PERCENT_RANK() OVER (ORDER BY monetary))
    ) AS monetary_score
FROM rfm_metrics;

-- Validate RFM Scores
SELECT
    MIN(recency_score),
    MAX(recency_score),
    MIN(frequency_score),
    MAX(frequency_score),
    MIN(monetary_score),
    MAX(monetary_score)
FROM rfm_scores;

-- Create Customer Segments Based on RFM Scores

 CREATE OR REPLACE TABLE rfm_segments AS
SELECT
    customer_id,
    recency_score,
    frequency_score,
    monetary_score,
    CASE
        WHEN recency_score >= 4
         AND frequency_score >= 4
         AND monetary_score >= 4
        THEN 'Champions'
        WHEN recency_score >= 3
         AND frequency_score >= 4
        THEN 'Loyal Customers'
        WHEN monetary_score >= 4
         AND frequency_score <= 3
        THEN 'Big Spenders'
        WHEN recency_score >= 4
         AND frequency_score BETWEEN 2 AND 3
        THEN 'Potential Loyalists'
        WHEN recency_score <= 2
         AND frequency_score >= 3
        THEN 'At Risk'
        WHEN recency_score <= 2
         AND frequency_score <= 2
        THEN 'Lost Customers' 
        ELSE 'Regular Customers'
    END AS customer_segment
FROM rfm_scores;

-- Note: All revenue contribution calculations represent
-- gross customer spending from retained positive-quantity,
-- positive-price transactions. They are not net revenue
-- after returns and cancellations.
/*====================================================
Revenue Contribution Analysis - Top 20% Customers
====================================================*/
-- Business Question:
-- How much of the total spending is contributed
-- by the top 20% of customers?

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(quantity * price) AS total_spending
    FROM clean_transactions
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        total_spending,
        NTILE(5) OVER (
            ORDER BY total_spending DESC
        ) AS spending_group
    FROM customer_spending
),
group_revenue AS (
    SELECT
        spending_group,
        COUNT(*) AS customer_count,
        SUM(total_spending) AS group_revenue
    FROM ranked_customers
    GROUP BY spending_group
)
SELECT
    spending_group,
    customer_count,
    ROUND(group_revenue, 2) AS group_revenue,

    ROUND(
        group_revenue * 100.0 /
        SUM(group_revenue) OVER (),
        2
    ) AS revenue_contribution_percentage,
    ROUND(
        SUM(group_revenue) OVER (
            ORDER BY spending_group
        ) * 100.0 /
        SUM(group_revenue) OVER (),
        2
    ) AS cumulative_revenue_percentage
FROM group_revenue
ORDER BY spending_group;

/*====================================================
Revenue Contribution Analysis - Customer Deciles
====================================================*/
-- Business Question:
-- How much of total spending is contributed
-- by each 10% group of customers?

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(quantity * price) AS total_spending
    FROM clean_transactions
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        total_spending,
        NTILE(10) OVER (
            ORDER BY total_spending DESC
        ) AS spending_decile
    FROM customer_spending
),
decile_revenue AS (
    SELECT
        spending_decile,
        COUNT(*) AS customer_count,
        SUM(total_spending) AS group_revenue
    FROM ranked_customers
    GROUP BY spending_decile
)
SELECT
    spending_decile,
    customer_count,
    ROUND(group_revenue, 2) AS group_revenue,
    ROUND(
        group_revenue * 100.0 /
        SUM(group_revenue) OVER (),
        2
    ) AS revenue_contribution_percentage,
    ROUND(
        SUM(group_revenue) OVER (
            ORDER BY spending_decile
        ) * 100.0 /
        SUM(group_revenue) OVER (),
        2
    ) AS cumulative_revenue_percentage
FROM decile_revenue
ORDER BY spending_decile;

/*====================================================
Revenue Contribution Analysis - RFM Segments
====================================================*/
-- Business Question:
-- Which RFM customer segments contribute the most
-- to total customer spending?

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(quantity * price) AS total_spending
    FROM clean_transactions
    GROUP BY customer_id
),
segment_revenue AS (
    SELECT
        r.customer_segment,
        COUNT(*) AS customer_count,
        SUM(c.total_spending) AS group_revenue
    FROM customer_spending c
    JOIN rfm_segments r
        ON c.customer_id = r.customer_id
    GROUP BY r.customer_segment
)
SELECT
    customer_segment,
    customer_count,
    ROUND(
        customer_count * 100.0 /
        SUM(customer_count) OVER (),
        2
    ) AS customer_percentage,
    ROUND(group_revenue, 2) AS group_revenue,
    ROUND(
        group_revenue * 100.0 /
        SUM(group_revenue) OVER (),
        2
    ) AS revenue_contribution_percentage
FROM segment_revenue
ORDER BY group_revenue DESC;

-- Analyze Customer Segment Distribution
SELECT
    customer_segment,
    COUNT(*) AS customers
FROM rfm_segments
GROUP BY customer_segment
ORDER BY customers DESC;

