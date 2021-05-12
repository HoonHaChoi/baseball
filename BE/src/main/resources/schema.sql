-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema baseball_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema baseball_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `baseball_db` DEFAULT CHARACTER SET utf8 ;
USE `baseball_db` ;

-- -----------------------------------------------------
-- Table `baseball_db`.`game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `baseball_db`.`game`;
CREATE TABLE IF NOT EXISTS `baseball_db`.`game` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `selected_team_id` INT NULL,
  `home_team_id` INT NULL,
  `away_team_id` INT NULL,
  `is_top` TINYINT(1) NOT NULL DEFAULT 1,
  `inning` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `baseball_db`.`team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `baseball_db`.`team`;
CREATE TABLE IF NOT EXISTS `baseball_db`.`team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `is_occupied` TINYINT(1) NOT NULL DEFAULT 0,
  `is_hitting` TINYINT(1) NOT NULL DEFAULT 0,
  `score` INT NOT NULL DEFAULT 0,
  `game_id` INT NOT NULL,
  `is_selected` TINYINT(1) NOT NULL DEFAULT 0,
  `now_batter` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `game_id`),
  INDEX `fk_team_game1_idx` (`game_id` ASC) VISIBLE,
  CONSTRAINT `fk_team_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `baseball_db`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `baseball_db`.`inning`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `baseball_db`.`inning`;
CREATE TABLE IF NOT EXISTS `baseball_db`.`inning` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `is_first_base` TINYINT(1) NOT NULL DEFAULT 0,
  `is_second_base` TINYINT(1) NOT NULL DEFAULT 0,
  `is_third_base` TINYINT(1) NOT NULL DEFAULT 0,
  `strike` INT NOT NULL DEFAULT 0,
  `ball` INT NOT NULL DEFAULT 0,
  `out` INT NOT NULL DEFAULT 0,
  `game_id` INT NOT NULL,
  PRIMARY KEY (`id`, `game_id`),
  INDEX `fk_inning_game1_idx` (`game_id` ASC) VISIBLE,
  CONSTRAINT `fk_inning_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `baseball_db`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `baseball_db`.`player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `baseball_db`.`player`;
CREATE TABLE IF NOT EXISTS `baseball_db`.`player` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `num_of_throwing` INT NOT NULL DEFAULT 0,
  `num_of_hitting` INT NOT NULL DEFAULT 0,
  `num_of_batting` INT NOT NULL DEFAULT 0,
  `num_of_out` INT NOT NULL DEFAULT 0,
  `num_of_strike` VARCHAR(45) NOT NULL DEFAULT 0,
  `num_of_ball` VARCHAR(45) NOT NULL DEFAULT 0,
  `position` VARCHAR(45) NOT NULL DEFAULT 'batter',
  `team_id` INT NOT NULL,
  `team_game_id` INT NOT NULL,
  PRIMARY KEY (`id`, `team_id`, `team_game_id`),
  INDEX `fk_player_team1_idx` (`team_id` ASC, `team_game_id` ASC) VISIBLE,
  CONSTRAINT `fk_player_team1`
    FOREIGN KEY (`team_id` , `team_game_id`)
    REFERENCES `baseball_db`.`team` (`id` , `game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `baseball_db`.`record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `baseball_db`.`record`;
CREATE TABLE IF NOT EXISTS `baseball_db`.`record` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `batter_name` VARCHAR(45) NOT NULL,
  `num_of_strike` INT NOT NULL DEFAULT 0,
  `num_of_ball` INT NOT NULL DEFAULT 0,
  `status` VARCHAR(45) NOT NULL DEFAULT 'doing',
  `inning_id` INT NOT NULL DEFAULT 1,
  `inning_game_id` INT NOT NULL,
  PRIMARY KEY (`id`, `inning_id`, `inning_game_id`),
  INDEX `fk_record_inning1_idx` (`inning_id` ASC, `inning_game_id` ASC) VISIBLE,
  CONSTRAINT `fk_record_inning1`
    FOREIGN KEY (`inning_id` , `inning_game_id`)
    REFERENCES `baseball_db`.`inning` (`id` , `game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
