SELECT 
    ip, 
    COUNT(*) AS invalid_count
FROM logs
WHERE (LENGTH(ip) - LENGTH(REPLACE(ip, '.', ''))) <> 3
    OR ip REGEXP '\\b0[0-9]'
    OR ip REGEXP '25[6-9]|2[6-9][0-9]|[3-9][0-9][0-9]|[0-9]{4,}'
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;