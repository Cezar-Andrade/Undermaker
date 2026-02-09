//GENERAL FUNCTIONS - CONTROL INPUT

function any_direction_button(_hold=true){
	if (_hold){
		return (global.up_hold_button or global.down_hold_button or global.left_hold_button or global.right_hold_button)
	}else{
		return (global.up_button or global.down_button or global.left_button or global.right_button)
	}
}

function any_horizontal_button(_hold=true){
	if (_hold){
		return (global.left_hold_button or global.right_hold_button)
	}else{
		return (global.left_button or global.right_button)
	}
}

function any_vertical_button(_hold=true){
	if (_hold){
		return (global.up_hold_button or global.down_hold_button)
	}else{
		return (global.up_button or global.down_button)
	}
}

function get_left_button(_hold=true){
	if (_hold){
		return global.left_hold_button
	}else{
		return global.left_button
	}
}

function get_right_button(_hold=true){
	if (_hold){
		return global.right_hold_button
	}else{
		return global.right_button
	}
}

function get_up_button(_hold=true){
	if (_hold){
		return global.up_hold_button
	}else{
		return global.up_button
	}
}

function get_down_button(_hold=true){
	if (_hold){
		return global.down_hold_button
	}else{
		return global.down_button
	}
}

function get_confirm_button(_hold=true){
	if (_hold){
		return global.confirm_hold_button
	}else{
		return global.confirm_button
	}
}

function get_cancel_button(_hold=true){
	if (_hold){
		return global.cancel_hold_button
	}else{
		return global.cancel_button
	}
}

function get_menu_button(_hold=true){
	if (_hold){
		return global.menu_hold_button
	}else{
		return global.menu_button
	}
}

function get_horizontal_button_force(_hold=true){
	if (_hold){
		return (global.right_hold_button - global.left_hold_button)
	}else{
		return (global.right_button - global.left_button)
	}
}

function get_vertical_button_force(_hold=true){
	if (_hold){
		return (global.down_hold_button - global.up_hold_button)
	}else{
		return (global.down_button - global.up_button)
	}
}

//UTIL FUNCTIONS

function intersection_of_lines(_x1, _y1, _direction_1, _x2, _y2, _direction_2){
	var _delta_x1 = lengthdir_x(1, _prev_direction)
	var _delta_y1 = lengthdir_y(1, _prev_direction)
	var _delta_x2 = lengthdir_x(1, _direction)
	var _delta_y2 = lengthdir_y(1, _direction)
	
	var _determinant = _delta_x1 * _delta_y2 - _delta_y1 * _delta_x2
	
	var _scalar_distance = ((_p2_x - _p_1_x) * _delta_y2 - (_p2_y - _p_1_y) * _delta_x2) / _determinant
	var _pintersection_x = _p_1_x + _scalar_distance * _delta_x1
	var _pintersection_y = _p_1_y + _scalar_distance * _delta_y1
}

//UTIL FUNCTIONS - PLAYER

function heal_player(_number){
	global.player.hp = min(global.player.hp + abs(_number), global.player.max_hp)
	
	audio_play_sound(snd_player_heal, 0, false)
}

function damage_player(_number){
	global.player.hp = max(global.player.hp - abs(_number), 0)
	
	audio_play_sound(snd_player_hurt, 0, false)
}

//BATTLE FUNCTIONS - PLAYER HEART

enum GRAVITY_SOUL{
	DOWN,
	RIGHT,
	UP,
	LEFT
}

function set_soul_mode(_mode, _args=undefined, _obj=obj_player_battle){
	with (_obj){
		set_mode(_mode, _args)
	}
}

function set_soul_gravity(_direction=GRAVITY_SOUL.DOWN, _slam=false, _obj=obj_player_battle){
	with (_obj){
		gravity_data.direction = _direction
		
		if (_slam){
			gravity_data.jump.speed = -10
			gravity_data.slam = true
		}
	}
}

function set_soul_trail(_trail=true, _obj=obj_player_battle){
	with (_obj){
		trail = _trail
	}
}

