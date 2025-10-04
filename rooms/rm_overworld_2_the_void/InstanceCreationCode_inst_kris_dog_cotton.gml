interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(real(id)) + "]My name is Cotton.","[bind_instance:" + string(real(object_index)) + "]We are part of the entity group kris dog.","[bind_instance:" + string(real(id)) + "]I believe the name doesn't make sense[w:10], we are vessels but oh well..."], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}