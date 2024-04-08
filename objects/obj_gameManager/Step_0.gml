//Fullscreen toggle
if (keyboard_check_pressed(vk_f4) && !keyboard_check(vk_alt)){
	var new_fullscreen_state = !window_get_fullscreen();
	window_set_fullscreen(new_fullscreen_state);
	if (new_fullscreen_state){
		display_set_gui_size(display_get_width(), display_get_height());
	}else{
		display_set_gui_size(640, 480);
	}
}