function damage_player_bullet_instance(_bullet, _player){
	with (_player){
		global.player.hp = clamp(global.player.hp + ((_bullet.type == BULLET_TYPE.GREEN) ? _bullet.damage : -_bullet.damage), (obj_game.battle_state != BATTLE_STATE.ENEMY_ATTACK), global.player.max_hp)
		
		if (global.player.status_effect.type == PLAYER_STATUS_EFFECT.KARMIC_RETRIBUTION){
			global.player.status_effect.value = min(global.player.status_effect.value + _bullet.karma, _bullet.player.hp - 1, 40)
			_bullet.karma = min(_bullet.karma, 1) //There are more steps to karmic retribution but I'm doing it the simple way really.
		}
		
		if (_bullet.type == BULLET_TYPE.GREEN){
			audio_play_sound(snd_player_heal, 0, false)
		}else{
			audio_play_sound(snd_player_hurt, 0, false)
		}
		
		invulnerability_frames = global.player.invulnerability_frames
	}
}

function is_player_soul_moving(_player=obj_player_battle){
	return _player.x != _player.xprevious or _player.y != _player.yprevious or _player.move_x != 0 or _player.move_y != 0 or (!is_undefined(_player.move_to_x) and _player.move_to_x != x) or (!is_undefined(_player.move_to_y) and _player.move_to_y != y)
}

// BATTLE FUNCTIONS - PLATFORM

enum PLATFORM_TYPE{
	NORMAL,
	CONVEYOR,
	TRAMPOLINE,
	STICKY
}

// BATTLE FUNCTIONS - BOX

function get_box_bottom(){
	return obj_box.y - 5
}

function get_box_top(){
	return obj_box.y - obj_box.height - 5
}

function get_box_left(){
	return obj_box.x - round(obj_box.width)/2
}

function get_box_right(){
	return obj_box.x + round(obj_box.width)/2
}

// CORE FUNCTIONS - SOUL COLLISION

function general_line_collision_handler(_id, _line_points, _line_direction, _line_id, _counter_clockwise_push, _colliding_instances, _instance_directions, _collision_amount, _after_push_function=undefined){
	var _id_index = -1
	
	for (var _i=0; _i < _collision_amount; _i++){
		var _data = _colliding_instances[_i]
		if (typeof(_data) == "struct" and _data.object_id == id and _data.line_id == _line_id){
			_id_index = _i
			
			break
		}
	}
	
	if (collision_line(_line_points[0], _line_points[1], _line_points[2], _line_points[3], _id, false, false)){
		if (_id_index >= 0){
			var _direction = _instance_directions[_id_index]
			
			_id.x += dcos(_direction)
			_id.y -= dsin(_direction)
			
			_after_push_function(_direction)
			
			return _collision_amount
		}
		
		var _direction = _line_direction - 90 + 180*_counter_clockwise_push
		
		_id.x += dcos(_direction)
		_id.y -= dsin(_direction)
		
		if (!is_undefined(_after_push_function)){
			_after_push_function(_direction)
		}
		
		if (collision_line(_line_points[0], _line_points[1], _line_points[2], _line_points[3], _id, false, false)){
			array_push(_colliding_instances, {object_id: id, line_id: _line_id, points: [_line_points[0], _line_points[1], _line_points[2], _line_points[3]]})
			array_push(_instance_directions, _direction)
			_collision_amount++
		}
	}else if (_id_index >= 0){
		array_delete(_colliding_instances, _id_index, 1)
		array_delete(_instance_directions, _id_index, 1)
		_collision_amount--
	}
	
	return _collision_amount
}

