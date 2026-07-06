# Write your MySQL query statement below
WITH avg_rating AS(
    SELECT customer_id, 
           ROUND(AVG(order_rating),2) AS average_rating
    FROM restaurant_orders
    WHERE order_rating IS NOT NULL
    GROUP BY customer_id
), avg_order_rates AS(
        SELECT customer_id,
               ROUND(SUM(
                        CASE WHEN order_rating IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*)
                ,2) AS average_order_rated,
                CEILING((SUM(
                        CASE WHEN TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00' OR 
                                    TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00'
                        THEN 1 ELSE 0 END) / COUNT(*) * 100.0
                 )) AS peak_hour_percentage
        FROM restaurant_orders
        GROUP BY customer_id
)



SELECT ro.customer_id, 
       COUNT(*) as total_orders,
        aor.peak_hour_percentage,
        ar.average_rating
FROM restaurant_orders ro
INNER JOIN avg_rating ar
    ON ro.customer_id = ar.customer_id
INNER JOIN avg_order_rates aor
    ON ar.customer_id = aor.customer_id
    AND aor.average_order_rated >= 0.50
GROUP BY ro.customer_id 
HAVING COUNT(*) >= 3 
       AND aor.peak_hour_percentage>= 60
       AND ar.average_rating >= 4.0
ORDER BY ar.average_rating DESC, ro.customer_id DESC
