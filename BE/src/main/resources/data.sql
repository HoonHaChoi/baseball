

-- -----------------------------------------------------
-- game
-- -----------------------------------------------------
insert into game(id) values (null);
insert into game(id) values (null);

-- -----------------------------------------------------
-- team
-- -----------------------------------------------------
insert into team(name, is_occupied, game_id) values ('Captin', true, 1);
insert into team(name, is_occupied, game_id) values ('Iron Man', false, 1);
insert into team(name, is_occupied, game_id) values ('Twins', false, 2);
insert into team(name, is_occupied, game_id) values ('Heros', false, 2);

-- -----------------------------------------------------
-- 1st inning, game 1
-- -----------------------------------------------------
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);
insert into inning(game_id) values (1);

-- -----------------------------------------------------
-- 1st inning, game 2
-- -----------------------------------------------------
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);
insert into inning(game_id) values (2);

-- -----------------------------------------------------
-- player, team 1, game 1
-- -----------------------------------------------------
insert into player(name, position, team_id, team_game_id) values ('kim1', 'pitcher', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim2', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim3', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim4', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim5', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim6', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim7', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim8', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim9', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim10', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim11', 1, 1);
insert into player(name, team_id, team_game_id) values ('kim12', 1, 1);

-- -----------------------------------------------------
-- player, team 2, game1
-- -----------------------------------------------------
insert into player(name, position, team_id, team_game_id) values ('Lee1', 'pitcher', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee2', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee3', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee4', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee5', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee6', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee7', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee8', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee9', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee10', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee11', 2, 1);
insert into player(name, team_id, team_game_id) values ('Lee12', 2, 1);

-- -----------------------------------------------------
-- player, team 2, game1
-- -----------------------------------------------------
insert into record(name, status, inning_id, inning_game_id) values ('Lee10', 'doing', 1, 1);
insert into record(name, status, inning_id, inning_game_id) values ('Lee11', 'out', 1, 1);
insert into record(name, status, inning_id, inning_game_id) values ('Lee12', 'hit', 1, 1);
