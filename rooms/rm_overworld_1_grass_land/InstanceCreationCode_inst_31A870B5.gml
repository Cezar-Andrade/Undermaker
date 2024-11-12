interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	
	var _yes_dialog = function(){
		obj_game.state = GAME_STATE.EVENT;
		overworld_dialog("Life is great[w:20], isn't it?", false);
	}
	
	var _no_dialog = function(){
		obj_game.state = GAME_STATE.EVENT;
		overworld_dialog("That's ok[w:20], I won't judge you for that[w:20], you're beautiful inside :3", false);
	}
	
	var _maybe_dialog = function(){
		obj_game.state = GAME_STATE.EVENT;
		overworld_dialog("Sometimes the answer is not clear...[w:20]\nI hope you figure that out.", false);
	}
	
	var _idk_dialog = function(){
		obj_game.state = GAME_STATE.EVENT;
		overworld_dialog("Well I don't know either[w:20], let's leave it like that.", false);
	}
	
	create_choice_option(CHOICE_DIRECTION.LEFT, 110, "Yes?", _yes_dialog);
	create_choice_option(CHOICE_DIRECTION.RIGHT, 110, "No?", _no_dialog);
	create_choice_option(CHOICE_DIRECTION.UP, 35, "Maybe?", _maybe_dialog);
	create_choice_option(CHOICE_DIRECTION.DOWN, 35, "I don't know.", _idk_dialog);
	
	overworld_dialog(["Are you a dialog test?[w:20]\nI will give you more options than the jerk on the left.","[progress_mode:none][asterisk:false][func:" + string(start_choice_plus) + ", 320, 390]"], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}