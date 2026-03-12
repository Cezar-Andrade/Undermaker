function get_encounter_initial_dialog(_enemies){
	//Do stuff depending on enemies, you got a list of them as paramenters, usually to add flavour text, look at the example provided.
	
	var _dialog = ""
	var _length = array_length(_enemies)
	
	if (_length <= 2){
		if (_length == 2 and _enemies[0] == _enemies[1]){
			switch (_enemies[0]){
				case ENEMY.MAD_DUMMY_DRAWN:{
					_dialog = "Two Mad Dummies join battle to persuade you to use drawing functions."
				break}
				case ENEMY.MAD_DUMMY_SPRITED:{
					_dialog = "Two Mad Dummies attempt to sell you sprited functions through battle."
				break}
			}
			
			return _dialog
		}
	
		switch (_enemies[0]){ //Filter by first enemie
			case ENEMY.MAD_DUMMY_DRAWN:{
				_dialog += "Mad Dummy draws into battle."
			break}
			case ENEMY.MAD_DUMMY_SPRITED:{
				_dialog += "Mad Dummy sprites into battle."
			break}
			case ENEMY.MONSTER_1:{
				_dialog += "A Monster engages with you.[w:30]\nNot in a romantic way."
			break}
			case ENEMY.MONSTER_2:{
				_dialog += "A Monster engages with you.[w:30]\nIn an angry way."
			break}
		}
		
		if (_length == 2){
			switch (_enemies[1]){
				case ENEMY.MAD_DUMMY_DRAWN:{
					_dialog += "[w:30]\nAnother one joins to draw your attention."
				break}
				case ENEMY.MAD_DUMMY_SPRITED:{
					_dialog += "[w:30]\nAnother one joins to sprite them away."
				break}
			}
		}
	}else{
		_dialog = "A battle has started!"
	}
	
	return _dialog
}

function get_encounter_functions(_enemies){
	//Do stuff depending on enemies, you got a list of them as paramenters
	
	var _end_function = function(_enemies_left, _enemies_killed, _enemies_spared, _battle_fled){ //Custom function for the encounter
		var _text = ""
		
		var _length = array_length(_enemies_left)
		for (var _i=0; _i<_length; _i++){
			var _enemy = _enemies_left[_i]
			_text += string_concat(_enemy.name, " was left alive.\n")
		}
		
		_length = array_length(_enemies_killed)
		for (var _i=0; _i<_length; _i++){
			var _enemy = _enemies_killed[_i]
			_text += string_concat(_enemy.name, " was killed.\n")
		}
		
		_length = array_length(_enemies_spared)
		for (var _i=0; _i<_length; _i++){
			var _enemy = _enemies_spared[_i]
			_text += string_concat(_enemy.name, " was spared.\n")
		}
		
		_text += string_concat("You ", ((_battle_fled) ? "fled" : "didn't flee"), " the battle.")
		
		overworld_dialog(_text,, (obj_player_overworld.y > 210))
	}
	
	return [BATTLE_START_ANIMATION.NORMAL, mus_enemy_approaching, BATTLE_BACKGROUND.SQUARE_GRID, undefined, _end_function, 48, 453] //By default these are the values of the start_battle() parameters after the first 2 (except the _end_function one, that is undefined by default)
}
