interaction = function(){
	var _yes_dialog = function(){
		overworld_dialog(global.dialogues.grass_land.interaction_2.option_1,, false)
	}
	
	var _no_dialog = function(){
		overworld_dialog(global.dialogues.grass_land.interaction_2.option_2,, false)
	}
	
	var _options = global.dialogues.grass_land.interaction_2.options
	create_plus_choice_option(PLUS_CHOICE_DIRECTION.LEFT, 80, _options[0], _yes_dialog)
	create_plus_choice_option(PLUS_CHOICE_DIRECTION.RIGHT, 80, _options[1], _no_dialog)
	
	overworld_dialog(global.dialogues.grass_land.interaction_2.dialog,, false)
}