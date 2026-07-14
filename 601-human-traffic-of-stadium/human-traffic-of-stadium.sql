WITH fq AS(
    SELECT *,
        id - ROW_NUMBER() OVER (ORDER BY id ASC) as rows_consecutives
    FROM Stadium
    WHERE people >= 100
)

SELECT id, visit_date, people
FROM fq
WHERE rows_consecutives IN (SELECT rows_consecutives FROM fq GROUP BY rows_consecutives HAVING COUNT(*) >= 3)
ORDER BY visit_date ASC