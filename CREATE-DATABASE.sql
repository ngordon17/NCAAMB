DROP TABLE GameStats;
DROP TABLE Player;
DROP TABLE Game;
DROP TABLE Team;
DROP TABLE Conference;
DROP TABLE Venue;

CREATE TABLE Venue (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	name VARCHAR(100),
	address VARCHAR(100),
	city VARCHAR(100),
	state CHAR(2),
	country VARCHAR(100),
	zipcode INTEGER,
	capacity INTEGER
);

CREATE TABLE Conference (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	name VARCHAR(100),
	alias VARCHAR(100)
);

CREATE TABLE Team (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	name VARCHAR(100),
	alias VARCHAR(100),
	venue_id VARCHAR(100) REFERENCES Venue(id),
	conference_id VARCHAR(100) REFERENCES Conference(id)
);

CREATE TABLE Game (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	home_team_id VARCHAR(100), --not referencing teams
	away_team_id VARCHAR(100), --not referencing teams
	--venue_id VARCHAR(100),
	scheduled_date VARCHAR(100),
	scheduled_time VARCHAR(100)
	--network VARCHAR(100),
	--internet VARCHAR(100)
);

CREATE TABLE Player (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	team_id VARCHAR(100) REFERENCES Team(id),
	height INTEGER,
	weight INTEGER,
	jersey_number INTEGER,
	year VARCHAR(100),
	position VARCHAR(100),
	birthplace VARCHAR(100)
);

CREATE TABLE GameStats (
	game_id VARCHAR(100) NOT NULL REFERENCES Game(id),
	player_id VARCHAR(100), --not referencing players
	minutes INTEGER DEFAULT 0,
	three_point_attempts INTEGER DEFAULT 0,
	three_point_makes INTEGER DEFAULT 0,
	two_point_attempts INTEGER DEFAULT 0,
	two_point_makes INTEGER DEFAULT 0,
	field_goal_attempts INTEGER DEFAULT 0,
	field_goal_makes INTEGER DEFAULT 0,
	free_throw_attempts INTEGER DEFAULT 0,
	free_throw_makes INTEGER DEFAULT 0,
	offensive_rebounds INTEGER DEFAULT 0,
	defensive_rebounds INTEGER DEFAULT 0,
	assists INTEGER DEFAULT 0,
	turnovers INTEGER DEFAULT 0,
	steals INTEGER DEFAULT 0,
	blocks INTEGER DEFAULT 0,
	personal_fouls INTEGER DEFAULT 0,
	technical_fouls INTEGER DEFAULT 0,
	flagrant_fouls INTEGER DEFAULT 0,
	points INTEGER DEFAULT 0,
	PRIMARY KEY (game_id, player_id)
);

