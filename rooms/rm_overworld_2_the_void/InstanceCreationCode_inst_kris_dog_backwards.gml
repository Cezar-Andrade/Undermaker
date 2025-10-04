interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(real(id)) + "]My name is Backwards.","[bind_instance:" + string(real(object_index)) + "]We are part of the entity group kris dog.","[bind_instance:" + string(real(id)) + "]I was placed backwards to demonstrate you can do this with any entity.","It's a bit uncomfortable though..."], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}

draw = function(){
	draw_sprite_ext(spr_kris_dog, image_index, x + 14, y - 60, 2, 2, 180, c_white, 1);
}