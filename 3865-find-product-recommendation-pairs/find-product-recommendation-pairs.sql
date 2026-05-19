# Write your MySQL query statement below
SELECT p.product_id AS product1_id,  
       pr.product_id AS product2_id, 
       (SELECT category FROM ProductInfo WHERE product_id = p.product_id) AS product1_category,  
       (SELECT category FROM ProductInfo WHERE product_id = pr.product_id) AS product2_category,
       COUNT(*) as customer_count
FROM ProductPurchases p
INNER JOIN ProductPurchases pr
ON p.user_id = pr.user_id
WHERE p.product_id  < pr.product_id
GROUP BY p.product_id, pr.product_id
HAVING COUNT(*) >= 3
ORDER BY customer_count DESC, product1_id ASC, product2_id ASC
