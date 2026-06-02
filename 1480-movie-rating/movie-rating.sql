WITH highest_average AS(
    SELECT mv.movie_id,
           m.title,
           avg(mv.rating) AS hg
    FROM MovieRating mv
    INNER JOIN Movies m
        ON mv.movie_id = m.movie_id
    WHERE created_at >= '2020-02-01' AND created_at < '2020-03-01'
    GROUP BY mv.movie_id
    ORDER BY hg desc, m.title asc
)

(SELECT u.name as results
FROM Users u
INNER JOIN MovieRating mv
ON u.user_id = mv.user_id
GROUP BY mv.user_id
ORDER BY count(*) desc, u.name ASC
LIMIT 1)

UNION ALL

(SELECT title
FROM highest_average
LIMIT 1)