function soul_update_collision(){
	var _colliding_instances = []
	var _instance_directions = []
	var _collision_amount = 0
	var _current_x = x
	var _current_y = y
	var _has_checked = false
	var _a_valid_direction_found = false
	
	with (obj_platform){
		var _p1_x = x - length/2*dcos(image_angle)
		var _p1_y = y + length/2*dsin(image_angle)
		var _p2_x = x + length/2*dcos(image_angle)
		var _p2_y = y - length/2*dsin(image_angle)
		
		if (collision_line(_p1_x, _p1_y, _p2_x, _p2_y, other, false, false) and !is_undefined(when_colliding) and !has_collided){
			when_colliding()
			has_collided = true
		}
	}
	
	do{
		//This is for the obj_collision, which if the collision_id is 0, it will make the player collide with it.
		//Different ids of collision are used so other objects like obj_entity can interact with these in different ways, shaping mazes where you push rocks, etc.
		with (obj_box){
			var _inside_points = box_polygon_points.inside
			var _outside_points = box_polygon_points.outside
			var _direction_points = box_polygon_points.direction
			var _length = array_length(box_polygon_points.inside)
			for (var _i=0; _i<_length; _i+=2){
				var _id_x, _id_y
				if (_i + 2 >= _length){
					_id_x = 0
					_id_y = 1
				}else{
					_id_x = _i + 2
					_id_y = _i + 3
				}
				
				var _player_sprite = other.sprite_index
				var _player_angle = other.image_angle
				var _sprite_bbox_left = sprite_get_bbox_left(_player_sprite)
				var _sprite_bbox_top = sprite_get_bbox_top(_player_sprite)
				var _sprite_bbox_right = sprite_get_width(_player_sprite) - sprite_get_bbox_right(_player_sprite) - 1
				var _sprite_bbox_bottom = sprite_get_height(_player_sprite) - sprite_get_bbox_bottom(_player_sprite) - 1
				var _sprite_left_collision_offset = _sprite_bbox_left*max(dcos(_player_angle), 0) + _sprite_bbox_top*max(dsin(_player_angle), 0) - _sprite_bbox_right*min(dcos(_player_angle), 0) - _sprite_bbox_bottom*min(dsin(_player_angle), 0)
				var _sprite_top_collision_offset = _sprite_bbox_top*max(dcos(_player_angle), 0) + _sprite_bbox_right*max(dsin(_player_angle), 0) - _sprite_bbox_bottom*min(dcos(_player_angle), 0) - _sprite_bbox_left*min(dsin(_player_angle), 0)
				var _sprite_right_collision_offset = _sprite_bbox_right*max(dcos(_player_angle), 0) + _sprite_bbox_bottom*max(dsin(_player_angle), 0) - _sprite_bbox_left*min(dcos(_player_angle), 0) - _sprite_bbox_top*min(dsin(_player_angle), 0)
				var _sprite_bottom_collision_offset = _sprite_bbox_bottom*max(dcos(_player_angle), 0) + _sprite_bbox_left*max(dsin(_player_angle), 0) - _sprite_bbox_top*min(dcos(_player_angle), 0) - _sprite_bbox_right*min(dsin(_player_angle), 0)
				
				var _direction = _direction_points[_i div 2]
				var _next_direction = _direction_points[_id_x div 2]
				
				var _offset = _sprite_bottom_collision_offset*max(dcos(_direction), 0) + _sprite_right_collision_offset*max(dsin(_direction), 0) - _sprite_top_collision_offset*min(dcos(_direction), 0) - _sprite_left_collision_offset*min(dsin(_direction), 0)
				
				var _normal_angle = _direction + 90
				var _p1_i_x = _inside_points[_i] + _offset*dcos(_normal_angle)
				var _p1_i_y = _inside_points[_i+1] - _offset*dsin(_normal_angle)
				var _p2_i_x = _inside_points[_id_x] + _offset*dcos(_normal_angle)
				var _p2_i_y = _inside_points[_id_y] - _offset*dsin(_normal_angle)
				
				_normal_angle = _direction - 90
				var _p1_o_x = _outside_points[_i] + _offset*dcos(_normal_angle)
				var _p1_o_y = _outside_points[_i+1] - _offset*dsin(_normal_angle)
				var _p2_o_x = _outside_points[_id_x] + _offset*dcos(_normal_angle)
				var _p2_o_y = _outside_points[_id_y] - _offset*dsin(_normal_angle)
				
				_offset = _sprite_bottom_collision_offset*max(dcos(_next_direction), 0) + _sprite_right_collision_offset*max(dsin(_next_direction), 0) - _sprite_top_collision_offset*min(dcos(_next_direction), 0) - _sprite_left_collision_offset*min(dsin(_next_direction), 0)
				
				_normal_angle = _next_direction + 90
				var _p3_i_x = _inside_points[_id_x] + _offset*dcos(_normal_angle)
				var _p3_i_y = _inside_points[_id_y] - _offset*dsin(_normal_angle)
				
				_normal_angle = _next_direction - 90
				var _p3_o_x = _outside_points[_id_x] + _offset*dcos(_normal_angle)
				var _p3_o_y = _outside_points[_id_y] - _offset*dsin(_normal_angle)
				
				var _start_id = 2*_i
				_collision_amount = general_line_collision_handler(other, [_p1_i_x, _p1_i_y, _p2_i_x, _p2_i_y], _direction, _start_id, true, _colliding_instances, _instance_directions, _collision_amount, other.box_collsion_func)
				_collision_amount = general_line_collision_handler(other, [_p2_i_x, _p2_i_y, _p3_i_x, _p3_i_y], point_direction(_p2_i_x, _p2_i_y, _p3_i_x, _p3_i_y), _start_id + 1, true, _colliding_instances, _instance_directions, _collision_amount, other.box_collsion_func)
				_collision_amount = general_line_collision_handler(other, [_p1_o_x, _p1_o_y, _p2_o_x, _p2_o_y], _direction, _start_id + 2, false, _colliding_instances, _instance_directions, _collision_amount, other.box_collsion_func)
				_collision_amount = general_line_collision_handler(other, [_p2_o_x, _p2_o_y, _p3_o_x, _p3_o_y], point_direction(_p2_o_x, _p2_o_y, _p3_o_x, _p3_o_y), _start_id + 3, false, _colliding_instances, _instance_directions, _collision_amount, other.box_collsion_func)
			}
		}
		
		with (obj_platform){
			var _p1_x = x - length/2*dcos(image_angle)
			var _p1_y = y + length/2*dsin(image_angle)
			var _p2_x = x + length/2*dcos(image_angle)
			var _p2_y = y - length/2*dsin(image_angle)
			var _direction = point_direction(_p1_x, _p1_y, _p2_x, _p2_y)
		
			_collision_amount = general_line_collision_handler(other, [_p1_x, _p1_y, _p2_x, _p2_y], _direction, 0, true, _colliding_instances, _instance_directions, _collision_amount)
		}
		
		if (!_has_checked){
			_has_checked = true
		
			if (_collision_amount >= 2){
				for (var _i=0; _i < _collision_amount; _i++){
					var _valid_direction = true
					var _direction = _instance_directions[_i]
					var _offset_x = dcos(_direction)
					var _offset_y = -dsin(_direction)
			
					do{
						for (var _j=0; _j < _collision_amount; _j++){
							if (_i == _j){
								continue
							}
					
							var _data = _colliding_instances[_j]
							if ((typeof(_data) == "ref" and !place_meeting(_current_x + _offset_x, _current_y + _offset_y, _data)) or (typeof(_data) == "struct" and !collision_line(_data.points[0] - _offset_x, _data.points[1] - _offset_y, _data.points[2] - _offset_x, _data.points[3] - _offset_y, id, false, false))){
								_valid_direction = false
						
								break
							}
						}
				
						if (!_valid_direction){
							break
						}
				
						_offset_x += dcos(_direction)
						_offset_y -= dsin(_direction)
						
						var _data = _colliding_instances[_i]
					}until ((typeof(_data) == "ref" and !place_meeting(_current_x + _offset_x, _current_y + _offset_y, _data)) or (typeof(_data) == "struct" and !collision_line(_data.points[0] - _offset_x, _data.points[1] - _offset_y, _data.points[2] - _offset_x, _data.points[3] - _offset_y, id, false, false)))
			
					if (_valid_direction){
						for (var _j=0; _j < _collision_amount; _j++){
							if (_i == _j){
								continue
							}
							
							var _data = _colliding_instances[_j]
							if ((typeof(_data) == "ref" and place_meeting(_current_x + _offset_x, _current_y + _offset_y, _data)) or (typeof(_data) == "struct" and collision_line(_data.points[0] - _offset_x, _data.points[1] - _offset_y, _data.points[2] - _offset_x, _data.points[3] - _offset_y, id, false, false))){
								_valid_direction = false
						
								break
							}
						}
			
						if (_valid_direction){
							for (var _j=0; _j < _collision_amount; _j++){
								if (_i == _j){
									continue
								}
						
								_instance_directions[_j] = _direction
							}
					
							_a_valid_direction_found = true
							x = _current_x
							y = _current_y
					
							break
						}
					}
				}
			}
		}
	
		if (!_a_valid_direction_found){
			if (_current_x == x and _current_y == y){
				break
			}else{
				_current_x = x
				_current_y = y
			}
		}else{
			_a_valid_direction_found = false
		}
	}until (_collision_amount == 0)
}

