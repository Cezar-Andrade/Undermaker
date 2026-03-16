add_instance_reference(id, "inst_coach")

interaction = function(){
	if (!is_random_encounters_active()){
		var _yes_dialog = function(){
			overworld_dialog(global.dialogues.arena.coach.no_encounters.yes_dialog,, false)
			
			set_random_encounters([ENEMY.MAD_DUMMY_DRAWN, ENEMY.MAD_DUMMY_SPRITED], 60,, 2, ENCOUNTER_ENEMIE_SELECTION.COMBINE)
		}
	
		var _no_dialog = function(){
			overworld_dialog(global.dialogues.arena.coach.no_encounters.no_dialog,, false)
		}
		
		var _dialog_set = global.dialogues.arena.coach.no_encounters
		var _options = _dialog_set.options
		
		create_plus_choice_option(PLUS_CHOICE_DIRECTION.LEFT, 80, _options[0], _yes_dialog)
		create_plus_choice_option(PLUS_CHOICE_DIRECTION.RIGHT, 80, _options[1], _no_dialog)
	
		overworld_dialog(_dialog_set.dialog,, false)
	}else{
		var _yes_dialog = function(){
			overworld_dialog(global.dialogues.arena.coach.yes_encounters.yes_dialog,, false)
			
			toggle_random_encounters(false)
		}
	
		var _no_dialog = function(){
			overworld_dialog(global.dialogues.arena.coach.yes_encounters.no_dialog,, false)
		}
		
		var _dialog_set = global.dialogues.arena.coach.yes_encounters
		var _options = _dialog_set.options
		
		create_plus_choice_option(PLUS_CHOICE_DIRECTION.LEFT, 80, _options[0], _yes_dialog)
		create_plus_choice_option(PLUS_CHOICE_DIRECTION.RIGHT, 80, _options[1], _no_dialog)
	
		overworld_dialog(_dialog_set.dialog,, false)
	}
}