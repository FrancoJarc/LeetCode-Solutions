WITH low_session_rating AS (
    SELECT DISTINCT b.book_id, b.title, b.author, b.pages, b.genre
    FROM books b
    INNER JOIN reading_sessions rs
    ON b.book_id = rs.book_id
    WHERE session_rating <= 2
),

high_session_rating AS (
    SELECT DISTINCT b.book_id, b.title
    FROM books b
    INNER JOIN reading_sessions rs
    ON b.book_id = rs.book_id
    WHERE session_rating >= 4
),

polarization_score_query AS (
    SELECT SUM(CASE WHEN session_rating>=4 OR session_rating<=2 THEN 1 ELSE 0 END) as score,
           book_id
    FROM reading_sessions 
    GROUP BY book_id
)




SELECT lsr.book_id, lsr.title, lsr.author, lsr.genre, lsr.pages, (MAX(rs.session_rating) - MIN(rs.session_rating)) AS rating_spread, ROUND(psq.score / COUNT(*),2) as polarization_score 
FROM low_session_rating lsr
INNER JOIN high_session_rating hsr
    ON lsr.book_id = hsr.book_id
INNER JOIN reading_sessions rs
    ON hsr.book_id = rs.book_id
INNER JOIN polarization_score_query psq
    ON rs.book_id = psq.book_id
GROUP BY rs.book_id
HAVING COUNT(*)>=5 AND polarization_score >= 0.6
ORDER BY polarization_score DESC, lsr.title DESC



 