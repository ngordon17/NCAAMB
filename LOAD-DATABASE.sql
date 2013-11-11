DELETE FROM GameStats;
DELETE FROM Player;
DELETE FROM Game;
DELETE FROM Team;
DELETE FROM Conference;
DELETE FROM Venue;

\COPY Venue(id, name, address, city, state, country, zipcode, capacity) FROM 'Venue.dat' WITH DELIMITER '|' NULL '' CSV
\COPY Conference(id, name, alias) FROM 'Conference.dat' WITH DELIMITER '|' NULL '' CSV
\COPY Team(id, name, alias, venue_id, conference_id) FROM 'Team.dat' WITH DELIMITER '|' NULL '' CSV
\COPY Game(id, home_team_id, away_team_id, scheduled) FROM 'Game.dat' WITH DELIMITER '|' NULL '' CSV
\COPY Player(id, first_name, last_name, team_id, height, weight, jersey_number, year, position, birthplace) FROM 'Player.dat' WITH DELIMITER '|' NULL '' CSV
\COPY GameStats(game_id, player_id, minutes, three_point_attempts, three_point_makes, two_point_attempts, two_point_makes, field_goal_attempts, field_goal_makes, free_throw_attempts, free_throw_makes, offensive_rebounds, defensive_rebounds, assists, turnovers, steals, blocks, personal_fouls, technical_fouls, flagrant_fouls, points) FROM 'GameStats.dat' WITH DELIMITER '|' NULL '' CSV