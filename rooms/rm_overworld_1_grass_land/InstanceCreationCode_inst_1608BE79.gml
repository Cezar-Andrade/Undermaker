interaction = function(){
	var _option_1 = function(){
		overworld_dialog("This option is nice yes[w:20], but pick something else.",, false)
	}
	
	var _option_2 = function(){
		overworld_dialog("Second is also good[w:20], not as good as first but not the worst.",, false)
	}
	
	var _option_3 = function(){
		overworld_dialog(["They say third is the charm[w:20], but that only matters on attempts.", "Go get a better option!"],, false)
	}
	
	create_grid_choice_option("Option 1", _option_1)
	create_grid_choice_option("Option 2", _option_2)
	create_grid_choice_option("Option 3", _option_3)
	
	overworld_dialog(["I'm an example of a grid choice dialog.","[progress_mode:none]Pick an option.[func:" + string(start_grid_choice) + ", 100, 390]"],, false)
}