/// @description Platform drawing with lines

var _ang_cos = dcos(image_angle)
var _ang_sin = dsin(image_angle)
var _height_offset = 0
var _respawn = fragile.respawn

draw_set_alpha(image_alpha)

if (type == PLATFORM_TYPE.TRAMPOLINE and anim_timer > 0){
	//Trampoline animation
	_height_offset = (2 - floor(2/10*anim_timer))*sin(540/10*anim_timer)
}

var _x1 = x - (length/2 - 0.5)*_ang_cos - (_height_offset - 0.5)*_ang_sin - 1
var _y1 = y - (_height_offset - 0.5)*_ang_cos + (length/2 - 0.5)*_ang_sin - 1
var _x2 = x + (length/2 - 0.5)*_ang_cos - (_height_offset - 0.5)*_ang_sin - 1
var _y2 = y - (_height_offset - 0.5)*_ang_cos - (length/2 - 0.5)*_ang_sin - 1

if (fragile.duration_time <= 0){
	var _x3 = x + (length/2 - 0.5)*_ang_cos + (7.5 + _height_offset)*_ang_sin - 1
	var _y3 = y + (7.5 + _height_offset)*_ang_cos - (length/2 - 0.5)*_ang_sin - 1
	var _x4 = x - (length/2 - 0.5)*_ang_cos + (7.5 + _height_offset)*_ang_sin - 1
	var _y4 = y + (7.5 + _height_offset)*_ang_cos + (length/2 - 0.5)*_ang_sin - 1
	
	draw_line(_x1, _y1, _x2, _y2)
	draw_line(_x2, _y2, _x3, _y3)
	draw_line(_x3, _y3, _x4, _y4)
	draw_line(_x4, _y4, _x1, _y1)
	
	if (type == PLATFORM_TYPE.CONVEYOR){
		anim_timer += conveyor_speed
		if (anim_timer < 0){
			anim_timer += 16
		}else{
			anim_timer %= 16
		}
		if (!surface_exists(surface)){
			surface = surface_create(length - 2, 6)
		}else if (surface_get_width(surface) != length - 2){
			surface_resize(surface, length - 2, 6)
		}
		surface_set_target(surface)
		draw_clear_alpha(c_black, 0)
		var _dir = sign(conveyor_speed)
		var _strength = round(abs(conveyor_speed))
		for (var _i = -16 + anim_timer; _i < length+16; _i+=16){
			if (abs(conveyor_speed) < 1){
				draw_sprite_ext(spr_pixel, 0, round(_i) - 1, 0, 2, 6, 0, c_white, 1)
			}else{
				draw_sprite_ext(spr_platform_arrow, 0, round(_i), 3, _dir*(2 + _strength)/3, 1, 0, c_white, 1)
			}
		}
		surface_reset_target()
		draw_surface_ext(surface, x - (length - 2)*_ang_cos/2 + _ang_sin, y + _ang_cos + (length - 2)*_ang_sin/2, 1, 1, image_angle, c_white, draw_get_alpha())
		var _color = make_color_rgb(255/4, 255/4, 255/4)
		for (var _i=anim_timer - 2; _i<14 + 2*length; _i+=8){
			for (var _j=_i - 2; _j<_i + 2; _j++){
				if (_j < 0){
					continue
				}else if (_j < length - 1){
					draw_point_color(_x1 + _j*_ang_cos, _y1 - _j*_ang_sin, _color)
				}else{
					break
				}
			}
		}
	}
	_x1 = x - (length/2 - 0.5)*_ang_cos - (4.5 - _height_offset)*_ang_sin - 1
	_y1 = y - (4.5 - _height_offset)*_ang_cos + (length/2 - 0.5)*_ang_sin - 1
	_x2 = x + (length/2 - 0.5)*_ang_cos - (4.5 - _height_offset)*_ang_sin - 1
	_y2 = y - (4.5 - _height_offset)*_ang_cos - (length/2 - 0.5)*_ang_sin - 1
	_x3 = x + (length/2 - 0.5)*_ang_cos + (3.5 + _height_offset)*_ang_sin - 1
	_y3 = y + (3.5 + _height_offset)*_ang_cos - (length/2 - 0.5)*_ang_sin - 1
	_x4 = x - (length/2 - 0.5)*_ang_cos + (3.5 + _height_offset)*_ang_sin - 1
	_y4 = y + (3.5 + _height_offset)*_ang_cos + (length/2 - 0.5)*_ang_sin - 1
	
	draw_line_colour(_x1, _y1, _x2, _y2, image_blend, image_blend)
	draw_line_colour(_x2, _y2, _x3, _y3, image_blend, image_blend)
	draw_line_colour(_x3, _y3, _x4, _y4, image_blend, image_blend)
	draw_line_colour(_x4, _y4, _x1, _y1, image_blend, image_blend)
}else{
	var shake = [_height_offset*_ang_sin, _height_offset*_ang_cos]
	switch (fragile.state){
		case 0:{
			if (fragile.timer > 0){
				shake[0] = irandom_range(-1, 1) + _height_offset*_ang_sin
				shake[1] = irandom_range(-1, 1) + _height_offset*_ang_cos
			}
		break}
		case 1:{
			if (fragile.timer < 10){
				shake[0] = (10*sin(degtorad(90/10*fragile.timer)) + _height_offset)*_ang_sin
				shake[1] = (10*sin(degtorad(90/10*fragile.timer)) + _height_offset)*_ang_cos
			}
			draw_set_alpha((2 - sin(degtorad(90/10*min(fragile.timer, 10))) - cos(degtorad(90/10*max(_respawn*fragile.timer - fragile.respawn_time + 10, 0))))*image_alpha)
		break}
	}
	
	if (type == PLATFORM_TYPE.CONVEYOR){
		anim_timer += conveyor_speed
		if (anim_timer < 0){
			anim_timer += 16
		}else{
			anim_timer %= 16
		}
		if (!surface_exists(surface)){
			surface = surface_create(length - 2, 6)
		}else if (surface_get_width(surface) != length - 2){
			surface_resize(surface, length - 2, 6)
		}
		surface_set_target(surface)
		draw_clear_alpha(c_black, 0)
		var _dir = sign(conveyor_speed)
		var _strength = round(abs(conveyor_speed))
		for (var _i=-16+anim_timer; _i<length+16; _i+=16){
			if (abs(conveyor_speed) < 1){
				draw_sprite_ext(spr_pixel, 0, round(_i) - 1, 0, 2, 6, 0, c_white, 1)
			}else{
				draw_sprite_ext(spr_platform_arrow, 0, round(_i), 3, _dir*(2 + _strength)/3, 1, 0, c_white, 1)
			}
		}
		surface_reset_target()
		draw_surface_ext(surface, x - (length - 2)*_ang_cos/2 + _ang_sin + shake[0], y + _ang_cos + (length - 2)*_ang_sin/2 + shake[1], 1, 1, image_angle, c_white, draw_get_alpha())
	}
	
	if (draw_get_alpha() > 0){
		draw_line(_x1 + shake[0], _y1 + shake[1], _x2 + shake[0], _y2 + shake[1])
		
		for (var i=((type == PLATFORM_TYPE.CONVEYOR) ? anim_timer%8 - 3 : ((type == PLATFORM_TYPE.STICKY) ? length : 0));i<14+2*length;i+=8){
			for (var j=i-2;j<i+3;j++){
				if (j < 0){
					continue
				}else if (j < length - 1){
					draw_point_colour(x + (-length/2 + 0.5 + j)*_ang_cos + 0.5*_ang_sin - 0.5 + shake[0], y + 0.5*_ang_cos - (-length/2 + j + 0.5)*_ang_sin - 0.5 + shake[1], c_white)
				}else if (j < length + 6){
					draw_point_colour(x + (length/2 - 0.5)*_ang_cos + (j - length + 1.5)*_ang_sin - 1 + shake[0], y + (j - length + 1.5)*_ang_cos - (length/2 - 0.5)*_ang_sin - 0.5 + shake[1], c_white)
				}else if (j < 2*length + 5){
					draw_point_colour(x + (3*length/2 + 5.5 - j)*_ang_cos + 7.5*_ang_sin - 0.5 + shake[0], y + 7.5*_ang_cos - (3*length/2 + 5.5 - j)*_ang_sin - 1 + shake[1], c_white)
				}else if (j < 12 + 2*length){
					draw_point_colour(x + (-length/2 + 0.5)*_ang_cos + (12.5 - j + 2*length)*_ang_sin - 0.5 + shake[0], y + (12.5 - j + 2*length)*_ang_cos + (length/2 - 0.5)*_ang_sin - 0.5 + shake[1], c_white)
				}else{
					break
				}
			}
		}
	}
	
	if (_respawn){
		shake[0] = 0
		shake[1] = 0
		draw_set_alpha(image_alpha)
	}
	
	_x1 = x - (length/2 - 0.5)*_ang_cos - 4.5*_ang_sin + shake[0] - 1
	_y1 = y - 4.5*_ang_cos + (length/2 - 0.5)*_ang_sin + shake[1] - 1
	_x2 = x + (length/2 - 0.5)*_ang_cos - 4.5*_ang_sin + shake[0] - 1
	_y2 = y - 4.5*_ang_cos - (length/2 - 0.5)*_ang_sin + shake[1] - 1
	var _x3 = x + (length/2 - 0.5)*_ang_cos + 3.5*_ang_sin + shake[0] - 1
	var _y3 = y + 3.5*_ang_cos - (length/2 - 0.5)*_ang_sin + shake[1] - 1
	var _x4 = x - (length/2 - 0.5)*_ang_cos + 3.5*_ang_sin + shake[0] - 1
	var _y4 = y + 3.5*_ang_cos + (length/2 - 0.5)*_ang_sin + shake[1] - 1
	
	draw_line_colour(_x1, _y1, _x2, _y2, image_blend, image_blend)
	draw_line_colour(_x2, _y2, _x3, _y3, image_blend, image_blend)
	draw_line_colour(_x3, _y3, _x4, _y4, image_blend, image_blend)
	draw_line_colour(_x4, _y4, _x1, _y1, image_blend, image_blend)
	
	switch (fragile.state){
		case 0:{
			if (fragile.timer > 0){
				fragile.timer++
				
				if (fragile.timer == fragile.duration_time + 1){
					audio_play_sound(snd_platform_falls, 0, false)
					
					fragile.state++
					fragile.timer = 1
				}
			}
		break}
		case 1:{
			draw_set_alpha(image_alpha)
			
			if (fragile.timer > 0){
				fragile.timer++
				
				if (fragile.timer == fragile.respawn_time + 1){
					if (_respawn){
						fragile.state--
						fragile.timer = 0
					}
				}
			}
		break}
	}
}

