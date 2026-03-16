add_instance_reference(id, "inst_flowey_4")

no_double_interaction = false

interaction = function(){
	if (no_double_interaction){
		no_double_interaction = false
		
		return
	}
	
	var _start_attack = function(){
		obj_game.dialog.next_dialog()
		start_attack(ENEMY_ATTACK.PLATFORM_1,,,,,, 320, 240)
	}
	
	var _no_attack = function(){
		obj_game.dialog.next_dialog()
		no_double_interaction = true //This will make it so you don't reactivate the dialog interaction again.
	}
	
	var _options = global.dialogues.arena.flowey_4.options
	create_plus_choice_option(PLUS_CHOICE_DIRECTION.LEFT, 120, _options[0], _start_attack)
	create_plus_choice_option(PLUS_CHOICE_DIRECTION.RIGHT, 120, _options[1], _no_attack)
	
	overworld_dialog(global.dialogues.arena.flowey_4.dialog,, false)
}