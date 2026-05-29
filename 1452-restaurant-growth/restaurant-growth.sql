# Write your MySQL query statement below
WITH ventas_diarias AS (
    SELECT visited_on,
    SUM(amount) as amount
    FROM Customer
    GROUP BY visited_on
)
SELECT visited_on,    

        SUM(amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,

        ROUND(AVG(amount) OVER (
              ORDER BY visited_on
              ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
            ),2) AS average_amount

FROM ventas_diarias
LIMIT 999999 OFFSET 6;





