# Write your MySQL query statement below
WITH fq AS(
    SELECT user_id,
           reaction,
           count(*) AS reaction_count
    FROM reactions
    GROUP BY user_id
    HAVING count(*) >= 5
)
SELECT r.user_id, r.reaction AS dominant_reaction, ROUND((COUNT(*) / f.reaction_count),2) AS reaction_ratio 
FROM reactions r
INNER JOIN fq f
    ON r.user_id = f.user_id
GROUP BY user_id, dominant_reaction, f.reaction_count
HAVING (COUNT(*) / f.reaction_count) >= 0.6
ORDER BY reaction_ratio DESC, user_id ASC

/*PROBLEMA EN EL COUNT DEL WHERE Y DEL SELECT*/