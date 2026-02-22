alarm[0] = 1
alarm[1] = 60 //Temporary timer startup, this should be moved to the menu stuff and reset stuff too

/*
This function starts the sequence to assign the controller's button to the confirm, cancel and menu actions of the game.
Only executes if game maekr has no CONTROLLER_MAPPING for the controller when connected from the Async - System event.
You can also run it to remap the controller in a configuration menu too.

INTEGER _index -> Must be the index of the controller that you are trying to map, get it from the Async - System event or use the controller_id variable from this object that gets sets to the first connected controller that is supported by game maker (see that process in the Async - System event of this object).
*/
map_controller = function(_index){
	control_type = CONTROL_TYPE.MAPPING_CONTROLLER
	controller_id = _index
	controller_mapping_state = CONTROLLER_MAPPING.WAITING_ENTER
}

get_controller_button_pressed = function(_index){
	if (gamepad_button_check_pressed(_index, gp_face1)){
		return gp_face1
	}
	if (gamepad_button_check_pressed(_index, gp_face2)){
		return gp_face2
	}
	if (gamepad_button_check_pressed(_index, gp_face3)){
		return gp_face3
	}
	if (gamepad_button_check_pressed(_index, gp_face4)){
		return gp_face4
	}
	if (gamepad_button_check_pressed(_index, gp_start)){
		return gp_start
	}
	if (gamepad_button_check_pressed(_index, gp_select)){
		return gp_select
	}
	if (gamepad_button_check_pressed(_index, gp_home)){
		return gp_home
	}
	if (gamepad_button_check_pressed(_index, gp_extra1)){
		return gp_extra1
	}
	if (gamepad_button_check_pressed(_index, gp_extra2)){
		return gp_extra2
	}
	if (gamepad_button_check_pressed(_index, gp_extra3)){
		return gp_extra3
	}
	if (gamepad_button_check_pressed(_index, gp_extra4)){
		return gp_extra4
	}
	if (gamepad_button_check_pressed(_index, gp_extra5)){
		return gp_extra5
	}
	if (gamepad_button_check_pressed(_index, gp_extra6)){
		return gp_extra6
	}
	return -1
}

get_controller_config = function(_index){
	if (file_exists("controller settings.save")){
		var _data = ""
		var _guid = gamepad_get_guid(_index)
		var _description = gamepad_get_description(_index)
		
		var _file = file_text_open_read("controller settings.save")
		var _list = json_parse(file_text_read_string(_file))
		file_text_close(_file)
		
		var _length = array_length(_list)
		for (var _i = 0; _i < _length; _i++){
			_data = _list[_i]
			if (_data.guid == _guid and _data.description == _description){
				return _data
			}
		}
	}
	
	return -1
}

save_controller_config = function(_index){
	if (!file_exists("controller settings.save")){
		var _file = file_text_open_write("controller settings.save")
		file_text_write_string(_file, "[]")
		file_text_close(_file)
	}
	
	var _guid = gamepad_get_guid(_index)
	var _description = gamepad_get_description(_index)
	
	var _file = file_text_open_read("controller settings.save")
	var _list = json_parse(file_text_read_string(_file))
	file_text_close(_file)
	
	var _length = array_length(_list)
	var _found = false
	for (var _i = 0; _i < _length; _i++){
		var _data = _list[_i]
		if (_data.guid == _guid and _data.description == _description){
			_data.confirm = controller_confirm_button
			_data.cancel = controller_cancel_button
			_data.menu = controller_menu_button
			_data.deadzone = gamepad_get_axis_deadzone(_index)
			
			_found = true
			break
		}
	}
	
	if (!_found){
		array_push(_list, {"guid": _guid, "description": _description, "confirm": controller_confirm_button, "cancel": controller_cancel_button, "menu": controller_menu_button, "deadzone": gamepad_get_axis_deadzone(_index)})
	}
	
	_file = file_text_open_write("controller settings.save")
	file_text_write_string(_file, json_stringify(_list))
	file_text_close(_file)
}

change_resolution = function(_index){
	resolution_active = _index
	
	var _curr_width = resolutions_width[resolution_active]
	var _curr_height = resolutions_height[resolution_active]
	var _display_width = display_get_width()
	var _display_height = display_get_height()
	
	// Set to fullscreen if on fullscreen resolution, otherwise, set to windowed
	if (array_length(resolutions_width) - 1 == resolution_active){
		display_set_gui_size(_curr_width, _curr_height)
		window_set_fullscreen(true)
	}else{
		if (with_border){
			_curr_width *= 1.5
			_curr_height *= 1.125
		}
		
		display_set_gui_size(_curr_width, _curr_height)
		window_set_fullscreen(false)

		// The margin on both sides of the window from the edge of the screen
		// is half the difference between the display size and current size.
		// We use this to center the window.
		window_set_rectangle((_display_width - _curr_width)/2, (_display_height - _curr_height)/2, _curr_width, _curr_height)
	}
}

