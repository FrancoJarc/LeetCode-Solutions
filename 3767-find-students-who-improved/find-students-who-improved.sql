# Write your MySQL query statement below
SELECT s.student_id, s.subject, s.score AS first_score, sc.score AS latest_score
FROM Scores s
INNER JOIN Scores sc
ON s.student_id = sc.student_id
AND s.subject = sc.subject
WHERE s.exam_date = (SELECT MIN(exam_date) FROM Scores WHERE student_id = s.student_id AND subject = s.subject)
AND 
sc.exam_date = (SELECT MAX(exam_date) FROM Scores WHERE student_id = sc.student_id AND subject = sc.subject)
AND s.score<sc.score
ORDER BY s.student_id asc, s.subject asc