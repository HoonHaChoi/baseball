

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
insert into player(name, position, team_id, team_game_id, image_url) values ('Park1', 'pitcher', 1, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/3dfc5a4e-c86c-43a8-b980-bfab6967b908/HyunjinRyu.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074549Z&X-Amz-Expires=86400&X-Amz-Signature=4421c07666f73d60f295cd18714f8d3479348977df4d936c075da46c210c7b46&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22HyunjinRyu.png%22');
insert into player(name, team_id, team_game_id, is_now_on, image_url) values ('Park2', 1, 1, true, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Park3', 1, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Park4', 1, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Park5', 1, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Park6', 1, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Park7', 1, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Park8', 1, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Park9', 1, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');

-- -----------------------------------------------------
-- player, team 2, game1
-- -----------------------------------------------------
insert into player(name, position, team_id, team_game_id, is_now_on, image_url) values ('Choi1', 'pitcher', 2, 1, true, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/3dfc5a4e-c86c-43a8-b980-bfab6967b908/HyunjinRyu.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074549Z&X-Amz-Expires=86400&X-Amz-Signature=4421c07666f73d60f295cd18714f8d3479348977df4d936c075da46c210c7b46&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22HyunjinRyu.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Choi2', 2, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Choi3', 2, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Choi4', 2, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Choi5', 2, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Choi6', 2, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Choi7', 2, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Choi8', 2, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Choi9', 2, 1, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');

-- -----------------------------------------------------
-- player, team 3, game 2
-- -----------------------------------------------------
insert into player(name, position, team_id, team_game_id, image_url) values ('kim1', 'pitcher', 3, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/3dfc5a4e-c86c-43a8-b980-bfab6967b908/HyunjinRyu.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074549Z&X-Amz-Expires=86400&X-Amz-Signature=4421c07666f73d60f295cd18714f8d3479348977df4d936c075da46c210c7b46&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22HyunjinRyu.png%22');
insert into player(name, team_id, team_game_id, is_now_on, image_url) values ('kim2', 3, 2, true, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('kim3', 3, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('kim4', 3, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('kim5', 3, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('kim6', 3, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('kim7', 3, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('kim8', 3, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('kim9', 3, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');

-- -----------------------------------------------------
-- player, team 4, game 2
-- -----------------------------------------------------
insert into player(name, position, team_id, team_game_id, is_now_on, image_url) values ('Lee1', 'pitcher', 4, 2, true, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/3dfc5a4e-c86c-43a8-b980-bfab6967b908/HyunjinRyu.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074549Z&X-Amz-Expires=86400&X-Amz-Signature=4421c07666f73d60f295cd18714f8d3479348977df4d936c075da46c210c7b46&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22HyunjinRyu.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Lee2', 4, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Lee3', 4, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Lee4', 4, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Lee5', 4, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Lee6', 4, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Lee7', 4, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Lee8', 4, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');
insert into player(name, team_id, team_game_id, image_url) values ('Lee9', 4, 2, 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/feddbabb-a993-475b-89b6-98f9809d4cb0/Lee.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210513%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210513T074309Z&X-Amz-Expires=86400&X-Amz-Signature=f8dacee32f88fe2e45f99fbcd245a1b80a9d00eeb37245b094c362f2a085096d&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Lee.png%22');

-- -----------------------------------------------------
-- record, inning 1, game 1
-- -----------------------------------------------------
insert into record(batter_name, status, inning_id, inning_game_id) values ('Park2', 'doing', 1, 1);
--insert into record(batter_name, status, inning_id, inning_game_id) values ('Choi11', 'out', 1, 1);
--insert into record(batter_name, status, inning_id, inning_game_id) values ('Choi12', 'hit', 1, 1);

-- -----------------------------------------------------
-- record, inning 1, game 2
-- -----------------------------------------------------
insert into record(batter_name, status, inning_id, inning_game_id) values ('kim2', 'doing', 13, 2);
--insert into record(batter_name, status, inning_id, inning_game_id) values ('Lee11', 'out', 13, 2);
--insert into record(batter_name, status, inning_id, inning_game_id) values ('Lee12', 'hit', 13, 2);
