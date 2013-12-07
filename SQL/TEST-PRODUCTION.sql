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
SELECT id, name
FROM Conference
ORDER BY name;

--list of teams for Teams page
SELECT id, name, alias
FROM Team
ORDER BY alias
LIMIT 10;

--list of players for main Players page
SELECT id, first_name, last_name
FROM Player
ORDER BY last_name, first_name
LIMIT 10;

--general info for specific player
SELECT Player.*, Team.alias, Team.name
FROM Player, Team
WHERE Player.id = 'cad077aa-9235-4031-975d-b9301c27bf00' AND Player.team_id = Team.id;

--schedule for a given date
SELECT g.gid, g.home_team_id, g.home_team_alias, g.home_team_name, g.away_team_id, g.away_team_alias, g.away_team_name, 
       COALESCE(s.home_score, 0), COALESCE(s.away_score, 0), g.scheduled_datetime
FROM (SELECT Game.id AS gid, home_team_id, t1.alias AS home_team_alias, t1.name AS home_team_name, away_team_id, 
       t2.alias AS away_team_alias, t2.name AS away_team_name, scheduled_datetime
FROM Game, Team t1, Team t2  
WHERE scheduled_datetime::date = '2013-11-08' AND t1.id = home_team_id AND t2.id = away_team_id) AS g
LEFT OUTER JOIN
(SELECT game_id AS gid, home_score, away_score
FROM Score) AS s
ON g.gid = s.gid
ORDER BY scheduled_datetime;

--schedule for a given team
SELECT g.gid, g.home_team_id, g.home_team_alias, g.home_team_name, g.away_team_id, g.away_team_alias, g.away_team_name, 
       COALESCE(s.home_score, 0), COALESCE(s.away_score, 0), g.scheduled_datetime
FROM (SELECT Game.id AS gid, home_team_id, t1.alias AS home_team_alias, t1.name AS home_team_name, away_team_id, 
       t2.alias AS away_team_alias, t2.name AS away_team_name, scheduled_datetime
FROM Game, Team t1, Team t2
WHERE (home_team_id = 'faeb1160-5d15-4f26-99fc-c441cf21fc7f' OR away_team_id = 'faeb1160-5d15-4f26-99fc-c441cf21fc7f') 
       AND t1.id = home_team_id AND t2.id = away_team_id) AS g
LEFT OUTER JOIN
(SELECT game_id AS gid, home_score, away_score
FROM Score) AS s
ON g.gid = s.gid
ORDER BY scheduled_datetime;

--box score for a given game
SELECT GameStats.*, Player.first_name, Player.last_name
FROM GameStats, Player
WHERE game_id = 'fbd4d02d-a1cc-4274-b186-4e6b08942080' AND GameStats.player_id = player.id
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
SELECT Team.*, Venue.name
FROM Team, Venue
WHERE Team.id = 'faeb1160-5d15-4f26-99fc-c441cf21fc7f' AND Team.venue_id = Venue.id;

--list of players for a team, will also be used for specific team info
SELECT *
FROM Player
WHERE team_id = 'faeb1160-5d15-4f26-99fc-c441cf21fc7f'
ORDER BY last_name
LIMIT 10;

--specific player's average statistics
SELECT COALESCE(AVG(offensive_rebounds), 0) AS ORPG, COALESCE(AVG(defensive_rebounds), 0) AS DRPG, COALESCE(AVG(steals), 0) AS SPG, 
	COALESCE(AVG(assists), 0) AS APG, COALESCE(AVG(personal_fouls), 0) AS FPG, COALESCE(AVG(minutes), 0) as MPG,
    COALESCE(SUM(cast(three_point_makes as float))/NULLIF(SUM(three_point_attempts), 0), 0) AS three_percent,
    COALESCE(SUM(cast(two_point_makes as float))/NULLIF(SUM(two_point_attempts), 0), 0) AS two_percent,
    COALESCE(SUM(cast(free_throw_makes as float))/NULLIF(SUM(free_throw_attempts), 0), 0) AS free_percent,
    COALESCE((SUM(cast(two_point_makes as float)) * 2 + SUM(three_point_makes) * 3)/NULLIF(COUNT(*), 0), 0) AS avg_points
FROM GameStats
WHERE player_id = 'df89300b-42af-43eb-8873-7bda04941c56' AND minutes <> 0;

-- list of teams in a specific conference ordered by record
SELECT COALESCE(windb.id, lossdb.id), COALESCE(windb.alias, lossdb.alias), COALESCE(windb.name, lossdb.name), COALESCE(windb.win, 0) AS win, COALESCE(lossdb.loss, 0) AS loss
FROM (SELECT Team.id AS id, Team.alias AS alias, Team.name AS name, w.wins AS win
FROM Team,  (SELECT Team.id AS tid, COUNT(*) AS wins
             FROM Team, Game, Score
             WHERE (Team.id = Game.home_team_id AND Game.id = Score.game_id AND home_score > away_score)
             OR (Team.id = Game.away_team_id AND Game.id = Score.game_id AND away_score > home_score)
             GROUP BY tid) AS w
WHERE Team.conference_id = '88368ebb-01fb-44d5-a6c6-3e7d46bb3ab7' AND Team.id = w.tid) AS windb
FULL OUTER JOIN
(SELECT Team.id AS id, Team.alias AS alias, Team.name AS name, l.losses AS loss
FROM Team,  (SELECT Team.id AS tid, COUNT(*) AS losses
             FROM Team, Game, Score
             WHERE (Team.id = Game.home_team_id AND Game.id = Score.game_id AND home_score < away_score)
             OR (Team.id = Game.away_team_id AND Game.id = Score.game_id AND away_score < home_score)
             GROUP BY tid) AS l
WHERE Team.conference_id = '88368ebb-01fb-44d5-a6c6-3e7d46bb3ab7' AND Team.id = l.tid) AS lossdb
ON windb.id = lossdb.id
ORDER BY win DESC, loss ASC;
