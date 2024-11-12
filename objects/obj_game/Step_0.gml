//Keyboard controls handler, if you don't understand it, I recommend not to touch it, don't even look at it... well ok you can in an attempt to understand, my bad, sorry...
switch (control_type){
	case CONTROL_TYPE.MAPPING_CONTROLLER:
		switch (controller_controller_mapping_state){
			case CONTROLLER_MAPPING.WAITING_ENTER: //make macros for this in scr_init.
				if (keyboard_check_pressed(vk_enter)){
					controller_controller_mapping_state = CONTROLLER_MAPPING.GET_CONFIRM;
				}
			break;
			case CONTROLLER_MAPPING.GET_CONFIRM:
				var _button_z = get_controller_button_pressed(controller_id);
				
				if (_button_z != -1){
					controller_confirm_button = _button_z;
					controller_controller_mapping_state = CONTROLLER_MAPPING.GET_CANCEL;
				}
			break;
			case CONTROLLER_MAPPING.GET_CANCEL:
				var _button_x = get_controller_button_pressed(controller_id);
				
				if (_button_x != -1){
					controller_cancel_button = _button_x;
					controller_controller_mapping_state = CONTROLLER_MAPPING.GET_MENU;
				}
			break;
			case CONTROLLER_MAPPING.GET_MENU:
				var _button_c = get_controller_button_pressed(controller_id);
				
				if (_button_c != -1){
					controller_menu_button = _button_c;
					controller_controller_mapping_state = CONTROLLER_MAPPING.DONE;
					control_type = CONTROL_TYPE.CONTROLLER;
					save_controller_config(controller_id);
				}
			break;
		}
		
		global.up_button = 0;
		global.left_button = 0;
		global.down_button = 0;
		global.right_button = 0;
		global.confirm_button = 0;
		global.cancel_button = 0;
		global.menu_button = 0;
		
		global.up_hold_button = 0;
		global.left_hold_button = 0;
		global.down_hold_button = 0;
		global.right_hold_button = 0;
		global.confirm_hold_button = 0;
		global.cancel_hold_button = 0;
		global.menu_hold_button = 0;
	break;
	case CONTROL_TYPE.KEYBOARD:
		global.up_button = (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up));
		global.left_button = (keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left));
		global.down_button = (keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down));
		global.right_button = (keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right));
		global.confirm_button = (keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter));
		global.cancel_button = (keyboard_check_pressed(ord("X")) or keyboard_check_pressed(vk_shift));
		global.menu_button = (keyboard_check_pressed(ord("C")) or keyboard_check_pressed(vk_control));
		
		global.up_hold_button = (keyboard_check(ord("W")) or keyboard_check(vk_up));
		global.left_hold_button = (keyboard_check(ord("A")) or keyboard_check(vk_left));
		global.down_hold_button = (keyboard_check(ord("S")) or keyboard_check(vk_down));
		global.right_hold_button = (keyboard_check(ord("D")) or keyboard_check(vk_right));
		global.confirm_hold_button = (keyboard_check(ord("Z")) or keyboard_check(vk_enter));
		global.cancel_hold_button = (keyboard_check(ord("X")) or keyboard_check(vk_shift));
		global.menu_hold_button = (keyboard_check(ord("C")) or keyboard_check(vk_control));
	break;
	case CONTROL_TYPE.CONTROLLER:
		var _up_button = max(-gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padd), 0);
		var _left_button = max(-gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padl), 0);
		var _down_button = max(gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padu), 0);
		var _right_button = max(gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padr), 0);
		
		if (temp_up_button == _up_button){
			global.up_button = 0;
		}else{
			temp_up_button = _up_button;
			
			global.up_button = _up_button;
		}
		
		if (temp_down_button == _down_button){
			global.down_button = 0;
		}else{
			temp_down_button = _down_button;
			
			global.down_button = _down_button;
		}
		
		if (temp_left_button == _left_button){
			global.left_button = 0;
		}else{
			temp_left_button = _left_button;
			
			global.left_button = _left_button;
		}
		
		if (temp_right_button == _right_button){
			global.right_button = 0;
		}else{
			temp_right_button = _right_button;
			
			global.right_button = _right_button;
		}
		
		global.up_hold_button = max(-gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padd), 0);
		global.left_hold_button = max(-gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padl), 0);
		global.down_hold_button = max(gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padu), 0);
		global.right_hold_button = max(gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padr), 0);
		
		if (controller_controller_mapping_state == CONTROLLER_MAPPING.DONE){
			global.confirm_button = gamepad_button_check_pressed(controller_id, controller_confirm_button);
			global.cancel_button = gamepad_button_check_pressed(controller_id, controller_cancel_button);
			global.menu_button = gamepad_button_check_pressed(controller_id, controller_menu_button);
			
			global.confirm_hold_button = gamepad_button_check(controller_id, controller_confirm_button);
			global.cancel_hold_button = gamepad_button_check(controller_id, controller_cancel_button);
			global.menu_hold_button = gamepad_button_check(controller_id, controller_menu_button);
		}else{
			global.confirm_button = gamepad_button_check_pressed(controller_id, gp_face2);
			global.cancel_button = gamepad_button_check_pressed(controller_id, gp_face1);
			global.menu_button = gamepad_button_check_pressed(controller_id, gp_face4);
			
			global.confirm_hold_button = gamepad_button_check(controller_id, gp_face2);
			global.cancel_hold_button = gamepad_button_check(controller_id, gp_face1);
			global.menu_hold_button = gamepad_button_check(controller_id, gp_face4);
		}
	break;
	//If you want to add more type of controls or variantions of the previous ones add them as cases and define their macros in scr_init.
	//After that set the control_type variable on the Create event of this object to the initial control type or handle its connection and disconnection in the corresponding place.
}

