interaction = function(){
	var _option_1 = function(){
		overworld_dialog(global.dialogues.grass_land.interaction_1.option_1,, false)
	}
	
	var _option_2 = function(){
		overworld_dialog(global.dialogues.grass_land.interaction_1.option_2,, false)
	}
	
	var _option_3 = function(){
		overworld_dialog(global.dialogues.grass_land.interaction_1.option_3,, false)
	}
	
	var _options = global.dialogues.grass_land.interaction_1.options
	create_grid_choice_option(_options[0], _option_1)
	create_grid_choice_option(_options[1], _option_2)
	create_grid_choice_option(_options[2], _option_3)
	
	overworld_dialog(global.dialogues.grass_land.interaction_1.dialog,, false)
}