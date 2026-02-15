/// @description Collision, interaction and layer handling

var _move_x = (is_undefined(move_to_x) ? 0 : move_to_x - x)
var _move_y = (is_undefined(move_to_y) ? 0 : move_to_y - y)

if (_move_x != 0 or _move_y != 0){
	move_x = _move_x
	move_y = _move_y
}

if (move_x != 0 or move_y != 0){
	var _finish = false
	var _is_x_longer = (abs(move_x) >= abs(move_y))
	var _longer = abs(_is_x_longer ? move_x : move_y)
	var _increment = (_is_x_longer ? move_y : move_x)/_longer
	
	while (_longer > 0){
		array_push(player_previous_positions, [x, y])
		
		var _step = min(1, _longer)
		_longer -= min(_step, _longer)
		
		if (_is_x_longer){
			x += sign(move_x)*_step
			y += _increment*_step
		}else{
			x += _increment*_step
			y += sign(move_y)*_step
		}
		
		player_update_collision()
		
		var _length = array_length(player_previous_positions)
		for (var _j=0; _j<_length; _j++){
			var _pos = player_previous_positions[_j]
			if (_pos[0] == x and _pos[1] == y){
				_finish = true
				break
			}
		}
		
		if (_finish){
			break
		}
	}
	
	array_delete(player_previous_positions, 0, array_length(player_previous_positions))
}else{
	player_update_collision()
}

move_x = 0
move_y = 0
move_to_x = undefined
move_to_y = undefined
//x = round(x)
//y = round(y)

if (obj_game.state == GAME_STATE.PLAYER_CONTROL){
	//This is the part where the interaction check is being executed.
	var _direction = 90*(image_index div 4) //It calculates the direction the player is looking, where 0 is down, 90 is right, 180 is up and 270 is left.
	var _is_interacting = false
	
	with (obj_interaction){
		_is_interacting = handle_interaction_action(_direction, other.movement_speed)
		
		if (_is_interacting){
			break
		}
	}
	
	with (obj_entity){
		_is_interacting = handle_interaction_action(_direction, other.movement_speed)
		
		if (_is_interacting){
			break
		}
	}
	
	if (!_is_interacting and can_open_menu and global.menu_button and obj_game.dialog.is_finished()){
		obj_game.state = GAME_STATE.PLAYER_MENU_CONTROL
		obj_game.player_menu_state = PLAYER_MENU_STATE.INITIAL
		obj_game.player_menu_selection[0] = 0
		obj_game.player_menu_top = ((y - camera_get_view_y(view_camera[0])) < 310)
		
		player_anim_stop()
		
		audio_play_sound(snd_menu_selecting, 0, false)
	}
}

depth = -y