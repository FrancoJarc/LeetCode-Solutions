# Write your MySQL query statement below
WITH not_red AS(
    SELECT s.name, o.com_id as "id_comp" 
    FROM SalesPerson s
    LEFT JOIN Orders o
    ON s.sales_id=o.sales_id
    GROUP BY s.sales_id
)
select name
FROM not_red
WHERE id_comp IS NULL OR id_comp IN (SELECT c.com_id FROM Company c WHERE c.name != 'RED')




/*
SELECT s.name 
FROM SalesPerson s
LEFT JOIN Orders o
ON s.sales_id=o.sales_id
LEFT JOIN Company c
ON o.com_id = c.com_id 
WHERE o.com_id != 1 OR o.com_id IS NULL
GROUP BY o.sales_id
HAVING o.com_id != 1*/