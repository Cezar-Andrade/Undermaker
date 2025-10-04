/// @description Collision, interaction and layer handling

if (can_collide){
	var _colliding_instances = [];
	var _instance_directions = [];
	var _collision_amount = 0;
	
	with (obj_collision){
		if (place_meeting(x, y, other) and !is_undefined(when_colliding)){
			when_colliding();
		}
	}
	
	with (obj_interaction){
		if (place_meeting(x, y, other) and !is_undefined(when_colliding)){
			when_colliding();
		}
	}
	
	with (obj_entity){
		if (place_meeting(x, y, other) and !is_undefined(when_colliding)){
			when_colliding();
		}
	}
	
	var _current_x = x;
	var _current_y = y;
	var _has_checked = false;
	var _a_valid_direction_found = false;
	
	do{
		//This is for the obj_collision, which if the collision_id is 0, it will make the player collide with it.
		//Different ids of collision are used so other objects like obj_entity can interact with these in different ways, shaping mazes where you push rocks, etc.
		with (obj_collision){
			if (collision_id == 0){
				_collision_amount = general_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_collision_object_and_interaction_collision);
			}
		}
		
		//obj_interaction acts like collision as well if their variable is set.
		//These pack dialog if interacted with of course, but most of the time they are paired with a collision to interact on the wall or to an object you cannot pass trough.
		//So I made it a feature of the object itself, so you save space on putting it paired with a collision.
		with (obj_interaction){
			if (can_player_collide){
				_collision_amount = general_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_collision_object_and_interaction_collision);
			}
		}
		
		with (obj_entity){
			if (can_player_collide and !can_player_push){
				_collision_amount = general_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_entity_collision);
			}
		}
		
		if (!_has_checked){
			_has_checked = true;
			
			if (_collision_amount >= 2){
				for (var _i=0; _i < _collision_amount; _i++){
					var _valid_direction = true;
					var _direction = _instance_directions[_i];
					var _offset_x = dcos(_direction);
					var _offset_y = -dsin(_direction);
				
					do{
						for (var _j=0; _j < _collision_amount; _j++){
							if (_i == _j){
								continue;
							}
						
							if (!place_meeting(_current_x + _offset_x, _current_y + _offset_y, _colliding_instances[_j])){
								_valid_direction = false;
							
								break;
							}
						}
					
						if (!_valid_direction){
							break;
						}
					
						_offset_x += dcos(_direction);
						_offset_y -= dsin(_direction);
					}until (!place_meeting(_current_x + _offset_x, _current_y + _offset_y, _colliding_instances[_i]));
				
					if (_valid_direction){
						for (var _j=0; _j < _collision_amount; _j++){
							if (_i == _j){
								continue;
							}
						
							if (place_meeting(_current_x + _offset_x, _current_y + _offset_y, _colliding_instances[_j])){
								_valid_direction = false;
							
								break;
							}
						}
					
						if (_valid_direction){
							for (var _j=0; _j < _collision_amount; _j++){
								if (_i == _j){
									continue;
								}
							
								_instance_directions[_j] = _direction;
							}
						
							_a_valid_direction_found = true;
							x = _current_x;
							y = _current_y;
						
							break;
						}
					}
				}
			}
		}
		
		if (!_a_valid_direction_found){
			if (_current_x == x and _current_y == y){
				break;
			}else{
				_current_x = x;
				_current_y = y;
			}
		}else{
			_a_valid_direction_found = false;
		}
	}until (_collision_amount == 0);
	
	//obj_entity represents a being or an interactable object to do various stuff.
	//So they act as a collision to the player no matter what, you may control what to do once the player collides with them with its collision function, like trigger some death scene perhaps from a foe.
	with (obj_entity){
		if (can_player_collide and place_meeting(x, y, other)){
			//Function that runs when the player collides with the entity.
			if (!is_undefined(when_colliding)){
				when_colliding();
			}
			
			//If the pushable flag is true, then the object may be moved around by the player.
			if (can_player_push){
				push_entity(other);
				
				//When the pushing has taken effect and the object cannot be pushed around any further, then it may overlap the player, so a collsion has to be checked to see if the player is still colliding with it after the push action.
				if (place_meeting(x, y, other)){
					do{
						_collision_amount = general_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_entity_collision);
					}until (_collision_amount == 0);
				}
			}
		}
	}
}

if (obj_game.state == GAME_STATE.PLAYER_CONTROL){
	//This is the part where the interaction check is being executed.
	var _direction = 90*(image_index div 4); //It calculates the direction the player is looking, where 0 is down, 90 is right, 180 is up and 270 is left.
	var _is_interacting = false;
	
	with (obj_interaction){
		_is_interacting = handle_interaction_action(_direction, other.movement_speed);
		
		if (_is_interacting){
			break;
		}
	}
	
	with (obj_entity){
		_is_interacting = handle_interaction_action(_direction, other.movement_speed);
		
		if (_is_interacting){
			break;
		}
	}
	
	if (!_is_interacting and can_open_menu and global.menu_button and obj_game.dialog.is_finished()){
		obj_game.state = GAME_STATE.PLAYER_MENU_CONTROL;
		obj_game.player_menu_state = PLAYER_MENU_STATE.INITIAL;
		obj_game.player_menu_selection[0] = 0;
		obj_game.player_menu_top = ((y - camera_get_view_y(view_camera[0])) < 310);
		
		player_anim_stop();
		
		audio_play_sound(snd_menu_selecting, 0, false);
	}
}

depth = -y;