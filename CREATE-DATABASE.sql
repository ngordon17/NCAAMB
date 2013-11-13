DROP TABLE GameStats;
DROP TABLE Score;
DROP TABLE Player;
DROP TABLE Game;
DROP TABLE Team;
DROP TABLE Conference;
DROP TABLE Venue;

CREATE TABLE Venue (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	name VARCHAR(100) DEFAULT 'UNKNOWN',
	address VARCHAR(100) DEFAULT 'UNKNOWN',
	city VARCHAR(100) DEFAULT 'UNKNOWN',
	state CHAR(2) DEFAULT 'UNKNOWN',
	country VARCHAR(100) DEFAULT 'UNKNOWN',
	zipcode INTEGER DEFAULT 0,
	capacity INTEGER DEFAULT 0
);

CREATE TABLE Conference (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	name VARCHAR(100) DEFAULT 'UNKNOWN',
	alias VARCHAR(100) DEFAULT 'UNKNOWN'
);

CREATE TABLE Team (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	name VARCHAR(100) DEFAULT 'UNKNOWN',
	alias VARCHAR(100) DEFAULT 'UNKNOWN',
	venue_id VARCHAR(100) REFERENCES Venue(id),
	conference_id VARCHAR(100) REFERENCES Conference(id)
);

CREATE TABLE Game (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	home_team_id VARCHAR(100) DEFAULT 'UNKNOWN', -- reference
	away_team_id VARCHAR(100) DEFAULT 'UNKNOWN', -- reference
	--venue_id VARCHAR(100),
	scheduled_date VARCHAR(100),
	scheduled_time VARCHAR(100)
	--network VARCHAR(100),
	--internet VARCHAR(100)
);

CREATE TABLE Player (
	id VARCHAR(100) NOT NULL PRIMARY KEY,
	first_name VARCHAR(100) DEFAULT 'UNKNOWN',
	last_name VARCHAR(100) DEFAULT 'UNKNOWN',
	team_id VARCHAR(100) REFERENCES Team(id),
	height INTEGER DEFAULT 0,
	weight INTEGER DEFAULT 0,
	jersey_number INTEGER DEFAULT 0,
	year VARCHAR(100) DEFAULT 'UNKNOWN',
	position VARCHAR(100) DEFAULT 'UNKNOWN',
	birthplace VARCHAR(100) DEFAULT 'UNKNOWN'
);

CREATE TABLE GameStats (
	game_id VARCHAR(100) NOT NULL REFERENCES Game(id),
	player_id VARCHAR(100), --not referencing player id
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

CREATE TABLE Score (
	game_id VARCHAR(100) NOT NULL REFERENCES Game(id),
	home_score INTEGER DEFAULT 0,
	away_score INTEGER DEFAULT 0,
	PRIMARY KEY(game_id)
);
