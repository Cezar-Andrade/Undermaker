

/*
Add proper description later.

1. Loading and saving data
2. Room changing between battle and overworld
*/

/*
This function starts the sequence to assign the controller's button to the confirm, cancel and menu actions of the game.
Only executes if game maekr has no CONTROLLER_MAPPING for the controller when connected from the Async - System event.
You can also run it to remap the controller in a configuration menu too.

INTEGER _index -> Must be the index of the controller that you are trying to map, get it from the Async - System event or use the controller_id variable from this object that gets sets to the first connected controller that is supported by game maker (see that process in the Async - System event of this object).
*/
map_controller = function(_index){
	control_type = CONTROL_TYPE.MAPPING_CONTROLLER;
	controller_id = _index;
	controller_controller_mapping_state = CONTROLLER_MAPPING.WAITING_ENTER;
}

get_controller_button_pressed = function(_index){
	if (gamepad_button_check_pressed(_index, gp_face1)){
		return gp_face1;
	}
	if (gamepad_button_check_pressed(_index, gp_face2)){
		return gp_face2;
	}
	if (gamepad_button_check_pressed(_index, gp_face3)){
		return gp_face3;
	}
	if (gamepad_button_check_pressed(_index, gp_face4)){
		return gp_face4;
	}
	if (gamepad_button_check_pressed(_index, gp_start)){
		return gp_start;
	}
	if (gamepad_button_check_pressed(_index, gp_select)){
		return gp_select;
	}
	if (gamepad_button_check_pressed(_index, gp_home)){
		return gp_home;
	}
	if (gamepad_button_check_pressed(_index, gp_extra1)){
		return gp_extra1;
	}
	if (gamepad_button_check_pressed(_index, gp_extra2)){
		return gp_extra2;
	}
	if (gamepad_button_check_pressed(_index, gp_extra3)){
		return gp_extra3;
	}
	if (gamepad_button_check_pressed(_index, gp_extra4)){
		return gp_extra4;
	}
	if (gamepad_button_check_pressed(_index, gp_extra5)){
		return gp_extra5;
	}
	if (gamepad_button_check_pressed(_index, gp_extra6)){
		return gp_extra6;
	}
	return -1;
}

get_controller_config = function(_index){
	if (file_exists("settings.json")){
		var _data = "";
		var _guid = gamepad_get_guid(_index);
		var _description = gamepad_get_description(_index);
		
		var _file = file_text_open_read("settings.json");
		var _list = json_parse(file_text_read_string(_file));
		file_text_close(_file);
		
		var _length = array_length(_list);
		for (var _i = 0; _i < _length; _i++){
			_data = _list[_i];
			if (_data.guid == _guid and _data.description == _description){
				return _data;
			}
		}
	}
	
	return -1;
}

save_controller_config = function(_index){
	if (!file_exists("settings.json")){
		var _file = file_text_open_write("settings.json");
		file_text_write_string(_file, "[]");
		file_text_close(_file);
	}
	
	var _guid = gamepad_get_guid(_index);
	var _description = gamepad_get_description(_index);
	
	var _file = file_text_open_read("settings.json");
	var _list = json_parse(file_text_read_string(_file));
	file_text_close(_file);
	
	var _length = array_length(_list);
	var _found = false;
	for (var _i = 0; _i < _length; _i++){
		var _data = _list[_i];
		if (_data.guid == _guid and _data.description == _description){
			_data.confirm = controller_confirm_button;
			_data.cancel = controller_cancel_button;
			_data.menu = controller_menu_button;
			_data.deadzone = gamepad_get_axis_deadzone(_index);
			
			_found = true;
			break;
		}
	}
	
	if (!_found){
		array_push(_list, {"guid": _guid, "description": _description, "confirm": controller_confirm_button, "cancel": controller_cancel_button, "menu": controller_menu_button, "deadzone": gamepad_get_axis_deadzone(_index)});
	}
	
	_file = file_text_open_write("settings.json");
	file_text_write_string(_file, json_stringify(_list));
	file_text_close(_file);
}

change_resolution = function(_index){
	resolution_active = _index
	
	var _curr_width = resolutions_width[resolution_active];
	var _curr_height = resolutions_height[resolution_active];
	var _display_width = display_get_width();
	var _display_height = display_get_height();
	
	// Set to fullscreen if on fullscreen resolution, otherwise, set to windowed
	if (array_length(resolutions_width) - 1 == resolution_active){
		display_set_gui_size(_curr_width, _curr_height);
		window_set_fullscreen(true);
	}else{
		if (with_border){
			_curr_width *= 1.5;
			_curr_height *= 1.125;
		}
		
		display_set_gui_size(_curr_width, _curr_height);
		window_set_fullscreen(false);

		// The margin on both sides of the window from the edge of the screen
		// is half the difference between the display size and current size.
		// We use this to center the window.
		window_set_rectangle((_display_width - _curr_width)/2, (_display_height - _curr_height)/2, _curr_width, _curr_height);
	}
}

toggle_border = function(_state){
	with_border = _state;
	
	var _curr_width = resolutions_width[resolution_active];
	var _curr_height = resolutions_height[resolution_active];
	var _display_width = display_get_width();
	var _display_height = display_get_height();
	
	if (window_get_fullscreen()){
		display_set_gui_size(_curr_width, _curr_height);
	}else{
		if (with_border){
			_curr_width *= 1.5;
			_curr_height *= 1.125;
		}
		display_set_gui_size(_curr_width, _curr_height);
		window_set_rectangle((_display_width - _curr_width)/2, (_display_height - _curr_height)/2, _curr_width, _curr_height);
	}
}

state = GAME_STATE.PLAYER_CONTROL; ////REPLACE WHEN ALL IS DONE.
goto_room = undefined;
event_update = undefined;
event_end_condition = undefined;
after_transition_function = undefined;
start_room_function = undefined;
end_room_function = undefined;

options = [undefined, undefined, undefined, undefined, undefined]; //none, left, down, right, up.
choice_sprite = spr_player_heart;
choice_index = 0;
choice_color = c_red;

room_change_timer = 0;
room_change_fade_in_time = 0;
room_change_wait_time = 0;
room_change_fade_out_time = 0;
selection = 0;
dialog_surface = -1;

dialog = new DisplayDialog(0, 0, [], 1);

with_border = false;
border_id = 0; //There's just 1 border as of now, so this won't do anything yet.

control_type = CONTROL_TYPE.KEYBOARD;
controller_id = -1; //-1 means that there's no controller assigned, either not connected or not supported.
controller_controller_mapping_state = -1;
controller_confirm_button = -1;
controller_cancel_button = -1;
controller_menu_button = -1;

application_surface_draw_enable(false);

// Arrays of width and height of available resolutions that are integer multiples of 640 x 480.
resolutions_width = [];
resolutions_height = [];

// enable borderless window fullscreen mode.
window_enable_borderless_fullscreen(true);

var _display_width = display_get_width();
var _display_height = display_get_height();

for (var _i = 1; GAME_WIDTH * _i < _display_width and GAME_HEIGHT * _i < _display_height; _i++) {
    array_push(resolutions_width, GAME_WIDTH * _i);
	array_push(resolutions_height, GAME_HEIGHT * _i);
}

array_push(resolutions_width, _display_width);
array_push(resolutions_height, _display_height)

change_resolution(array_length(resolutions_width) - 2);