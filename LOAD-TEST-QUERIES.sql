SELECT *
FROM Venue
LIMIT 10;

SELECT *
FROM Conference
LIMIT 10;

SELECT *
FROM Team
LIMIT 10;

SELECT *
FROM Game
LIMIT 10;

SELECT *
FROM Player
LIMIT 10;

SELECT *
FROM GameStats
LIMIT 10;

-- list of conferences for main Conferences page
SELECT name
FROM Conference
ORDER BY name;

SELECT AVG(offensive_rebounds) AS ORPG, AVG(defensive_rebounds) AS DRPG, AVG(steals) AS SPG, 
	AVG(assists) AS APG, AVG(personal_fouls) AS FPG,
    SUM(cast(three_point_makes as float))/SUM(three_point_attempts) AS three_percent,
    SUM(cast(two_point_makes as float))/SUM(two_point_attempts) AS two_percent,
    SUM(cast(free_throw_makes as float))/SUM(free_throw_attempts) AS free_percent,
    (SUM(cast(two_point_makes as float)) * 2 + SUM(three_point_makes) * 3)/COUNT(*) AS avg_points
FROM GameStats
WHERE player_id = 'c90c543f-1c4c-4d76-afd3-feda9ea83c3c' AND minutes <> '00:00';
