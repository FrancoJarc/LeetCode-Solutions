# Write your MySQL query statement below
SELECT 
    t.request_at AS Day,
    ROUND(SUM(CASE WHEN t.status LIKE 'cancelled%' THEN 1 ELSE 0 END) / COUNT(*),2) AS "Cancellation Rate"
FROM Trips t
INNER JOIN Users u 
    ON t.client_id = u.users_id 
INNER JOIN Users us 
    ON t.driver_id = us.users_id  
WHERE u.banned = 'No'           
  AND us.banned = 'No'            
  AND t.request_at BETWEEN "2013-10-01" AND "2013-10-03"
GROUP BY t.request_at
ORDER BY Day;

