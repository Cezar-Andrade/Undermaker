interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["I'm a test dialog.", "You can't get past me![w:20] Yippie!"]);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}