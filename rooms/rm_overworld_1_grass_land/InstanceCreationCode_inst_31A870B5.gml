interaction = function(){
	var _yes_dialog = function(){
		overworld_dialog(global.dialogues.grass_land.interaction_3.option_1,, false)
	}
	
	var _no_dialog = function(){
		overworld_dialog(global.dialogues.grass_land.interaction_3.option_2,, false)
	}
	
	var _maybe_dialog = function(){
		overworld_dialog(global.dialogues.grass_land.interaction_3.option_3,, false)
	}
	
	var _idk_dialog = function(){
		overworld_dialog(global.dialogues.grass_land.interaction_3.option_4,, false)
	}
	
	var _options = global.dialogues.grass_land.interaction_3.options
	create_plus_choice_option(PLUS_CHOICE_DIRECTION.LEFT, 110, _options[0], _yes_dialog)
	create_plus_choice_option(PLUS_CHOICE_DIRECTION.RIGHT, 110, _options[1], _no_dialog)
	create_plus_choice_option(PLUS_CHOICE_DIRECTION.UP, 35, _options[2], _maybe_dialog)
	create_plus_choice_option(PLUS_CHOICE_DIRECTION.DOWN, 35, _options[3], _idk_dialog)
	
	overworld_dialog(global.dialogues.grass_land.interaction_3.dialog,, false)
}