can_player_collide = false;

interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["I'm a test dialog too...", "But why are you stepping on me...[w:20] So rude!"], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}