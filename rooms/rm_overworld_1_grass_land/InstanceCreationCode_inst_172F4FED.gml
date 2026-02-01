interaction = function(){
	var _yes_dialog = function(){
		overworld_dialog("Nice[w:20], we can be friends then!",, false)
	}
	
	var _no_dialog = function(){
		overworld_dialog("...[w:20]Then don't talk to me ever again.",, false)
	}
	
	create_choice_option(CHOICE_DIRECTION.LEFT, 80, "Yes?", _yes_dialog)
	create_choice_option(CHOICE_DIRECTION.RIGHT, 80, "No?", _no_dialog)
	
	overworld_dialog(["[progress_mode:none]Are you a dialog test?[func:" + string(start_choice_plus) + ",320,430,false]"],, false)
}