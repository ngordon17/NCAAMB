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

SELECT *
FROM Score
LIMIT 10;

-- list of conferences for main Conferences page
SELECT name
FROM Conference
ORDER BY name;

--list of teams for Teams page
SELECT id, name, alias
FROM Team
ORDER BY name
LIMIT 10;

--list of players for main Players page
SELECT id, first_name, last_name
FROM Player
ORDER BY last_name, first_name
LIMIT 10;

--general info for specific player
SELECT *
FROM Player
WHERE id = 'cad077aa-9235-4031-975d-b9301c27bf00';

--schedule for a given date
SELECT *
FROM Game
WHERE scheduled_datetime::date = '2013-11-08';

--schedule for a given team
SELECT *
FROM Game
WHERE home_team_id = 'faeb1160-5d15-4f26-99fc-c441cf21fc7f' OR away_team_id = 'faeb1160-5d15-4f26-99fc-c441cf21fc7f';

--box score for a given game
SELECT *
FROM GameStats
WHERE game_id = 'fbd4d02d-a1cc-4274-b186-4e6b08942080'
LIMIT 10;

--score for a specific game
SELECT *
FROM Score
WHERE game_id = 'fbd4d02d-a1cc-4274-b186-4e6b08942080';

--scores for a given date
SELECT id, home_team_id, away_team_id, home_score, away_score
FROM Score, Game
WHERE scheduled_datetime::date = '2013-11-08' AND id = game_id;

-- specific team info
SELECT *
FROM Team
WHERE id = 'faeb1160-5d15-4f26-99fc-c441cf21fc7f';

--list of players for a team, will also be used for specific team info
SELECT *
FROM Player
WHERE team_id = 'faeb1160-5d15-4f26-99fc-c441cf21fc7f'
ORDER BY last_name
LIMIT 10;

--specific player's average statistics
SELECT AVG(offensive_rebounds) AS ORPG, AVG(defensive_rebounds) AS DRPG, AVG(steals) AS SPG, 
	AVG(assists) AS APG, AVG(personal_fouls) AS FPG, AVG(minutes) as MPG,
    SUM(cast(three_point_makes as float))/SUM(three_point_attempts) AS three_percent,
    SUM(cast(two_point_makes as float))/SUM(two_point_attempts) AS two_percent,
    SUM(cast(free_throw_makes as float))/SUM(free_throw_attempts) AS free_percent,
    (SUM(cast(two_point_makes as float)) * 2 + SUM(three_point_makes) * 3)/COUNT(*) AS avg_points
FROM GameStats
WHERE player_id = 'c90c543f-1c4c-4d76-afd3-feda9ea83c3c' AND minutes <> 0;

/*
SELECT Team.id, Team.alias, wins.wins
FROM Team, (SELECT Team.id AS tid, COUNT(*) AS wins
            FROM Team, Game, Score
            WHERE (Team.id = Game.home_team_id AND Game.id = Score.game_id AND Score.home_score > Score.away_score)
                   OR (Team.id = Game.away_team_id AND Game.id = Score.game_id and Score.home_score < Score.away_score)
            GROUP BY tid) AS wins
WHERE Team.conference_id = '302c99fe-6b0a-40ec-8ee7-f15a0355b7b5' AND Team.id = wins.tid;
*/

-- list of teams in a specific conference ordered by record
SELECT  Team.id, Team.alias, wins.wins, losses.losses
FROM Team, (SELECT Team.id AS tid, COUNT(*) AS wins
			FROM Team, Game, Score
			WHERE (Team.id = Game.home_team_id AND Game.id = Score.game_id AND Score.home_score > Score.away_score)
				  OR (Team.id = Game.away_team_id AND Game.id = Score.game_id AND Score.home_score < Score.away_score)
			GROUP BY tid) AS wins,
			(SELECT Team.id AS tid, COUNT(*) AS losses
			FROM Team, Game, Score
			WHERE (Team.id = Game.home_team_id AND Game.id = Score.game_id AND Score.home_score < Score.away_score)
				  OR (Team.id = Game.away_team_id AND Game.id = Score.game_id AND Score.home_score > Score.away_score)
			GROUP BY tid) AS losses
WHERE Team.conference_id = '04d5255d-b2dc-43df-9fa8-d296b0f8ccd7' AND Team.id = wins.tid AND Team.id = losses.tid
ORDER BY wins.wins DESC, losses.losses ASC;	
