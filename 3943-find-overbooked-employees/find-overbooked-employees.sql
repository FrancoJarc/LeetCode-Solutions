# Write your MySQL query statement below
WITH fq AS (
    SELECT
        employee_id,
        YEARWEEK(meeting_date, 1) AS week_id,
        SUM(duration_hours) AS total_meeting_hours
    FROM meetings
    GROUP BY employee_id, YEARWEEK(meeting_date, 1)
    HAVING SUM(duration_hours) > 20
)

SELECT fq.employee_id, e.employee_name, e.department, count(*) as meeting_heavy_weeks 
FROM fq
INNER JOIN employees e
ON e.employee_id = fq.employee_id
GROUP BY employee_id
HAVING COUNT(*)>=2
ORDER BY meeting_heavy_weeks DESC, e.employee_name ASC





