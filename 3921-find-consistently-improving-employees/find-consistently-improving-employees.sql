# Write your MySQL query statement below
WITH fq AS (
    SELECT pr.employee_id, 
           e.name, 
           pr.rating as rating_1,
           LEAD(pr.rating, 1) OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rating_2,
           LEAD(pr.rating, 2) OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rating_3,
           pr.rating - LEAD(rating, 2) OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS improvement_score, 
           ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rn

    FROM employees e
    INNER JOIN performance_reviews pr
    ON e.employee_id = pr.employee_id
)

SELECT employee_id, name, improvement_score
FROM fq
WHERE rn = 1 
    AND rating_1 > rating_2 
    AND rating_2 > rating_3
ORDER BY improvement_score DESC, name ASC


