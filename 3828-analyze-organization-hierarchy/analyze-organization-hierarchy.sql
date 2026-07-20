WITH RECURSIVE jerarquia AS (
    SELECT 
        employee_id, 
        employee_name, 
        salary,
        1 AS level
    FROM Employees
    WHERE manager_id IS NULL 
    
    UNION ALL
    
    SELECT 
        e.employee_id, 
        e.employee_name, 
        e.salary,
        j.level + 1 AS level
    FROM Employees e
    INNER JOIN jerarquia j 
        ON e.manager_id = j.employee_id 
),
cantidad_equipo AS(
    SELECT 
        employee_id AS sub_id, 
        salary AS sub_salary,
        manager_id
    FROM Employees
    WHERE manager_id IS NOT NULL    

    UNION ALL

    SELECT 
        c.sub_id,
        c.sub_salary,
        e.manager_id
    FROM cantidad_equipo c
    INNER JOIN Employees e
        ON c.manager_id = e.employee_id
    WHERE e.manager_id IS NOT NULL
)

SELECT j.employee_id, j.employee_name, j.level, COUNT(c.sub_id) AS team_size, COALESCE(SUM(c.sub_salary), 0) + j.salary AS budget
FROM jerarquia j
LEFT JOIN cantidad_equipo c
    ON j.employee_id = c.manager_id
GROUP BY j.employee_id, j.employee_name, j.level, j.salary
ORDER BY j.level ASC, budget DESC, j.employee_name ASC