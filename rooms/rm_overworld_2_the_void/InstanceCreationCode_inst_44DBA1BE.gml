interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(real(id)) + "]This collision block on the right is awesome!","It took some days for the creator to get right[w:10], but it was worth it I would say."], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}