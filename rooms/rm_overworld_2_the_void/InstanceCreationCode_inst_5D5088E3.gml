timer = 0;
angle = 0;

interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(real(id)) + "]I'm floating!","However I'm scared of heights![w:10]\nPlease help me get down!"], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}

update = function(){
	timer++;
	
	angle = 10*dsin(pi*timer);
}

draw = function(){
	draw_sprite_ext(spr_kris_dog, image_index, x, y - 10 + 10*dsin(timer), -2, 2, angle, c_white, 1);
}