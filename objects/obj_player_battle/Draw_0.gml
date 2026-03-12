/// @description Player drawing and animating

//Sticky animation drawing
if (sticky_animation.timer > 0){
	var _animation_frame
	with (sticky_animation){
		_animation_frame = dsin(180*timer/10) //Frame of the animation
		other.animation_offset_x = distance*dcos(direction)*_animation_frame
		other.animation_offset_y = distance*dsin(direction)*_animation_frame
		
		//Counters for the animation and keeping the animation as long as the player is moving away from the sticky platform after it has collided with it
		if (timer < 5 or !keep_animation){
			timer++
		}else if (timer > 5){
			timer--
		}
		
		if (timer == 2){
			audio_play_sound(snd_sticky_platform, 0, false)
		}else if (timer == 11){
			timer = 0
		}
		
		keep_animation = false
	}
	
	//Calculate sprite offsets for the animation (different from collision updates)
	calculate_object_sprite_size_offset()
	
	//Get direction and offset of the sticked white web from the player, data is provided by the platform for the direction
	var _direction = sticky_animation.direction
	var _horizontal_axis = ((dsin(_direction) >= 0) ? sprite_right_offset : sprite_left_offset)
	var _vertical_axis = ((dcos(_direction) >= 0) ? sprite_bottom_offset : sprite_top_offset)
	var _offset = _horizontal_axis*_vertical_axis/sqrt(power(_vertical_axis*dcos(_direction), 2) + power(_horizontal_axis*dsin(_direction), 2)) + 1
	
	//Use tangent since the collision is a square, and distances are not circular, but square like if that makes sense
	var _tan_x = clamp((dcos(_direction) >= 0) ? abs(dtan(_direction + 90)) : -abs(dtan(_direction + 90)), -1, 1)
	var _tan_y = clamp((dsin(_direction) >= 0) ? -abs(dtan(_direction)) : abs(dtan(_direction)), -1, 1)
	
	//Apply offset from the player's position
	var _p1_x = x - _offset*_tan_x + min(dcos(_direction), 0) - 0.5
	var _p1_y = y - _offset*_tan_y + min(dsin(_direction), 0) - 0.5
	
	//Draw the sticky web line
	draw_line_width(_p1_x, _p1_y, _p1_x + animation_offset_x + _offset*_tan_x*_animation_frame, _p1_y - animation_offset_y + _offset*_tan_y*_animation_frame, 4)
	//Offset the player to make it look like it's trying to move away, this doesn't affect collision really
	draw_sprite_ext(sprite_index, image_index, x + animation_offset_x, y - animation_offset_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
//If no sticky animation, then draw yourself only
}else{
	draw_self()
}