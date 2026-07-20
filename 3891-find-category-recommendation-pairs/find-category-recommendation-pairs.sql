# Write your MySQL query statement below
WITH fq AS(
    SELECT DISTINCT pp.user_id, pi.category
    FROM ProductPurchases pp
    INNER JOIN ProductInfo pi
    ON pp.product_id = pi.product_id
)

SELECT fq1.category as category1, fq2.category as category2, COUNT(*) as customer_count
FROM fq fq1
INNER JOIN fq fq2
ON fq1.user_id = fq2.user_id
AND fq1.category < fq2.category 
GROUP BY fq1.category, fq2.category 
HAVING count(*) >= 3
ORDER BY customer_count DESC, category1 ASC, category2 ASC