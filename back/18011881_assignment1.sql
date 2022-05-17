

USE nba_db ;

-- -----------------------------------------------------
-- Table `nba_db`.`stadium`
-- -----------------------------------------------------
CREATE TABLE stadium (
  s_name VARCHAR(20) NOT NULL,
  capacity INT NULL,
  locations VARCHAR(20) NULL,
  PRIMARY KEY (s_name))


-- -----------------------------------------------------
-- Table `nba_db`.`coach`
-- -----------------------------------------------------
CREATE TABLE coach (
  team_id VARCHAR(5) NOT NULL,
  head_coach VARCHAR(45) NOT NULL,
  team_owner VARCHAR(45) NULL,
  PRIMARY KEY (team_id))



-- -----------------------------------------------------
-- Table `nba_db`.`season_type`
-- -----------------------------------------------------
CREATE TABLE season_type (
  game_date DATE NOT NULL,
  season_type VARCHAR(15) NULL,
  PRIMARY KEY (game_date))



-- -----------------------------------------------------
-- Table `nba_db`.`team_all_game`
-- -----------------------------------------------------
CREATE TABLE team_all_game (
  team_id VARCHAR(5) NOT NULL,
  game_date DATE NULL,
  vsteam_id VARCHAR(5) NULL,
  outcome VARCHAR(5) NULL,
  points INT NULL,
  rebounds INT NULL,
  assists INT NULL,
  blocks INT NULL,
  steals INT NULL,
  turnovers INT NULL,
  PRIMARY KEY (team_id),
  
    FOREIGN KEY (game_date)
    REFERENCES season_type(game_date)
    ON DELETE cascade
    ON UPDATE cascade)


-- -----------------------------------------------------
-- Table `nba_db`.`team_playoff`
-- -----------------------------------------------------
CREATE TABLE team_playoff (
  team_id VARCHAR(5) NOT NULL,
  s_17_18 VARCHAR(15) NULL,
  s_18_19 VARCHAR(15) NULL,
  s_19_20 VARCHAR(15) NULL,
  s_20_21 VARCHAR(15) NULL,
  PRIMARY KEY (team_id))



-- -----------------------------------------------------
-- Table `nba_db`.`team_regular`
-- -----------------------------------------------------
CREATE TABLE team_regular (
  team_id VARCHAR(5) NOT NULL,
  s_17_18 VARCHAR(15) NULL,
  s_18_19 VARCHAR(15) NULL,
  s_19_20 VARCHAR(15) NULL,
  s_20_21 VARCHAR(15) NULL,
  PRIMARY KEY (team_id))



-- -----------------------------------------------------
-- Table `nba_db`.`team_info`
-- -----------------------------------------------------
CREATE TABLE team_info (
  team_id VARCHAR(5) NOT NULL,
  f_name VARCHAR(20) NOT NULL,
  l_name VARCHAR(20) NOT NULL,
  stadium VARCHAR(20) NOT NULL,
  PRIMARY KEY (team_id),

    FOREIGN KEY (stadium)
    REFERENCES stadium (s_name)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT team_coach
    FOREIGN KEY (team_id)
    REFERENCES coach (team_id)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT team_game
    FOREIGN KEY (team_id)
    REFERENCES team_all_game (team_id)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT team_playoff
    FOREIGN KEY (team_id)
    REFERENCES team_playoff (team_id)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT team_regular
    FOREIGN KEY (team_id)
    REFERENCES team_regular (team_id)
    ON DELETE cascade
    ON UPDATE cascade)



-- -----------------------------------------------------
-- Table `nba_db`.`player_all_game`
-- -----------------------------------------------------
CREATE TABLE player_all_game (
  player_id VARCHAR(20) NOT NULL,
  game_date DATE NULL,
  minutes TIME NULL,
  points INT NULL,
  rebounds INT NULL,
  assists INT NULL,
  blocks INT NULL,
  steals INT NULL,
  turnovers INT NULL,
  PRIMARY KEY (player_id),
  CONSTRAINT seasontype
    FOREIGN KEY (game_date)
    REFERENCES season_type (game_date)
    ON DELETE cascade
    ON UPDATE cascade)



-- -----------------------------------------------------
-- Table `nba_db`.`player_awards`
-- -----------------------------------------------------
CREATE TABLE player_awards(
  player_id VARCHAR(20) NOT NULL,
  award_type VARCHAR(10) NULL,
  season_year INT NULL,
  PRIMARY KEY (player_id))


-- -----------------------------------------------------
-- Table `nba_db`.`player_info`
-- -----------------------------------------------------
CREATE TABLE player_info (
  player_id VARCHAR(20) NOT NULL,
  f_name VARCHAR(20) NULL,
  l_name VARCHAR(20) NULL,
  team_id VARCHAR(5) NULL,
  position VARCHAR(5) NULL,
  PRIMARY KEY (player_id),

  CONSTRAINT player_stats
    FOREIGN KEY (player_id)
    REFERENCES player_all_game (player_id)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT player_team
    FOREIGN KEY (team_id)
    REFERENCES team_info (team_id)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT player_awards
    FOREIGN KEY (player_id)
    REFERENCES player_awards (player_id)
    ON DELETE cascade
    ON UPDATE cascade)



