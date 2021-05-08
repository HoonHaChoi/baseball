

-- -----------------------------------------------------
-- game
-- -----------------------------------------------------
insert into game(id, home_team_id, away_team_id, selected_team_id) values (null, 1, 2, 1);
insert into game(id, home_team_id, away_team_id, selected_team_id) values (null, 3, 4, 3);

-- -----------------------------------------------------
-- team
-- -----------------------------------------------------
insert into team(name, is_occupied, is_hitting, game_id) values ('Captin', true, true, 1);
insert into team(name, is_occupied, game_id) values ('Iron Man', false, 1);
insert into team(name, is_occupied, is_hitting, game_id) values ('Twins', false, true, 2);
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
insert into player(name, position, team_id, team_game_id) values ('Park1', 'pitcher', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park2', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park3', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park4', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park5', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park6', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park7', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park8', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park9', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park10', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park11', 1, 1);
insert into player(name, team_id, team_game_id) values ('Park12', 1, 1);

-- -----------------------------------------------------
-- player, team 2, game1
-- -----------------------------------------------------
insert into player(name, position, team_id, team_game_id) values ('Choi1', 'pitcher', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi2', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi3', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi4', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi5', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi6', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi7', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi8', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi9', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi10', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi11', 2, 1);
insert into player(name, team_id, team_game_id) values ('Choi12', 2, 1);

-- -----------------------------------------------------
-- player, team 3, game 2
-- -----------------------------------------------------
insert into player(name, position, team_id, team_game_id) values ('kim1', 'pitcher', 3, 2);
insert into player(name, team_id, team_game_id) values ('kim2', 3, 2);
insert into player(name, team_id, team_game_id) values ('kim3', 3, 2);
insert into player(name, team_id, team_game_id) values ('kim4', 3, 2);
insert into player(name, team_id, team_game_id) values ('kim5', 3, 2);
insert into player(name, team_id, team_game_id) values ('kim6', 3, 2);
insert into player(name, team_id, team_game_id) values ('kim7', 3, 2);
insert into player(name, team_id, team_game_id) values ('kim8', 3, 2);
insert into player(name, team_id, team_game_id) values ('kim9', 3, 2);
insert into player(name, team_id, team_game_id) values ('kim10', 3, 2);

-- -----------------------------------------------------
-- player, team 4, game 2
-- -----------------------------------------------------
insert into player(name, position, team_id, team_game_id) values ('Lee1', 'pitcher', 4, 2);
insert into player(name, team_id, team_game_id) values ('Lee2', 4, 2);
insert into player(name, team_id, team_game_id) values ('Lee3', 4, 2);
insert into player(name, team_id, team_game_id) values ('Lee4', 4, 2);
insert into player(name, team_id, team_game_id) values ('Lee5', 4, 2);
insert into player(name, team_id, team_game_id) values ('Lee6', 4, 2);
insert into player(name, team_id, team_game_id) values ('Lee7', 4, 2);
insert into player(name, team_id, team_game_id) values ('Lee8', 4, 2);
insert into player(name, team_id, team_game_id) values ('Lee9', 4, 2);
insert into player(name, team_id, team_game_id) values ('Lee10', 4, 2);

-- -----------------------------------------------------
-- record, inning 1, game 1
-- -----------------------------------------------------
insert into record(batter_name, status, inning_id, inning_game_id) values ('Choi', 'doing', 1, 1);
--insert into record(batter_name, status, inning_id, inning_game_id) values ('Choi11', 'out', 1, 1);
--insert into record(batter_name, status, inning_id, inning_game_id) values ('Choi12', 'hit', 1, 1);

-- -----------------------------------------------------
-- record, inning 1, game 2
-- -----------------------------------------------------
insert into record(batter_name, status, inning_id, inning_game_id) values ('Lee', 'doing', 13, 2);
--insert into record(batter_name, status, inning_id, inning_game_id) values ('Lee11', 'out', 13, 2);
--insert into record(batter_name, status, inning_id, inning_game_id) values ('Lee12', 'hit', 13, 2);
