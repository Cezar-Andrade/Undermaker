var _screen_height = resolutions_height[resolution_active];
var _game_width = _screen_height*(4/3);

if (with_border){
	if (window_get_fullscreen()){
		var _screen_width = resolutions_width[resolution_active];
		var _game_height = _screen_height/1.125;
		var _border_width = _screen_height*(16/9);
		
		_game_width /= 1.125;
		
		draw_sprite_ext(spr_border, border_id, (_screen_width - _border_width)/2, 0, _border_width/1920, _screen_height/1080, 0, c_white, 1);
		draw_surface_ext(application_surface, (_screen_width - _game_width)/2, _screen_height*0.0625/1.125, _game_width/GAME_WIDTH, _game_height/GAME_HEIGHT, 0, c_white, 1);
	}else{
		draw_sprite_ext(spr_border, border_id, 0, 0, _screen_height*(16/9)*1.125/1920, _screen_height*1.125/1080, 0, c_white, 1);
		draw_surface_ext(application_surface, (1.5*resolutions_width[resolution_active] - _game_width)/2, _screen_height*0.0625, _game_width/GAME_WIDTH, _screen_height/GAME_HEIGHT, 0, c_white, 1);
	}
}else{
	draw_surface_ext(application_surface, (resolutions_width[resolution_active] - _game_width)/2, 0, _game_width/GAME_WIDTH, _screen_height/GAME_HEIGHT, 0, c_white, 1);
}