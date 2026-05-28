# Write your MySQL query statement below
WITH ranking AS (
    SELECT *,
    RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC ) as pos
    FROM Employee
)
SELECT d.name as Department, r.name AS Employee, r.salary as Salary
FROM ranking r
INNER JOIN Department d
ON r.departmentId  = d.id 
WHERE pos = 1