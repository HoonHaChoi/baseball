

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
insert into inning(n_th, game_id) values (2, 1);
insert into inning(n_th, game_id) values (3, 1);
insert into inning(n_th, game_id) values (4, 1);
insert into inning(n_th, game_id) values (5, 1);
insert into inning(n_th, game_id) values (6, 1);
insert into inning(n_th, game_id) values (7, 1);
insert into inning(n_th, game_id) values (8, 1);
insert into inning(n_th, game_id) values (9, 1);
insert into inning(n_th, game_id) values (10, 1);
insert into inning(n_th, game_id) values (11, 1);
insert into inning(n_th, game_id) values (12, 1);



-- -----------------------------------------------------
-- 1st inning, game 2
-- -----------------------------------------------------
insert into inning(game_id) values (2);
insert into inning(n_th, game_id) values (2, 2);
insert into inning(n_th, game_id) values (3, 2);
insert into inning(n_th, game_id) values (4, 2);
insert into inning(n_th, game_id) values (5, 2);
insert into inning(n_th, game_id) values (6, 2);
insert into inning(n_th, game_id) values (7, 2);
insert into inning(n_th, game_id) values (8, 2);
insert into inning(n_th, game_id) values (9, 2);
insert into inning(n_th, game_id) values (10, 2);
insert into inning(n_th, game_id) values (11, 2);
insert into inning(n_th, game_id) values (12, 2);
