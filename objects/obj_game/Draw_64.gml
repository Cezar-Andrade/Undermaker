var _screen_height = resolutions_height[resolution_active];
var _game_width = _screen_height*(4/3);
var _dialog_not_finished = !dialog.is_finished();

if (_dialog_not_finished){
	if (!surface_exists(dialog_surface)){
		dialog_surface = surface_create(GAME_WIDTH, GAME_HEIGHT);
	}
	surface_set_target(dialog_surface);
	
	draw_clear_alpha(c_black, 0);

	dialog.draw();
	
	if (state == GAME_STATE.DIALOG_CHOICE){
		for (var _i = 1; _i < 5; _i++){
			if (!is_undefined(options[_i])){
				options[_i][4].draw();
			}
		}
		
		draw_sprite_ext(choice_sprite, choice_index, options[selection][0], options[selection][1], 1, 1, 0, choice_color, 1);
	}

	surface_reset_target();
}

if (with_border){
	if (window_get_fullscreen()){
		var _screen_width = resolutions_width[resolution_active];
		var _game_height = _screen_height/1.125;
		var _border_width = _screen_height*(16/9);
		var _x = (_screen_width - _game_width)/2;
		var _y = _screen_height*0.0625/1.125;
		
		_game_width /= 1.125;
		
		var _x_scale = _game_width/GAME_WIDTH;
		var _y_scale = _game_height/GAME_HEIGHT;
		
		draw_sprite_ext(spr_border, border_id, (_screen_width - _border_width)/2, 0, _border_width/1920, _screen_height/1080, 0, c_white, 1);
		draw_surface_ext(application_surface, _x, _y, _x_scale, _y_scale, 0, c_white, 1);
		
		if (_dialog_not_finished){
			draw_surface_ext(dialog_surface, _x, _y, _x_scale, _y_scale, 0, c_white, 1);
		}
		
		if (state == GAME_STATE.ROOM_CHANGE){
			draw_sprite_ext(spr_pixel, 0, _x, _y, _game_width, _game_height, 0, c_black, (min(room_change_timer, room_change_fade_in_time) - max(room_change_timer - room_change_wait_time, 0))/20);
		}
	}else{
		var _x = (1.5*resolutions_width[resolution_active] - _game_width)/2;
		var _y = _screen_height*0.0625;
		var _x_scale = _game_width/GAME_WIDTH;
		var _y_scale = _screen_height/GAME_HEIGHT;
		
		draw_sprite_ext(spr_border, border_id, 0, 0, _screen_height*(16/9)*1.125/1920, _screen_height*1.125/1080, 0, c_white, 1);
		draw_surface_ext(application_surface, _x, _y, _x_scale, _y_scale, 0, c_white, 1);
		
		if (_dialog_not_finished){
			draw_surface_ext(dialog_surface, _x, _y, _x_scale, _y_scale, 0, c_white, 1);
		}
		
		if (state == GAME_STATE.ROOM_CHANGE){
			draw_sprite_ext(spr_pixel, 0, _x, _y, _game_width, _screen_height, 0, c_black, (min(room_change_timer, room_change_fade_in_time) - max(room_change_timer - room_change_wait_time, 0))/20);
		}
	}
}else{
	var _x = (resolutions_width[resolution_active] - _game_width)/2;
	var _x_scale = _game_width/GAME_WIDTH;
	var _y_scale = _screen_height/GAME_HEIGHT;
	
	draw_surface_ext(application_surface, _x, 0, _x_scale, _y_scale, 0, c_white, 1);
	
	if (_dialog_not_finished){
		draw_surface_ext(dialog_surface, _x, 0, _x_scale, _y_scale, 0, c_white, 1);
	}
	
	if (state == GAME_STATE.ROOM_CHANGE){
		draw_sprite_ext(spr_pixel, 0, _x, 0, _game_width, _screen_height, 0, c_black, (min(room_change_timer, room_change_fade_in_time) - max(room_change_timer - room_change_wait_time, 0))/20);
	}
}

if (!_dialog_not_finished and surface_exists(dialog_surface)){
	surface_free(dialog_surface);
	dialog_surface = -1;
}