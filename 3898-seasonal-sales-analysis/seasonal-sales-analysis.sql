WITH seasons AS (
    SELECT CASE
        WHEN MONTH(s.sale_date) IN (12,1,2) THEN "Winter"
        WHEN MONTH(s.sale_date) IN (3,4,5) THEN "Spring"
        WHEN MONTH(s.sale_date) IN (6,7,8) THEN "Summer"
        WHEN MONTH(s.sale_date) IN (9,10,11) THEN "Fall"
        END AS 'season',
        p.category as category,
        SUM(s.quantity) as total_quantity,
        SUM(s.quantity * s.price) as total_revenue
    FROM sales s
    INNER JOIN products p
    ON s.product_id = p.product_id
    GROUP BY season, category
    ORDER BY total_quantity DESC, total_revenue DESC, category ASC
)

SELECT season, category, total_quantity AS total_quantity , total_revenue AS total_revenue
FROM seasons
GROUP BY season
ORDER BY season ASC





/*
SELECT season, category, MAX(total_quantity) AS total_quantity , MAX(total_revenue) AS total_revenue
FROM seasons
GROUP BY season
ORDER BY season ASC
*/



