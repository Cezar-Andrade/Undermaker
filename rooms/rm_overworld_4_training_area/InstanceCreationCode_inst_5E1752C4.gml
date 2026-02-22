interaction = function(){
	if (!is_random_encounters_active()){
		var _yes_dialog = function(){
			overworld_dialog("Okay have fun!",, false)
			
			set_random_encounters([ENEMY.MAD_DUMMY_DRAWN, ENEMY.MAD_DUMMY_SPRITED], 60,, 2, ENCOUNTER_ENEMIE_SELECTION.COMBINE)
		}
	
		var _no_dialog = function(){
			overworld_dialog("Alright, have fun!",, false)
		}
	
		create_plus_choice_option(PLUS_CHOICE_DIRECTION.LEFT, 80, "Yes", _yes_dialog)
		create_plus_choice_option(PLUS_CHOICE_DIRECTION.RIGHT, 80, "No", _no_dialog)
	
		overworld_dialog(["[bind_instance:" + string(real(id)) + "]I can activate random encounters for this room.","When you exit the room[w:20], encounters will be disabled","Because the trigger to change the room of this room deactivates them.","[progress_mode:none]Do you want to activate random encounters?[w:20][func:" + string(start_plus_choice) + ", 340, 430]"],, false)
	}else{
		var _yes_dialog = function(){
			overworld_dialog("Okay have fun!",, false)
			
			toggle_random_encounters(false)
		}
	
		var _no_dialog = function(){
			overworld_dialog("Alright, have fun!",, false)
		}
	
		create_plus_choice_option(PLUS_CHOICE_DIRECTION.LEFT, 80, "Yes", _yes_dialog)
		create_plus_choice_option(PLUS_CHOICE_DIRECTION.RIGHT, 80, "No", _no_dialog)
	
		overworld_dialog(["[bind_instance:" + string(real(id)) + "]I can deactivate random encounters.","[progress_mode:none]Do you want to deactivate random encounters?[w:20][func:" + string(start_plus_choice) + ", 340, 430]"],, false)
	}
}