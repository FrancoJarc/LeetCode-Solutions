# Write your MySQL query statement below

WITH most_exp_product AS (
    SELECT s.store_id, s.store_name, s.location, i.inventory_id, i.product_name, i.quantity, i.price
    FROM stores s
    INNER JOIN inventory i
    ON s.store_id = i.store_id 
    WHERE i.price = (SELECT max(price) FROM inventory WHERE store_id = i.store_id)
),
most_chp_product AS (
    SELECT s.store_id, s.store_name, s.location,  i.inventory_id, i.product_name, i.quantity, i.price
    FROM stores s
    INNER JOIN inventory i
    ON s.store_id = i.store_id 
    WHERE i.price = (SELECT min(price) FROM inventory WHERE store_id = i.store_id)
)

SELECT 
    mep.store_id AS store_id,
    mep.store_name AS store_name,
    mep.location AS location,
    mep.product_name AS most_exp_product,
    mcp.product_name AS cheapest_product,
    ROUND((mcp.quantity / mep.quantity),2) AS imbalance_ratio  
FROM most_exp_product mep
INNER JOIN most_chp_product mcp
    ON mep.store_id = mcp.store_id
WHERE mep.quantity < mcp.quantity
    AND mep.store_id IN (
    SELECT store_id
    FROM inventory
    GROUP BY store_id
    HAVING COUNT(*) >= 3
)
ORDER BY imbalance_ratio desc, mep.store_name ASC