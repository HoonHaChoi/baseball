

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
