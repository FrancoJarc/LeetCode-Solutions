# Write your MySQL query statement below
WITH fq AS(
    SELECT product_id, 
    new_price,
    ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY change_date DESC) as rw
    FROM Products p
    WHERE change_date <= '2019-08-16'
)

SELECT p.product_id, 
       COALESCE(fq.new_price, 10) as price
FROM (SELECT DISTINCT product_id
      FROM Products
) p
LEFT JOIN fq
ON p.product_id = fq.product_id
AND fq.rw = 1

