# Write your MySQL query statement below
WITH fq AS(
    SELECT driver_id, 
        AVG(CASE WHEN MONTH(trip_date) BETWEEN 1 AND 6
            THEN distance_km / fuel_consumed END) AS first_half_avg,
        AVG(CASE WHEN MONTH(trip_date) BETWEEN 7 AND 12
            THEN distance_km / fuel_consumed END) AS second_half_avg
    FROM trips
    GROUP BY driver_id
)

SELECT f.driver_id, 
       d.driver_name,
       ROUND(f.first_half_avg,2) as first_half_avg,
       ROUND(f.second_half_avg,2) as second_half_avg,
       ROUND(f.second_half_avg - f.first_half_avg,2) AS efficiency_improvement
FROM drivers d
INNER JOIN fq f
    ON d.driver_id = f.driver_id
    AND second_half_avg > first_half_avg
ORDER BY efficiency_improvement DESC , driver_name ASC


