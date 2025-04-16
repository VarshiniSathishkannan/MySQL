CREATE TABLE Matches (
    Team1 VARCHAR(50),
    Team2 VARCHAR(50),
    Winner VARCHAR(50)
);

INSERT INTO Matches (Team1, Team2, Winner) VALUES
('India', 'England', 'India'),
('Australia', 'Pakistan', 'Australia'),
('NewZealand', 'South Africa', 'NewZealand'),
('Australia', 'India', 'India');


with teams as (
select Team1 as t from Matches union select Team2 as t from Matches
) select a.t, count(case when b.Team1 = a.t or b.Team2 = a.t then 1 end) as Played, count(case when b.Winner = a.t then 1 end) as Won, count(case when b.Team1 = a.t or b.Team2 = a.t and b.Winner <> a.t then 1 end) as Lost from teams a join Matches b on b.Team1 = a.t and b.Team2 = a.t;

-- mysql> with teams as (
--     -> select Team1 as t from Matches union select Team2 as t from Matches
--     -> ) select a.t, count(case when b.Team1 = a.t or b.Team2 = a.t then 1 end) as Played, count(case when b.Winner = a.t then 1 end) as Won, count(case when b.Team1 = a.t or b.Team2 = a.t and b.Winner <> a.t then 1 end) as Lost from teams a join Matches b on b.Team1 = a.t and b.Team2 = a.t;
-- ERROR 1140 (42000): In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'a.t'; this is incompatible with sql_mode=only_full_group_by

WITH teams AS (
    SELECT Team1 AS t FROM Matches
    UNION
    SELECT Team2 AS t FROM Matches
)
SELECT 
    a.t AS Team,
    COUNT(*) AS Played,
    SUM(CASE WHEN b.Winner = a.t THEN 1 ELSE 0 END) AS Won,
    SUM(CASE WHEN (b.Team1 = a.t OR b.Team2 = a.t) AND b.Winner <> a.t THEN 1 ELSE 0 END) AS Lost
FROM teams a
JOIN Matches b
    ON b.Team1 = a.t OR b.Team2 = a.t
GROUP BY a.t
ORDER BY a.t;


ChatGPT Ans:

SELECT 
    Team,
    COUNT(*) AS Played,
    SUM(CASE WHEN Team = Winner THEN 1 ELSE 0 END) AS Won,
    SUM(CASE WHEN Team <> Winner THEN 1 ELSE 0 END) AS Lost
FROM (
    SELECT Team1 AS Team, Winner FROM Matches
    UNION ALL
    SELECT Team2 AS Team, Winner FROM Matches
) AS MatchResults
GROUP BY Team
ORDER BY Team;