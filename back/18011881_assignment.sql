-- MySQL Workbench Forward Engineering


USE `nba_db` ;

-- -----------------------------------------------------
-- Table `nba_db`.`stadium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`stadium` (
  `s_name` VARCHAR(20) NOT NULL,
  `capacity` INT NULL,
  `location` VARCHAR(20) NULL,
  PRIMARY KEY (`s_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`coach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`coach` (
  `team_id` VARCHAR(5) NOT NULL,
  `head_coach` VARCHAR(45) NOT NULL,
  `owner` VARCHAR(45) NULL,
  PRIMARY KEY (`team_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`season_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`season_type` (
  `game_date` DATE NOT NULL,
  `season_type` VARCHAR(15) NULL,
  PRIMARY KEY (`game_date`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`team_all_game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`team_all_game` (
  `team_id` VARCHAR(5) NOT NULL,
  `game_date` DATE NULL,
  `vsteam_id` VARCHAR(5) NULL,
  `outcome` VARCHAR(5) NULL,
  `points` INT NULL,
  `rebounds` INT NULL,
  `assists` INT NULL,
  `blocks` INT NULL,
  `steals` INT NULL,
  `turnovers` INT NULL,
  PRIMARY KEY (`team_id`),
  INDEX `season_type_idx` (`game_date` ASC) VISIBLE,
  UNIQUE INDEX `game_date_UNIQUE` (`game_date` ASC) VISIBLE,
  CONSTRAINT `season_type`
    FOREIGN KEY (`game_date`)
    REFERENCES `nba_db`.`season_type` (`game_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`team_playoff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`team_playoff` (
  `team_id` VARCHAR(5) NOT NULL,
  `17_18` VARCHAR(15) NULL,
  `18_19` VARCHAR(15) NULL,
  `19_20` VARCHAR(15) NULL,
  `20_21` VARCHAR(15) NULL,
  PRIMARY KEY (`team_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`team_regular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`team_regular` (
  `team_id` VARCHAR(5) NOT NULL,
  `17_18` VARCHAR(15) NULL,
  `18_19` VARCHAR(15) NULL,
  `19_20` VARCHAR(15) NULL,
  `20_21` VARCHAR(15) NULL,
  PRIMARY KEY (`team_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`team_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`team_info` (
  `team_id` VARCHAR(5) NOT NULL,
  `f_name` VARCHAR(20) NOT NULL,
  `l_name` VARCHAR(20) NOT NULL,
  `stadium` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`team_id`),
  INDEX `stadium_idx` (`stadium` ASC) VISIBLE,
  CONSTRAINT `stadium`
    FOREIGN KEY (`stadium`)
    REFERENCES `nba_db`.`stadium` (`s_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `team_coach`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba_db`.`coach` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `team_game`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba_db`.`team_all_game` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `team_playoff`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba_db`.`team_playoff` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `team_regular`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba_db`.`team_regular` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`player_all_game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`player_all_game` (
  `player_id` VARCHAR(20) NOT NULL,
  `game_date` DATE NULL,
  `minutes` TIME NULL,
  `points` INT NULL,
  `rebounds` INT NULL,
  `assists` INT NULL,
  `blocks` INT NULL,
  `steals` INT NULL,
  `turnovers` INT NULL,
  PRIMARY KEY (`player_id`),
  INDEX `season_type_idx` (`game_date` ASC) VISIBLE,
  CONSTRAINT `seasontype`
    FOREIGN KEY (`game_date`)
    REFERENCES `nba_db`.`season_type` (`game_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`player_awards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`player_awards` (
  `player_id` VARCHAR(20) NOT NULL,
  `award_type` VARCHAR(10) NULL,
  `season_year` INT NULL,
  PRIMARY KEY (`player_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba_db`.`player_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nba_db`.`player_info` (
  `player_id` VARCHAR(20) NOT NULL,
  `f_name` VARCHAR(20) NULL,
  `l_name` VARCHAR(20) NULL,
  `team_id` VARCHAR(5) NULL,
  `position` VARCHAR(5) NULL,
  PRIMARY KEY (`player_id`),
  INDEX `player_team_idx` (`team_id` ASC) VISIBLE,
  CONSTRAINT `player_stats`
    FOREIGN KEY (`player_id`)
    REFERENCES `nba_db`.`player_all_game` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba_db`.`team_info` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player_awards`
    FOREIGN KEY (`player_id`)
    REFERENCES `nba_db`.`player_awards` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

/*
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
*/