// CORE FUNCTIONS - PLAYER OVERWORLD

function player_update_collision(){
	if (can_collide){
		var _colliding_instances = []
		var _instance_directions = []
		var _collision_amount = 0
	
		with (obj_collision){
			if (place_meeting(x, y, other) and !is_undefined(when_colliding) and !has_collided){
				when_colliding()
				has_collided = true
			}
		}
	
		with (obj_interaction){
			if (place_meeting(x, y, other) and !is_undefined(when_colliding) and !has_collided){
				when_colliding()
				has_collided = true
			}
		}
	
		with (obj_entity){
			if (place_meeting(x, y, other) and !is_undefined(when_colliding) and !has_collided){
				when_colliding()
				has_collided = true
			}
		}
	
		var _current_x = x
		var _current_y = y
		var _has_checked = false
		var _a_valid_direction_found = false
	
		do{
			//This is for the obj_collision, which if the collision_id is 0, it will make the player collide with it.
			//Different ids of collision are used so other objects like obj_entity can interact with these in different ways, shaping mazes where you push rocks, etc.
			with (obj_collision){
				if (collision_id == 0){
					_collision_amount = general_object_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_collision_object_and_interaction_collision)
				}
			}
		
			//obj_interaction acts like collision as well if their variable is set.
			//These pack dialog if interacted with of course, but most of the time they are paired with a collision to interact on the wall or to an object you cannot pass trough.
			//So I made it a feature of the object itself, so you save space on putting it paired with a collision.
			with (obj_interaction){
				if (can_player_collide){
					_collision_amount = general_object_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_collision_object_and_interaction_collision)
				}
			}
		
			with (obj_entity){
				if (can_player_collide and !can_player_push){
					_collision_amount = general_object_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_entity_collision)
				}
			}
		
			if (!_has_checked){
				_has_checked = true
			
				if (_collision_amount >= 2){
					for (var _i=0; _i < _collision_amount; _i++){
						var _valid_direction = true
						var _direction = _instance_directions[_i]
						var _offset_x = dcos(_direction)
						var _offset_y = -dsin(_direction)
				
						do{
							for (var _j=0; _j < _collision_amount; _j++){
								if (_i == _j){
									continue
								}
						
								if (!place_meeting(_current_x + _offset_x, _current_y + _offset_y, _colliding_instances[_j])){
									_valid_direction = false
							
									break
								}
							}
					
							if (!_valid_direction){
								break
							}
					
							_offset_x += dcos(_direction)
							_offset_y -= dsin(_direction)
						}until (!place_meeting(_current_x + _offset_x, _current_y + _offset_y, _colliding_instances[_i]))
				
						if (_valid_direction){
							for (var _j=0; _j < _collision_amount; _j++){
								if (_i == _j){
									continue
								}
						
								if (place_meeting(_current_x + _offset_x, _current_y + _offset_y, _colliding_instances[_j])){
									_valid_direction = false
							
									break
								}
							}
					
							if (_valid_direction){
								for (var _j=0; _j < _collision_amount; _j++){
									if (_i == _j){
										continue
									}
							
									_instance_directions[_j] = _direction
								}
						
								_a_valid_direction_found = true
								x = _current_x
								y = _current_y
						
								break
							}
						}
					}
				}
			}
		
			if (!_a_valid_direction_found){
				if (_current_x == x and _current_y == y){
					break
				}else{
					_current_x = x
					_current_y = y
				}
			}else{
				_a_valid_direction_found = false
			}
		}until (_collision_amount == 0)
	
		//obj_entity represents a being or an interactable object to do various stuff.
		//So they act as a collision to the player no matter what, you may control what to do once the player collides with them with its collision function, like trigger some death scene perhaps from a foe.
		with (obj_entity){
			if (can_player_collide and place_meeting(x, y, other)){
				//If the pushable flag is true, then the object may be moved around by the player.
				if (can_player_push){
					push_entity(other)
				
					//When the pushing has taken effect and the object cannot be pushed around any further, then it may overlap the player, so a collsion has to be checked to see if the player is still colliding with it after the push action.
					if (place_meeting(x, y, other)){
						do{
							_collision_amount = general_object_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_entity_collision)
						}until (_collision_amount == 0)
					}
				}
			}
		}
	}
}

