# Write your MySQL query statement below
WITH fq AS(
    SELECT 
       user_id,
       event_date,
       MAX(monthly_amount) AS max_historical_amount,
       (monthly_amount/MAX(monthly_amount)) * 100.0 as current_revenue, /**/
       DATEDIFF(MAX(event_date), MIN(event_date)) AS days_as_subscriber
    FROM subscription_events
    WHERE user_id IN (SELECT user_id FROM subscription_events WHERE event_type = "downgrade")
    GROUP BY user_id
), sq AS(
    SELECT user_id,     
        plan_name AS current_plan,
        monthly_amount AS current_monthly_amount,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY event_date DESC) AS rw
    FROM subscription_events
)

SELECT f.user_id, s.current_plan, s.current_monthly_amount, f.max_historical_amount, f.days_as_subscriber
FROM fq f
INNER JOIN sq s
ON f.user_id = s.user_id 
WHERE s.rw=1 
    AND s.current_plan != "cancel"
    AND days_as_subscriber >= 60
    AND (s.current_monthly_amount/f.max_historical_amount) * 100.0 <= 50
ORDER BY days_as_subscriber desc, user_id asc