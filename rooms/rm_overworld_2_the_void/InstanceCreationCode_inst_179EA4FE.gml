interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(id) + "]Some of these obstacles are flipped.","So you can see they work just fine no matter the orientation of the scaling."]);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}