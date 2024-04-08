//Drawing the game with and without border when fullscreen and when not
if (window_get_fullscreen()){
	draw_sprite(spr_border, border_id, 0, 0);
	draw_surface_ext(application_surface, 320, 60, 2, 2, 0, c_white, 1);
}else{
	draw_surface(application_surface, 0, 0);
}