if (type == PLATFORM_TYPE.TRAMPOLINE and anim_timer > 0){
	draw_set_alpha((1 - 1/10*anim_timer)*image_alpha)
	
	var _anim_diff = 4*dsin(18*min(anim_timer, 5))
	_x1 = x - (_anim_diff + length/2 - 0.5)*_ang_cos - (4.5 + _anim_diff)*_ang_sin - 1
	_y1 = y - (4.5 + _anim_diff)*_ang_cos + (_anim_diff + length/2 - 0.5)*_ang_sin - 1
	_x2 = x + (_anim_diff + length/2 - 0.5)*_ang_cos - (4.5 + _anim_diff)*_ang_sin - 1
	_y2 = y - (4.5 + _anim_diff)*_ang_cos - (_anim_diff + length/2 - 0.5)*_ang_sin - 1
	var _x3 = x + (_anim_diff + length/2 - 0.5)*_ang_cos + (3.5 + _anim_diff)*_ang_sin - 1
	var _y3 = y + (3.5 + _anim_diff)*_ang_cos - (_anim_diff + length/2 - 0.5)*_ang_sin - 1
	var _x4 = x - (_anim_diff + length/2 - 0.5)*_ang_cos + (3.5 + _anim_diff)*_ang_sin - 1
	var _y4 = y + (3.5 + _anim_diff)*_ang_cos + (_anim_diff + length/2 - 0.5)*_ang_sin - 1
	
	draw_line_colour(_x1, _y1, _x2, _y2, image_blend, image_blend)
	draw_line_colour(_x2, _y2, _x3, _y3, image_blend, image_blend)
	draw_line_colour(_x3, _y3, _x4, _y4, image_blend, image_blend)
	draw_line_colour(_x4, _y4, _x1, _y1, image_blend, image_blend)
	
	_x1 = x - (_anim_diff + length/2 - 0.5)*_ang_cos - (0.5 + _anim_diff)*_ang_sin - 1
	_y1 = y - (0.5 + _anim_diff)*_ang_cos + (_anim_diff + length/2 - 0.5)*_ang_sin - 1
	_x2 = x + (_anim_diff + length/2 - 0.5)*_ang_cos - (0.5 + _anim_diff)*_ang_sin - 1
	_y2 = y - (0.5 + _anim_diff)*_ang_cos - (_anim_diff + length/2 - 0.5)*_ang_sin - 1
	_x3 = x + (_anim_diff + length/2 - 0.5)*_ang_cos + (7.5 + _anim_diff)*_ang_sin - 1
	_y3 = y + (7.5 + _anim_diff)*_ang_cos - (_anim_diff + length/2 - 0.5)*_ang_sin - 1
	_x4 = x - (_anim_diff + length/2 - 0.5)*_ang_cos + (7.5 + _anim_diff)*_ang_sin - 1
	_y4 = y + (7.5 + _anim_diff)*_ang_cos + (_anim_diff + length/2 - 0.5)*_ang_sin - 1
	
	draw_line(_x1, _y1, _x2, _y2)
	draw_line(_x2, _y2, _x3, _y3)
	draw_line(_x3, _y3, _x4, _y4)
	draw_line(_x4, _y4, _x1, _y1)
	
	draw_set_alpha(image_alpha)
	
	anim_timer++
	if (anim_timer == 2){
		audio_play_sound(snd_trampoline_platform, 0, false)
	}else if (anim_timer >= 11){
		anim_timer = 0
	}
}

draw_set_alpha(1)