function player_movement_update(){
	timer-- //Timer that makes the player behave like if it was in 30 FPS running in a 60 FPS enviroment.
	
	if (can_run and get_cancel_button() and any_direction_button()){
		timer = 0
		
		if (!is_undefined(run_sprite)){
			sprite_index = run_sprite
		}
	}else{
		sprite_index = walk_sprite
	}
	
	if (timer == 0){
		timer = 2 //Reset the timer each time.
		
		//Animation timer to animate the player, of course.
		if (any_direction_button()){
			animation_timer++
		}else{ //Reset the animation and timer if it's not moving.
			animation_timer = animation_speed - 1 //Set to 1 frame of changing the animation so it looks like it moves immediatelly after pressing.
			player_anim_stop()
		}
		
		//If the timer has reached the animation speed, update the frame of the animation.
		if (animation_timer >= animation_speed){
			animation_timer -= animation_speed
			image_index++
			
			//Walk and run frames constitute of 4 frames, if you need more than that, make sure to change it on all parts of the code, there's one above to set the player in neutral position.
			if (image_index%animation_frames == 0){
				image_index -= animation_frames
			}
		}
		
		var _y_upper_collision = false
		
		//Special case check for the frisk_dance trigger, cannot do it the normal way because of the collision id system.
		//By the way, I see you saying it's not accurate, you don't need it accurate, the feature is there and you can see it "dance", if you don't like it then do it yourself or deactivate it, this is what you're getting.
		if (frisk_dance and can_collide){
			with (obj_collision){
				if (collision_id == 0 and place_meeting(x, y + other.movement_speed*get_up_button(), other)){
					_y_upper_collision = true
					
					break
				}
			}
		}
		
		//The priority on up and right is intentional, you will have to edit this part of the code if you want that if both buttons are held, it doesn't move this priority system is also benefitial for the frisk dance feature and moon walk.
		if (get_up_button() and (!_y_upper_collision or !get_down_button())){
			move_y = -movement_speed*get_up_button()
			while (image_index >= 3*animation_frames){
				image_index -= animation_frames
			}
			while (image_index < 2*animation_frames){
				image_index += animation_frames
			}
		}else if (get_down_button()){
			move_y = movement_speed*get_down_button()
			while (image_index >= animation_frames){
				image_index -= animation_frames
			}
		}
		
		//Left and right movements, priority on right button, so you can only moon walk to the right, if you want it for both sides, do it differently than this.
		if (get_right_button()){
			move_x = movement_speed*get_right_button()
			if (!get_left_button() or !moon_walk){
				while (image_index >= 2*animation_frames){
					image_index -= animation_frames
				}
				while (image_index < animation_frames){
					image_index += animation_frames
				}
			}
		}else if (get_left_button()){
			move_x = -movement_speed*get_left_button()
			while (image_index < 3*animation_frames){
				image_index += animation_frames
			}
			while (image_index >= 4*animation_frames){
				image_index -= animation_frames
			}
		}
	}
}
