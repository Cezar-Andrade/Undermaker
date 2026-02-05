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

//GENERAL FUNCTIONS - PLAYER

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

function is_player_moving(_player=obj_player_battle){
	return _player.x != _player.xprevious or _player.y != _player.yprevious
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

// CORE FUNCTIONS - PLAYER OVERWORLD

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
			y -= movement_speed*get_up_button()
			while (image_index >= 3*animation_frames){
				image_index -= animation_frames
			}
			while (image_index < 2*animation_frames){
				image_index += animation_frames
			}
		}else if (get_down_button()){
			y += movement_speed*get_down_button()
			while (image_index >= animation_frames){
				image_index -= animation_frames
			}
		}
		
		//Left and right movements, priority on right button, so you can only moon walk to the right, if you want it for both sides, do it differently than this.
		if (get_right_button()){
			x += movement_speed*get_right_button()
			if (!get_left_button() or !moon_walk){
				while (image_index >= 2*animation_frames){
					image_index -= animation_frames
				}
				while (image_index < animation_frames){
					image_index += animation_frames
				}
			}
		}else if (get_left_button()){
			x -= movement_speed*get_left_button()
			while (image_index < 3*animation_frames){
				image_index += animation_frames
			}
			while (image_index >= 4*animation_frames){
				image_index -= animation_frames
			}
		}
	}
}
