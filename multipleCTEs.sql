WITH team_list AS (
    SELECT Team1 AS Team FROM Matches
    UNION
    SELECT Team2 AS Team FROM Matches
),
match_expanded AS (
    SELECT Team1 AS Team, Winner FROM Matches
    UNION ALL
    SELECT Team2 AS Team, Winner FROM Matches
),
results AS (
    SELECT 
        Team,
        COUNT(*) AS Played,
        SUM(CASE WHEN Team = Winner THEN 1 ELSE 0 END) AS Won,
        SUM(CASE WHEN Team <> Winner THEN 1 ELSE 0 END) AS Lost
    FROM match_expanded
    GROUP BY Team
)
SELECT * FROM results
ORDER BY Team;