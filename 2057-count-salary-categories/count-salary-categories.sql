WITH category AS (
    SELECT SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END) AS Low_Salary,
    SUM(CASE WHEN income >= 20000 AND income <= 50000 THEN 1 ELSE 0 END) AS Average_Salary,
    SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END) AS High_Salary
    FROM Accounts
)

SELECT 'Low Salary' AS category , Low_Salary AS accounts_count
FROM category

UNION

SELECT 'Average Salary' AS category , Average_Salary AS accounts_count
FROM category

UNION

SELECT 'High Salary' AS category , High_Salary AS accounts_count
FROM category
ORDER BY accounts_count DESC