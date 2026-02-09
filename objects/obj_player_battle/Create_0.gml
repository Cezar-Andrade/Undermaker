/// @description Variable declaration

x = 320
y = 240
movement_speed = 2
mode = -1
invulnerability_frames = 0
trail = false

//-------------------------------------

layer_trail = layer_create(depth + 1, "Soul Trail")
trail_sprites = []
soul_previous_positions = []

gravity_data = {direction: GRAVITY_SOUL.DOWN, box_bound: true, on_platform: false, slam: false, allowed_angle_range_to: {jump: 30, bonk: 45}, platform: {x: 0, y: 0, vel: {x: 0, y: 0}}, cannot_jump: false, cannot_stop_jump: false, ignore_first_frame: false, prev_platform: {found: false, platform: undefined}, conveyor_push: {val: 0, count: 0}, movement: {direction: 0, speed: 0, direction_change: {time: 4, speed: movement_speed}}, jump: {movement_offset: 0, speed: 0, duration: 38, max_height: 80}, orange_mode: false}

move_x = 0
move_y = 0
move_to_x = undefined
move_to_y = undefined

set_mode = function(_mode, _args_struct=undefined){
	mode = _mode
	
	switch (mode){
		case SOUL_MODE.NORMAL:{
			image_blend = c_red
			image_angle = 0
		break}
		case SOUL_MODE.GRAVITY:{
			with (gravity_data){
				direction = GRAVITY_SOUL.DOWN
				orange_mode = false
				jump.speed = 0
				jump.movement_offset = 0
			
				if (is_undefined(_args_struct)){
					other.image_blend = make_color_rgb(0,60,255)
				}else{
					if (variable_struct_exists(_args_struct, "box_bound") and !_args_struct.box_bound){
						box_bound = false
					}
					
					if (variable_struct_exists(_args_struct, "orange") and !_args_struct.orange){
						other.image_blend = make_color_rgb(0,60,255)
					}else{
						other.image_blend = make_color_rgb(255,127,0)
				
						orange_mode = true
						movement_direction = 0
					}
				}
			}
		break}
	}
}

set_mode(SOUL_MODE.NORMAL)

box_collsion_func = function(_direction){
		_direction += image_angle
		
		while (_direction < -360){
			_direction += 360
		}
		while (_direction > 360){
			_direction -= 360
		}
		
		if (mode == SOUL_MODE.GRAVITY){
			with (gravity_data){
				var _gravity = 2*jump.max_height/power(jump.duration, 2)
				var _is_grounded = false
				
				var _angle_to_jump_min = 90 + 90*direction - allowed_angle_range_to.jump
				var _angle_to_jump_max = 90 + 90*direction + allowed_angle_range_to.jump
				var _angle_to_bonk_min = 270 + 90*direction - allowed_angle_range_to.bonk
				var _angle_to_bonk_max = 270 + 90*direction + allowed_angle_range_to.bonk
				
				while (_direction < 0){
					_direction += 360
				}
				while (_direction >= 360){
					_direction -= 360
				}
				
				switch (direction){
					case GRAVITY_SOUL.DOWN: case GRAVITY_SOUL.UP:{
						if (_direction >= _angle_to_jump_min and _direction <= _angle_to_jump_max){
							if (orange_mode){
								jump.speed = _gravity*jump.duration
							}else{
								jump.speed = -1.5
							}
							_is_grounded = true
						
							if (slam){
								audio_play_sound(snd_player_slam, 0, false)
								
								slam = false
							}
						}else if (_direction >= _angle_to_bonk_min and _direction <= _angle_to_bonk_max){
							var _move_y = (direction - 1)*(jump.speed - _gravity/2)
							var _speed = point_distance(0, 0, movement.speed, _move_y)
							var _speed_angle = point_direction(0, 0, movement.speed, _move_y)
							var _reflected_angle = _direction - angle_difference(_direction, _speed_angle)
							
							jump.speed = _speed*dsin(_reflected_angle)/(direction - 1) + _gravity/2
							movement.speed = clamp(_speed*dcos(_reflected_angle), -other.movement_speed, other.movement_speed)
						}else{ //Walls
							movement.speed -= movement.speed*abs(dcos(_direction))
						}
						
						if (!orange_mode and ((get_up_button() and direction == GRAVITY_SOUL.DOWN) or (get_down_button() and direction == GRAVITY_SOUL.UP)) and _is_grounded){
							jump.speed = _gravity*jump.duration
						}
					break}
					default:{ //GRAVITY_SOUL.RIGHT, GRAVITY_SOUL.LEFT, TODO
						if (_direction >= _angle_to_jump_min and _direction <= _angle_to_jump_max){
							if (orange_mode){
								jump.speed = _gravity*jump.duration
							}else{
								jump.speed = -1.5
							}
							_is_grounded = true
						
							if (slam){
								audio_play_sound(snd_player_slam, 0, false)
								
								slam = false
							}
						}else if (_direction >= _angle_to_bonk_min and _direction <= _angle_to_bonk_max){
							var _move_y = (direction - 1)*(jump.speed - _gravity/2)
							var _speed = point_distance(0, 0, movement.speed, _move_y)
							var _speed_angle = point_direction(0, 0, movement.speed, _move_y)
							var _reflected_angle = _direction - angle_difference(_direction, _speed_angle)
							
							jump.speed = _speed*dsin(_reflected_angle)/(direction - 1) + _gravity/2
							movement.speed = clamp(_speed*dcos(_reflected_angle), -other.movement_speed, other.movement_speed)
						}else{ //Walls
							movement.speed -= movement.speed*dcos(_direction)
						}
					
						if (!orange_mode and ((get_up_button() and direction == GRAVITY_SOUL.DOWN) or (get_down_button() and direction == GRAVITY_SOUL.UP)) and _is_grounded){
							jump.speed = _gravity*jump.duration
						}
					break}
				}
			}
		}
	}