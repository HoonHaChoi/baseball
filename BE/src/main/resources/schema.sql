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
  `is_top` TINYINT(1) NOT NULL DEFAULT 1,
  `inning` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;

ALTER TABLE `baseball_db`.`game` AUTO_INCREMENT=0;


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
  PRIMARY KEY (`id`, `game_id`),
  INDEX `fk_team_game1_idx` (`game_id` ASC) VISIBLE,
  CONSTRAINT `fk_team_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `baseball_db`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

ALTER TABLE `baseball_db`.`team` AUTO_INCREMENT=0;

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

ALTER TABLE `baseball_db`.`inning` AUTO_INCREMENT=0;
