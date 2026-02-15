/// @description Variable declaration

width = 565
height = 130
x = 320
y = 390
resize_speed = 20
movement_speed = 10
box_size = {x: 565, y: 130}
box_position = {x: 320, y: 390}
box_center_offset = {x: 0, y: -5 - round(height)/2}
box_polygon_points = {
	inside: [x - round(width)/2, y - 5, x + round(width)/2, y - 5, x + round(width)/2, y - round(height) - 5, x - round(width)/2, y - round(height) - 5],
	outside: [],
	direction: []
}
box_default_polygons = true
box_background_color = c_black

player_collision_function = function(_id, _push_direction, _counter_clockwise_push){
	var _grip = _push_direction
	
	if (_id.mode == SOUL_MODE.GRAVITY){
		var _offset_to_grip = abs(_id.gravity_data.allowed_angle_range_to.grip)
		var _base_angle_to_jump = 90 + 90*_id.gravity_data.direction
		if (abs(angle_difference(_push_direction, _base_angle_to_jump)) <= _offset_to_grip){
			_grip = _id.gravity_data.direction + 90
		}
	}
	
	if (_id.mode == SOUL_MODE.GRAVITY){
		with (_id.gravity_data){
			var _gravity = 2*jump.max_height/power(jump.duration, 2)
			
			var _offset_to_jump = abs(allowed_angle_range_to.jump)
			var _offset_to_bonk = abs(allowed_angle_range_to.bonk)
			var _base_angle_to_jump = 90 + 90*direction
			var _base_angle_to_bonk = 270 + 90*direction
			
			switch (direction){
				case GRAVITY_SOUL.DOWN: case GRAVITY_SOUL.UP:{
					if (abs(angle_difference(_push_direction, _base_angle_to_jump)) <= _offset_to_jump){
						if (orange_mode or (get_up_button() and direction == GRAVITY_SOUL.DOWN) or (get_down_button() and direction == GRAVITY_SOUL.UP)){
							jump.speed = _gravity*jump.duration
						}else{
							jump.speed = -1.5
						}
						
						_id.conveyor_push.x /= 1.1
						_id.conveyor_push.y /= 1.1
						
						if (abs(_id.conveyor_push.x) <= 0.1){
							_id.conveyor_push.x = 0
						}
						if (abs(_id.conveyor_push.y) <= 0.1){
							_id.conveyor_push.y = 0
						}
					
						if (slam){
							audio_play_sound(snd_player_slam, 0, false)
							
							slam = false
						}
					}else if (abs(angle_difference(_push_direction, _base_angle_to_bonk)) <= _offset_to_bonk){
						if (orange_mode){
							var _move_y = (direction - 1)*(jump.speed - _gravity/2)
							var _speed = point_distance(0, 0, movement.speed, _move_y)
							var _speed_angle = point_direction(0, 0, movement.speed, _move_y)
							var _reflected_angle = _push_direction - angle_difference(_push_direction, _speed_angle)
						
							jump.speed = _speed*dsin(_reflected_angle)/(direction - 1) + _gravity/2
							movement.speed = clamp(_speed*dcos(_reflected_angle), -_id.movement_speed, _id.movement_speed)
						}else{
							jump.speed = min(jump.speed*abs(angle_difference(_push_direction, _base_angle_to_bonk))/90, jump.speed)
						}
					}else{ //Walls
						_id.extra_horizontal_movement.multiplier *= -1
						movement.speed -= movement.speed*abs(dcos(_push_direction))
						_id.conveyor_push.x -= _id.conveyor_push.x*abs(dcos(_push_direction))
						_id.conveyor_push.y -= _id.conveyor_push.y*abs(dsin(_push_direction))
					}
				break}
				default:{ //GRAVITY_SOUL.RIGHT, GRAVITY_SOUL.LEFT
					if (abs(angle_difference(_push_direction, _base_angle_to_jump)) <= _offset_to_jump){
						if (orange_mode or (get_left_button() and direction == GRAVITY_SOUL.RIGHT) or (get_right_button() and direction == GRAVITY_SOUL.LEFT)){
							jump.speed = _gravity*jump.duration
						}else{
							jump.speed = -1.5
						}
						
						_id.conveyor_push.x /= 1.1
						_id.conveyor_push.y /= 1.1
						
						if (abs(_id.conveyor_push.x) <= 0.1){
							_id.conveyor_push.x = 0
						}
						if (abs(_id.conveyor_push.y) <= 0.1){
							_id.conveyor_push.y = 0
						}
					
						if (slam){
							audio_play_sound(snd_player_slam, 0, false)
							
							slam = false
						}
					}else if (abs(angle_difference(_push_direction, _base_angle_to_bonk)) <= _offset_to_bonk){
						if (orange_mode){
							var _move_y = (direction - 1)*(jump.speed - _gravity/2)
							var _speed = point_distance(0, 0, movement.speed, _move_y)
							var _speed_angle = point_direction(0, 0, movement.speed, _move_y)
							var _reflected_angle = _push_direction - angle_difference(_push_direction, _speed_angle) - 90
						
							jump.speed = _speed*dsin(_reflected_angle)/(direction - 1) + _gravity/2
							movement.speed = clamp(_speed*dcos(_reflected_angle), -_id.movement_speed, _id.movement_speed)
						}else{
							jump.speed = min(jump.speed*abs(angle_difference(_push_direction, _base_angle_to_bonk))/90, jump.speed)
						}
					}else{ //Walls
						movement.speed -= movement.speed*dcos(_push_direction)
						_id.conveyor_push.x -= _id.conveyor_push.x*abs(dcos(_push_direction))
						_id.conveyor_push.y -= _id.conveyor_push.y*abs(dsin(_push_direction))
					}
				break}
			}
		}
	}
	
	return [true, _grip]
}