global.escape_button = keyboard_check_pressed(vk_escape); //Exclusive to keyboard.
global.escape_hold_button = keyboard_check(vk_escape); //Exclusive to keyboard.

if (keyboard_check_pressed(ord("V"))){
	perform_game_load();
}

switch (state){
	case GAME_STATE.PLAYER_MENU_CONTROL:
		switch (player_menu_state){
			case PLAYER_MENU_STATE.INITIAL:
				if (global.up_button and player_menu_selection[0] > 0){
					player_menu_selection[0]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.down_button and player_menu_selection[0] < 1 + global.player_cell){
					player_menu_selection[0]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					switch (player_menu_selection[0]){
						case PLAYER_MENU_OPTIONS.ITEM:
							if (array_length(global.player_inventory) > 0){
								player_menu_state = PLAYER_MENU_STATE.INVENTORY;
								player_menu_selection[1] = 0;
							}
						break;
						case PLAYER_MENU_OPTIONS.STAT:
							player_menu_state = PLAYER_MENU_STATE.STATS;
						break;
						case PLAYER_MENU_OPTIONS.CELL:
							if (array_length(global.cell_options) > 0){
								player_menu_state = PLAYER_MENU_STATE.CELL;
								player_menu_selection[1] = 0;
							}
						break;
					}
					
					if (player_menu_state != PLAYER_MENU_STATE.INITIAL){
						audio_play_sound(snd_menu_confirm, 0, false);
					}
				}else if (global.cancel_button){
					state = GAME_STATE.PLAYER_CONTROL;
				}
			break;
			case PLAYER_MENU_STATE.STATS:
				if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INITIAL;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.INVENTORY:
				if (global.up_button and player_menu_selection[1] > 0){
					player_menu_selection[1]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.down_button and player_menu_selection[1] < array_length(global.player_inventory) - 1){
					player_menu_selection[1]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					player_menu_state = PLAYER_MENU_STATE.ITEM_SELECTED;
					player_menu_selection[2] = 0;
					
					audio_play_sound(snd_menu_confirm, 0, false);
				}else if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INITIAL;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.ITEM_SELECTED:
				if (global.left_button and player_menu_selection[2] > 0){
					player_menu_selection[2]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.right_button and player_menu_selection[2] < 2){
					player_menu_selection[2]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					player_menu_state = PLAYER_MENU_STATE.WAITING_DIALOG_END;
					var _dialog = "";
					
					switch (player_menu_selection[2]){
						case PLAYER_MENU_INVENTORY_OPTIONS.USE:
							_dialog = use_item(player_menu_selection[1]);
						break;
						case PLAYER_MENU_INVENTORY_OPTIONS.INFO:
							_dialog = item_info(player_menu_selection[1]);
						break;
						case PLAYER_MENU_INVENTORY_OPTIONS.DROP:
							_dialog = drop_item(player_menu_selection[1]);
						break;
					}
					
					if (_dialog != ""){
						player_menu_prev_state = PLAYER_MENU_STATE.INVENTORY;
						
						overworld_dialog(_dialog, !player_menu_top,,,,, player_menu_box, player_menu_tail, player_menu_tail_mask);
					}
				}else if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INVENTORY;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.CELL:
				if (global.up_button and player_menu_selection[1] > 0){
					player_menu_selection[1]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.down_button and player_menu_selection[1] < array_length(global.cell_options) - 1){
					player_menu_selection[1]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					player_menu_state = PLAYER_MENU_STATE.WAITING_DIALOG_END;
					var _dialog = cell_use(player_menu_selection[1]);
					
					if (_dialog != ""){
						player_menu_prev_state = PLAYER_MENU_STATE.CELL;
						
						overworld_dialog(_dialog, !player_menu_top,,,,, player_menu_box, player_menu_tail, player_menu_tail_mask);
					}
				}else if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INITIAL;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.BOX:
				var _box = global.box_inventory[player_box_index];
				var _box_amount = array_length(_box);
				var _inventory_amount = array_length(global.player_inventory);
				
				if (global.left_button and player_box_cursor[0] == 1 and _inventory_amount > 0){
					player_box_cursor[0]--;
					player_box_cursor[1] = min(player_box_cursor[1], _inventory_amount - 1);
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.right_button and player_box_cursor[0] == 0 and _box_amount > 0){
					player_box_cursor[0]++;
					player_box_cursor[1] = min(player_box_cursor[1], _box_amount - 1);
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.up_button and player_box_cursor[1] > 0){
					player_box_cursor[1]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.down_button and ((player_box_cursor[0] == 0 and player_box_cursor[1] < _inventory_amount - 1) or (player_box_cursor[0] == 1 and player_box_cursor[1] < _box_amount - 1))){
					player_box_cursor[1]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button and (_inventory_amount > 0 or _box_amount > 0)){
					if (player_box_cursor[0] == 0 and _box_amount < global.box_inventory_size[player_box_index]){
						array_push(global.box_inventory[player_box_index], global.player_inventory[player_box_cursor[1]]);
						array_delete(global.player_inventory, player_box_cursor[1], 1);
						_inventory_amount--;
						
						if (_inventory_amount == 0){
							player_box_cursor[0] = 1;
						}else{
							player_box_cursor[1] = min(player_box_cursor[1], _inventory_amount - 1);
						}
					}else if (player_box_cursor[0] == 1 and _inventory_amount < global.player_inventory_size){
						array_push(global.player_inventory, global.box_inventory[player_box_index][player_box_cursor[1]]);
						array_delete(global.box_inventory[player_box_index], player_box_cursor[1], 1);
						_box_amount--;
						
						if (_box_amount == 0){
							player_box_cursor[0] = 0;
						}else{
							player_box_cursor[1] = min(player_box_cursor[1], _box_amount - 1);
						}
					}
				}else if (global.cancel_button){
					if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
						player_menu_state = PLAYER_MENU_STATE.CELL;
					}else{
						state = GAME_STATE.PLAYER_CONTROL;
					}
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.SAVE:
				if (global.left_button and player_save_cursor == 1){
					player_save_cursor--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.right_button and player_save_cursor == 0){
					player_save_cursor++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					if (player_save_cursor == 0){
						if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
							perform_game_save(room, obj_player_overworld.x, obj_player_overworld.y);
						}else{
							perform_game_save(room, 0, 0); ////TODO
						}
						
						audio_play_sound(snd_game_saved, 100, false);
						
						player_save_cursor = 2;
					}else{
						if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
							player_menu_state = PLAYER_MENU_STATE.CELL;
							
							audio_play_sound(snd_menu_selecting, 100, false);
						}else{
							state = GAME_STATE.PLAYER_CONTROL;
						}
					}
				}else if (global.cancel_button){
					if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
						player_menu_state = PLAYER_MENU_STATE.CELL;
					}else{
						state = GAME_STATE.PLAYER_CONTROL;
					}
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.WAITING_DIALOG_END:
				if (dialog.is_finished()){
					player_menu_state = player_menu_prev_state;
					
					switch (player_menu_state){
						case PLAYER_MENU_STATE.INVENTORY:
							var _items_remaining = array_length(global.player_inventory);
							
							if (_items_remaining == 0){
								player_menu_state = PLAYER_MENU_STATE.INITIAL;
							}else{
								player_menu_selection[1] = min(player_menu_selection[1], array_length(global.player_inventory) - 1);
							}
						break;
					}
				}
			break;
		}
	break;
	case GAME_STATE.ROOM_CHANGE:
		room_change_timer++;
		
		if (room_change_timer == room_change_fade_in_time){
			room_goto(goto_room);
		}else if (room_change_timer == room_change_fade_out_time){
			state = GAME_STATE.PLAYER_CONTROL;
			
			if (!is_undefined(after_transition_function)){
				after_transition_function();
				after_transition_function = undefined;
			}
		}
	break;
	case GAME_STATE.EVENT:
		if (!is_undefined(event_update)){
			event_update();
		}
		
		if (event_end_condition()){
			state = GAME_STATE.PLAYER_CONTROL;
			
			event_update = undefined;
			event_end_condition = undefined;
		}
	break;
	case GAME_STATE.DIALOG_CHOICE:
		var _prev_selection = selection;
		
		if (!is_undefined(event_update)){
			event_update();
		}
		
		for (var _i = 0; _i < 4; _i++){
			if (!is_undefined(options[_i])){
				options[_i][4].step();
			}
		}
		
		if (global.confirm_button and selection >= 0){
			//Unless the function passed in the option variables set it otherwise, upon finishing a selection, the player regains control, a little fail safe in case you forget to place the event.
			state = GAME_STATE.PLAYER_CONTROL;
			
			options[selection][3]();
			
			for (var _i = 0; _i < 4; _i++){
				if (_i >= 0){
					options[_i][3] = undefined;
					delete options[_i][4];
				}
				
				options[_i] = undefined;
			}
		}else if (global.left_hold_button and selection != 0 and !is_undefined(options[0])){
			audio_play_sound(snd_menu_selecting, 0, false);
			
			selection = 0;
		}else if (global.down_hold_button and selection != 1 and !is_undefined(options[1])){
			audio_play_sound(snd_menu_selecting, 0, false);
			
			selection = 1;
		}else if (global.right_hold_button and selection != 2 and !is_undefined(options[2])){
			audio_play_sound(snd_menu_selecting, 0, false);
			
			selection = 2;
		}else if (global.up_hold_button and selection != 3 and !is_undefined(options[3])){
			audio_play_sound(snd_menu_selecting, 0, false);
			
			selection = 3;
		}
		
		if (_prev_selection != selection and (_prev_selection < 0 or !is_undefined(options[_prev_selection])) and !is_undefined(options[selection])){
			if (_prev_selection >= 0){
				options[_prev_selection][4].set_dialogues("[skip:false][progress_mode:none][asterisk:false]" + options[_prev_selection][2]);
			}
			
			options[selection][4].set_dialogues("[skip:false][progress_mode:none][asterisk:false][color_rgb:255,255,0]" + options[selection][2]);
		}
	break;
}

//Fullscreen toggle
if (keyboard_check_pressed(vk_f4)){
	change_resolution((resolution_active + 1) % array_length(resolutions_width));
}

//Border toggle
if (keyboard_check_pressed(ord("D"))){
	toggle_border(!with_border);
}

dialog.step();