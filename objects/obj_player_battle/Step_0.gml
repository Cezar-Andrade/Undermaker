/// @description Soul modes, menu handling

if (invulnerability_frames > 0){
	invulnerability_frames--
	
	if (obj_game.battle_state != BATTLE_STATE.TURN_END and obj_game.battle_state != BATTLE_STATE.PLAYER_ATTACK and obj_game.battle_state != BATTLE_STATE.PLAYER_DIALOG_RESULT and obj_game.battle_state != BATTLE_STATE.PLAYER_FLEE and obj_game.battle_state != BATTLE_STATE.PLAYER_WON){ //Change it so only flickers only when it's on the player's control and not displaying text or dialog, etc.
		image_alpha = 1 - floor((invulnerability_frames%10)/5)
	}
}

switch (obj_game.battle_state){
	case BATTLE_STATE.END_DODGE_ATTACK:
	case BATTLE_STATE.ENEMY_ATTACK:{
		var _current_movement_speed = (movement_speed/((get_cancel_button()) ? 2 : 1))
		
		switch (mode){
			case SOUL_MODE.NORMAL:{
				x += _current_movement_speed*get_horizontal_button_force()
				y += _current_movement_speed*get_vertical_button_force()
				
				image_blend = c_red
			break}
			case SOUL_MODE.GRAVITY:{
				with (gravity_data){
					switch (direction){
						case GRAVITY_SOUL.DOWN: case GRAVITY_SOUL.UP:{
							if (orange_mode){
								if (movement.direction == 0){
									movement.direction = ((other.xprevious <= other.x) ? 1 : -1)
									movement.speed = _current_movement_speed*get_horizontal_button_force()
									if (!slam){
										jump.speed = (1 - direction)*_current_movement_speed*get_vertical_button_force()
									}
								}
								
								if (get_horizontal_button_force() > 0){
									movement.direction = 1
								}else if (get_horizontal_button_force() < 0){
									movement.direction = -1
								}
								
								var _speed_delta = movement.direction*movement.direction_change.speed/movement.direction_change.time
								var _new_speed = clamp(movement.speed + _speed_delta, -other.movement_speed, other.movement_speed)
								var _time = (_new_speed - movement.speed)/_speed_delta
								other.x += (movement.speed + _new_speed)*_time/2 + (1 - _time)*_new_speed
								movement.speed = _new_speed
							}else{
								other.x += _current_movement_speed*get_horizontal_button_force()
							}
							
							var _gravity = 2*jump.max_height/power(jump.duration, 2)
							
							other.y += (direction - 1)*(jump.speed - _gravity/2)
							
							if (box_bound){
								other.x += obj_box.x - obj_box.xprevious
								other.y -= obj_box.y - obj_box.yprevious
							}
							
							jump.speed -= _gravity
							
							if (other.x <= get_box_left() + 8 or other.x >= get_box_right() - 8){
								movement.speed = 0
							}
							
							var _box_bottom = get_box_bottom() - 8
							var _box_top = get_box_top() + 8
							if ((other.y >= _box_bottom and direction == GRAVITY_SOUL.DOWN) or (other.y <= _box_top and direction == GRAVITY_SOUL.UP)){
								if (orange_mode){
									jump.speed = _gravity*jump.duration
								}else{
									jump.speed = 0
								}
								
								if (slam){
									audio_play_sound(snd_player_slam, 0, false)
									
									slam = false
								}
							}else if ((other.y <= _box_top and direction == GRAVITY_SOUL.DOWN) or (other.y >= _box_bottom and direction == GRAVITY_SOUL.UP)){
								jump.speed = 0
							}
							
							if (orange_mode){
								if (((get_down_button(false) and other.y < _box_bottom and direction == GRAVITY_SOUL.DOWN) or (get_up_button(false) and other.y > _box_top and direction == GRAVITY_SOUL.UP)) and jump.speed > 0){
									jump.speed = 0
								}
							}else{
								if ((get_up_button() and other.y >= _box_bottom and direction == GRAVITY_SOUL.DOWN) or (get_down_button() and other.y <= _box_top and direction == GRAVITY_SOUL.UP)){
									jump.speed = _gravity*jump.duration
								}else if (((!get_up_button() and direction == GRAVITY_SOUL.DOWN) or (!get_down_button() and direction == GRAVITY_SOUL.UP)) and jump.speed > 4*_gravity){
									jump.speed = 4*_gravity
								}
							}
						break}
						default:{ //GRAVITY_SOUL.LEFT, GRAVITY_SOUL.RIGHT
							if (orange_mode){
								if (movement.direction == 0){
									movement.direction = ((other.yprevious <= other.y) ? 1 : -1)
									movement.speed = _current_movement_speed*get_vertical_button_force()
									if (!slam){
										jump.speed = (direction - 2)*_current_movement_speed*get_horizontal_button_force()
									}
								}
								
								if (get_vertical_button_force() > 0){
									movement.direction = 1
								}else if (get_vertical_button_force() < 0){
									movement.direction = -1
								}
								
								var _speed_delta = movement.direction*movement.direction_change.speed/movement.direction_change.time
								var _new_speed = clamp(movement.speed + _speed_delta, -other.movement_speed, other.movement_speed)
								var _time = (_new_speed - movement.speed)/_speed_delta
								other.y += (movement.speed + _new_speed)*_time/2 + (1 - _time)*_new_speed
								movement.speed = _new_speed
							}else{
								other.y += _current_movement_speed*get_vertical_button_force()
							}
							
							var _gravity = 2*jump.max_height/power(jump.duration, 2)
							
							other.x += (direction - 2)*(jump.speed - _gravity/2)
							
							if (box_bound){
								other.x += obj_box.x - obj_box.xprevious
								other.y -= obj_box.y - obj_box.yprevious
							}
							
							jump.speed -= _gravity
							
							if (other.y <= get_box_top() - 8 or other.y >= get_box_bottom() + 8){
								movement.speed = 0
							}
							
							var _box_left = get_box_left() + 8
							var _box_right = get_box_right() - 8
							if ((other.x <= _box_left and direction == GRAVITY_SOUL.LEFT) or (other.x >= _box_right and direction == GRAVITY_SOUL.RIGHT)){
								if (orange_mode){
									jump.speed = _gravity*jump.duration
								}else{
									jump.speed = 0
								}
								
								if (slam){
									audio_play_sound(snd_player_slam, 0, false)
									
									slam = false
								}
							}else if ((other.x >= _box_right and direction == GRAVITY_SOUL.LEFT) or (other.x <= _box_left and direction == GRAVITY_SOUL.RIGHT)){
								jump.speed = 0
							}
							
							if (orange_mode){
								if (((get_left_button(false) and other.x > _box_left and direction == GRAVITY_SOUL.LEFT) or (get_right_button(false) and other.x < _box_right and direction == GRAVITY_SOUL.RIGHT)) and jump.speed > 0){
									jump.speed = 0
								}
							}else{
								if ((get_right_button() and other.x <= _box_left and direction == GRAVITY_SOUL.LEFT) or (get_left_button() and other.x >= _box_right and direction == GRAVITY_SOUL.RIGHT)){
									jump.speed = _gravity*jump.duration
								}else if (((!get_right_button() and direction == GRAVITY_SOUL.LEFT) or (!get_left_button() and direction == GRAVITY_SOUL.RIGHT)) and jump.speed > 4*_gravity){
									jump.speed = 4*_gravity
								}
							}
							
							other.image_angle = 0
						break}
					}
					
					other.image_angle = 90*direction
				}
			break}
			case SOUL_MODE.GRAVITY2:{ //Here for reference for the platforms
				with (gravity_data){
					if (!ignore_first_frame){
						if (jump > -3 and jump < 3){
							jump -= 1
						}else{ if (jump > -10 and jump < -3){
							jump = -10
						}else{ if (jump < -3){
							jump -= 3
						}else{
							jump -= 2
						}}}
					}else{
						ignore_first_frame = false
					}
					switch (direction){
						case GRAVITY_SOUL.DOWN:{
							if (on_platform){
								other.x = platform.x
								other.y = platform.y
							}else{
								if (jump <= 0 and push.val != 0){
									push.count++
									other.x += push.val
									if (push.count > 4){
										push.val -= clamp(push.val, -1, 1)
									}
								}else{
									push.val = 0
									push.count = 0
								}
							}
							if (get_right_button()){
								other.x += 4
							}
							if (get_left_button()){
								other.x -= 4
							}
							if (other.y <= obj_box.y - round(obj_box.height) + 3 + max(offset, 0) and jump > 0){
								jump = 0
							}else{ if (on_platform){
								if (get_up_button()){
									if (!cannot_jump){
										jump = max_jump
									}else{
										other.x += platform.vel.x
										other.y += platform.vel.y
										other.xprevious += platform.vel.x
										if (prev_platform.plat.Type[1] <= 0){
											prev_platform.plat.Type[1] = 1
										}
									}
								}else{
									other.x += platform.vel.x
									other.y += platform.vel.y
									other.xprevious += platform.vel.x
									if (!cannot_stop_jump){
										jump = 0
									}
								}
							}else{ if (other.y >= obj_box.y - 13 + max(offset, 0)){
								if (jump <= -200){
									audio_play_sound(snd_slam, 0, false)
									obj_Encounter.Shake = [5, 5]
								}
								if (get_up_button()){
									jump = max_jump
								}else{
									jump = 0
								}
							}}}
							if (!get_up_button() and jump > 3 and !cannot_stop_jump){
								jump = 2
							}else{ if (cannot_stop_jump and jump <= 2){
								cannot_stop_jump = false
							}}
							other.y -= jump/5
							other.image_angle = 0
						break}
						case GRAVITY_SOUL.LEFT:{
							if (on_platform){
								other.x = platform.x
								other.y = platform.y
							}else{
								if (jump <= 0 and push.val != 0){
									push.count++
									other.y += push.val
									if (push.count > 4){
										push.val -= min(max(push.val, -1), 1)
									}
								}else{
									push.val = 0
									push.count = 0
								}
							}
							if (get_down_button()){
								other.y += 4
							}
							if (get_up_button()){
								other.y -= 4
							}
							if (other.x >= obj_box.x + round(obj_box.width)/2 - 8 + min(offset, 0) and jump > 0){
								jump = 0
							}else{ if (on_platform){
								if (get_right_button()){
									if (!cannot_jump){
										jump = max_jump
									}else{
										other.x += platform.vel.x
										other.y += platform.vel.y
										other.yprevious += platform.vel.y
										if (prev_platform.plat.Type[1] <= 0){
											prev_platform.plat.Type[1] = 1
										}
									}
								}else{
									other.x += platform.vel.x
									other.y += platform.vel.y
									other.yprevious += platform.vel.y
									if (!cannot_stop_jump){
										jump = 0
									}
								}
							}else{ if (other.x <= obj_box.x - round(obj_box.width)/2 + 8 + min(offset, 0)){
								if (jump <= -200){
									audio_play_sound(snd_slam, 0, false)
									obj_Encounter.Shake = [5, 5]
								}
								if (get_right_button()){
									jump = max_jump
								}else{
									jump = 0
								}
							}}}
							if (!get_right_button() and jump > 3 and !cannot_stop_jump){
								jump = 2
							}else{ if (cannot_stop_jump and jump <= 2){
								cannot_stop_jump = false
							}}
							other.x += jump/5
							other.image_angle = 270
						break}
						case GRAVITY_SOUL.UP:{
							if (on_platform){
								other.x = platform.x
								other.y = platform.y
							}else{
								if (jump <= 0 and push.val != 0){
									push.count++
									other.x += push.val
									if (push.count > 4){
										push.val -= min(max(push.val, -1), 1)
									}
								}else{
									push.val = 0
									push.count = 0
								}
							}
							if (get_right_button()){
								other.x += 4
							}
							if (get_left_button()){
								other.x -= 4
							}
							if (other.y >= obj_box.y - 13 + min(offset, 0) and jump > 0){
								jump = 0
							}else{ if (on_platform){
								if (get_down_button()){
									if (!cannot_jump){
										jump = max_jump
									}else{
										other.x += platform.vel.x
										other.y += platform.vel.y
										other.xprevious += platform.vel.x
										if (prev_platform.plat.Type[1] <= 0){
											prev_platform.plat.Type[1] = 1
										}
									}
								}else{
									other.x += platform.vel.x
									other.y += platform.vel.y
									other.xprevious += platform.vel.x
									if (!cannot_stop_jump){
										jump = 0
									}
								}
							}else{ if (other.y <= obj_box.y - round(obj_box.height) + 3 + min(offset, 0)){
								if (jump <= -200){
									audio_play_sound(snd_slam, 0, false)
									obj_Encounter.Shake = [5, 5]
								}
								if (get_down_button()){
									jump = max_jump
								}else{
									jump = 0
								}
							}}}
							if (!get_down_button() and jump > 3 and !cannot_stop_jump){
								jump = 2
							}else{ if (cannot_stop_jump and jump <= 2){
								cannot_stop_jump = false
							}}
							other.y += jump/5
							other.image_angle = 180
						break}
						case GRAVITY_SOUL.RIGHT:{
							if (on_platform){
								other.x = platform.x
								other.y = platform.y
							}else{
								if (jump <= 0 and push.val != 0){
									push.count++
									other.y += push.val
									other.yprevious += push.val
									if (push.count > 4){
										push.val -= min(max(push.val, -1), 1)
									}
								}else{
									push.val = 0
									push.count = 0
								}
							}
							if (get_down_button()){
								other.y += 4
							}
							if (get_up_button()){
								other.y -= 4
							}
							if (other.x <= obj_box.x - round(obj_box.width)/2 + 8 + max(offset, 0) and jump > 0){
								jump = 0
							}else{ if (on_platform){
								if (get_left_button()){
									if (!cannot_jump){
										jump = max_jump
									}else{
										other.x += platform.vel.x
										other.y += platform.vel.y
										other.yprevious += platform.vel.y
										if (prev_platform.plat.Type[1] <= 0){
											prev_platform.plat.Type[1] = 1
										}
									}
								}else{
									other.x += platform.vel.x
									other.y += platform.vel.y
									if (!cannot_stop_jump){
										jump = 0
									}
								}
							}else{ if (other.x >= obj_box.x + round(obj_box.width)/2 - 8 + max(offset, 0)){
								if (jump <= -200){
									audio_play_sound(snd_slam, 0, false)
									obj_Encounter.Shake = [5, 5]
								}
								if (get_left_button()){
									jump = max_jump
								}else{
									jump = 0
								}
							}}}
							if (!get_left_button() and jump > 3 and !cannot_stop_jump){
								jump = 2
							}else{ if (cannot_stop_jump and jump <= 0){
								cannot_stop_jump = false
							}}
							other.x -= jump/5
							other.image_angle = 90
						break}
					}
					cannot_jump = false
					on_platform = false
					if (prev_platform.found and prev_platform.plat.image_alpha >= 0.5 and (!other.place_meeting(other.x - prev_platform.plat.hspeed, other.y - prev_platform.plat.vspeed, prev_platform.plat) or (prev_platform.plat.Fragile[0] > 0 and prev_platform.plat.Fragile[2] != 0))){
						if (prev_platform.plat.Type[0] == "Sticky"){
							prev_platform.plat.Type[1] = 0
						}
						prev_platform.found = false
						prev_platform.plat = undefined
					}
					other.x = min(max(other.x, obj_box.x - round(obj_box.width)/2 + 8), obj_box.x + round(obj_box.width)/2 - 8)
					other.y = min(max(other.y, obj_box.y - round(obj_box.height) + 3), obj_box.y - 13)
					if (!prev_platform.found and jump <= 0){
						with (obj_platform){
							if (image_alpha >= 0.5 and (Fragile[0] <= 0 or Fragile[2] == 0) and other.other.image_angle == image_angle){
								if (image_angle == 0 and other.other.y <= y - 8 - other.other.jump/5 + vspeed and other.other.x > x - Length/2 - 4 and other.other.x < x + Length/2 + 4){
									other.other.y = min(other.other.y, y - 8 + vspeed)
								}else{ if (image_angle == 90 and other.other.x <= x - 8 - other.other.jump/5 + hspeed and other.other.y > y - Length/2 - 4 and other.other.y < y + Length/2 + 4){
									other.other.x = min(other.other.x, x - 8 + hspeed)
								}else{ if (image_angle == 180 and other.other.y >= y + 8 + other.other.jump/5 + vspeed and other.other.x > x - Length/2 - 4 and other.other.x < x + Length/2 + 4){
									other.other.y = max(other.other.y, y + 8 + vspeed)
								}else{ if (image_angle == 270 and other.other.x >= x + 8 + other.other.jump/5 + hspeed and other.other.y > y - Length/2 - 4 and other.other.y < y + Length/2 + 4){
									other.other.x = max(other.other.x, x + 8 + hspeed)
								}}}}
							}
						}
					}
					offset = 0
				}
			break}
		}
		
		if (instance_exists(obj_box)){ ////PROBABLY CHANGE THE WAY THIS IS DONE
			x = clamp(x, get_box_left() + 8, get_box_right() - 8)
			y = clamp(y, get_box_top() + 8, get_box_bottom() - 8)
		}
		
		if (is_player_moving() and image_alpha == 1){
			var _trail = layer_sprite_create(layer_trail, x, y, sprite_index)
			layer_sprite_speed(_trail, 0)
			layer_sprite_blend(_trail, make_colour_hsv(colour_get_hue(image_blend), colour_get_saturation(image_blend), 91.8))
			array_push(trail_sprites, _trail)
		}
		
		var _length = array_length(trail_sprites)
		for (var _i = _length - 1; _i >= 0; _i--){
			var _sprite = trail_sprites[_i]
			var _scale = layer_sprite_get_xscale(_sprite)
			
			layer_sprite_xscale(_sprite, _scale - 1/16)
			layer_sprite_yscale(_sprite, _scale - 1/16)
			layer_sprite_alpha(_sprite, _scale - 1/16)
			
			if (_scale <= 0){
				layer_sprite_destroy(_sprite)
				array_delete(trail_sprites, _i, 1)
			}
		}
	break}
	default:{
		var _length = array_length(trail_sprites)
		if (_length > 0){
			for (var _i = _length - 1; _i >= 0; _i--){
				layer_sprite_destroy(trail_sprites[_i])
				array_delete(trail_sprites, _i, 1)
			}
		}
	break}
}
