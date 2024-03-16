//Fullscreen toggle
if (keyboard_check_pressed(vk_f4)){
	var newFullscreenState = !window_get_fullscreen();
	window_set_fullscreen(newFullscreenState);
	if (newFullscreenState){
		display_set_gui_size(1920, 1080);
	}else{
		display_set_gui_size(640, 480);
	}
}