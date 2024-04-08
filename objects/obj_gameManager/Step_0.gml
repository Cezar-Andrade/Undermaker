//Fullscreen toggle
if (keyboard_check_pressed(vk_f4) && !keyboard_check(vk_alt)){
	resolution_active = (resolution_active + 1) % array_length(resolutions_width);
	
	var curr_width = resolutions_width[resolution_active];
	var curr_height = resolutions_height[resolution_active];
	var display_width = display_get_width();
	var display_height = display_get_height();
	
	display_set_gui_size(curr_width, curr_height);
	
	// Set to fullscreen if on fullscreen resolution, otherwise, set to windowed
	if (curr_width == display_width && curr_height == display_height) {
		window_set_fullscreen(true);
	} else {
		window_set_fullscreen(false);
		
		// The margin on both sides of the window from the edge of the screen
		// is half the difference between the display size and current size.
		// We use this to center the window.
		window_set_rectangle((display_width - curr_width)/2, (display_height - curr_height)/2, curr_width, curr_height);
	}
}