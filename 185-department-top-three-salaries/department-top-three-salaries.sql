# Write your MySQL query statement below
WITH fq AS(
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) as dr
    FROM Employee
)

SELECT d.name as Department, fq.name as Employee, fq.salary as Salary
FROM fq 
INNER JOIN Department d
ON fq.departmentId = d.id
WHERE fq.dr IN (1,2,3)