toggle_border = function(_state){
	with_border = _state
	
	var _curr_width = resolutions_width[resolution_active]
	var _curr_height = resolutions_height[resolution_active]
	var _display_width = display_get_width()
	var _display_height = display_get_height()
	
	if (window_get_fullscreen()){
		display_set_gui_size(_curr_width, _curr_height)
	}else{
		if (with_border){
			_curr_width *= 1.5
			_curr_height *= 1.125
		}
		display_set_gui_size(_curr_width, _curr_height)
		window_set_rectangle((_display_width - _curr_width)/2, (_display_height - _curr_height)/2, _curr_width, _curr_height)
	}
}

state = GAME_STATE.PLAYER_CONTROL ////REPLACE WHEN ALL IS DONE.
battle_start_animation_type = BATTLE_START_ANIMATION.NORMAL
battle_state = BATTLE_STATE.START

battle_start_animation_player_heart_x = 0
battle_start_animation_player_heart_y = 0
battle_black_alpha = 1
battle_button_order = []
battle_selection = [0, 0, 0] //Buttons, enemy/spare/flee selection, act/item selection
battle_can_flee = true
battle_item_page = 1 //For the items in battle
battle_current_box_dialog = ""
battle_player_stats = {x: 30, y: 415, depth: 300}
battle_player_attack = undefined
battle_dialog_x_offset = 0
battle_flee_chance = 100 //In Undertale Hardmode this is 0, normally it's 50 and increases by winning battles, decreases by fleeing battles.
battle_flee_event_type = undefined
battle_options_amount = 0 //Used for the menus
battle_cleared_enemies = [] //Cleared as if either killed or spared.
battle_enemies_dialogs = [] //Here all the enemy dialogs are created if they have any.
battle_enemies_attacks = []
battle_enemies_parts = []
battle_selectable_enemies = []
battle_dust_clouds = []
battle_damage_text = []
battle_bullets = [] //An array of all the bullets, that gets cleared after an attack.
battle_exp = 0
battle_gold = 0
battle_fled = false
battle_only_attack = undefined
is_battle_only_attack_undefined = true //Auxiliar of the other variable

can_player_encounter_enemies = false
encounters_enemie_selection = ENCOUNTER_ENEMIE_SELECTION.COMBINE
encounters_timer = 0
encounters_steps = 0
encounters_minimum_steps_to_trigger = 0
encounters_enemie_pool = []
encounters_exclude_enemie_combination = [] //Only applicable with combinations
encounters_selected_enemies_ids = []
encounters_enemie_amount = {minimum: 1, maximum: 1}

goto_room = undefined
event_update = undefined
event_end_condition = undefined
after_transition_function = undefined
start_room_function = undefined
end_room_function = undefined
battle_init_function = undefined
battle_end_function = undefined

grid_options = []
plus_options = [undefined, undefined, undefined, undefined] //left, down, right, up
options_x = 0
options_y = 0
choice_sprite = spr_player_heart
choice_index = 0

game_over_timer = 0
game_over_heart_x = 0
game_over_heart_y = 0
game_over_heart_color = 0
game_over_dialog = undefined
game_over_music = undefined
game_over_dialog = []
game_over_shards = []

player_heart_subimage = 0 //The index of the sprite heart to use for menus, you can have another one for the battle one if you want, just change this variable when accessing the states.
player_heart_color = c_red

player_menu_state = PLAYER_MENU_STATE.INITIAL
player_menu_prev_state = 0
player_prev_room = undefined
player_menu_box = spr_player_menu_UI
player_menu_tail = undefined
player_menu_tail_mask = undefined
player_menu_top = true //If menu is on the top or not.
player_menu_selection = [0, 0, 0] //Initial menu, submenu for cell or inventory, action for item or grid of dimensional box.

player_box_index = 0 //Index for deciding which box inventory to use.
player_box_cursor = [0, 0]

player_save_cursor = 0
player_save_spawn_point_inst = undefined

anim_timer = 0 //For animation purposes such as room transition and battle start animation.
room_change_fade_in_time = 0
room_change_wait_time = 0
room_change_fade_out_time = 0
selection = -1
ui_surface = -1

dialog = new DisplayDialog(0, 0, [], 1)

with_border = false
border_id = 0 //There's just 1 border as of now, so this won't do anything yet.

control_type = CONTROL_TYPE.KEYBOARD
controller_id = -1 //-1 means that there's no controller assigned, either not connected or not supported.
controller_mapping_state = -1
controller_confirm_button = -1
controller_cancel_button = -1
controller_menu_button = -1

temp_up_button = 0
temp_down_button = 0
temp_left_button = 0
temp_right_button = 0

application_surface_draw_enable(false)

// Arrays of width and height of available resolutions that are integer multiples of 640 x 480.
resolutions_width = []
resolutions_height = []

// enable borderless window fullscreen mode.
window_enable_borderless_fullscreen(true)

var _display_width = display_get_width()
var _display_height = display_get_height()

for (var _i = 1; GAME_WIDTH * _i < _display_width and GAME_HEIGHT * _i < _display_height; _i++) {
    array_push(resolutions_width, GAME_WIDTH * _i)
	array_push(resolutions_height, GAME_HEIGHT * _i)
}

array_push(resolutions_width, _display_width)
array_push(resolutions_height, _display_height)

change_resolution(array_length(resolutions_width) - 2)

//Cargamos los items.
load_items_info("Item pool english.json")
load_ui_texts("UI texts english.json")
load_save_info()