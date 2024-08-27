//Keyboard controls handler, if you don't understand it, I recommend not to touch it, don't even look at it... well ok you can in an attempt to understand, my bad, sorry...
switch (control_type){
	case CONTROL_TYPE.MAPPING_CONTROLLER:
		switch (controller_CONTROLLER_MAPPING_state){
			case CONTROLLER_MAPPING.WAITING_ENTER: //make macros for this in scr_init.
				if (keyboard_check_pressed(vk_enter)){
					controller_CONTROLLER_MAPPING_state = CONTROLLER_MAPPING.GET_CONFIRM;
				}
			break;
			case CONTROLLER_MAPPING.GET_CONFIRM:
				var _button_z = get_controller_button_pressed(controller_id);
				if (_button_z != -1){
					controller_confirm_button = _button_z;
					controller_CONTROLLER_MAPPING_state = CONTROLLER_MAPPING.GET_CANCEL;
				}
			break;
			case CONTROLLER_MAPPING.GET_CANCEL:
				var _button_x = get_controller_button_pressed(controller_id);
				if (_button_x != -1){
					controller_cancel_button = _button_x;
					controller_CONTROLLER_MAPPING_state = CONTROLLER_MAPPING.GET_MENU;
				}
			break;
			case CONTROLLER_MAPPING.GET_MENU:
				var _button_c = get_controller_button_pressed(controller_id);
				if (_button_c != -1){
					controller_menu_button = _button_c;
					controller_CONTROLLER_MAPPING_state = CONTROLLER_MAPPING.DONE;
					control_type = CONTROL_TYPE.CONTROLLER;
					save_controller_config(controller_id);
				}
			break;
		}
		global.up_button = 0;
		global.left_button = 0;
		global.left_button = 0;
		global.down_button = 0;
		global.right_button = 0;
		global.confirm_button = 0;
		global.cancel_button = 0;
		global.menu_button = 0;
		global.confirm_hold_button = 0;
		global.cancel_hold_button = 0;
		global.menu_hold_button = 0;
	break;
	case CONTROL_TYPE.KEYBOARD:
		global.up_button = (keyboard_check(ord("W")) or keyboard_check(vk_up));
		global.left_button = (keyboard_check(ord("A")) or keyboard_check(vk_left));
		global.down_button = (keyboard_check(ord("S")) or keyboard_check(vk_down));
		global.right_button = (keyboard_check(ord("D")) or keyboard_check(vk_right));
		global.confirm_button = (keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter));
		global.cancel_button = (keyboard_check_pressed(ord("X")) or keyboard_check_pressed(vk_shift));
		global.menu_button = (keyboard_check_pressed(ord("C")) or keyboard_check_pressed(vk_control));
		global.confirm_hold_button = (keyboard_check(ord("Z")) or keyboard_check(vk_enter));
		global.cancel_hold_button = (keyboard_check(ord("X")) or keyboard_check(vk_shift));
		global.menu_hold_button = (keyboard_check(ord("C")) or keyboard_check(vk_control));
	break;
	case CONTROL_TYPE.CONTROLLER:
		global.up_button = max(-gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padd), 0);
		global.left_button = max(-gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padl), 0);
		global.down_button = max(gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padu), 0);
		global.right_button = max(gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padr), 0);
		if (controller_CONTROLLER_MAPPING_state == CONTROLLER_MAPPING.DONE){
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
global.escape_hold_button = keyboard_check(vk_escape); //Exclusive to keyboard.

switch (state){
	case GAME_STATE.ROOM_CHANGE:
		timer++;
		if (timer == 40){
			if (is_undefined(event_after_room_change)){
				state = GAME_STATE.PLAYER_CONTROL;
			}else{
				state = GAME_STATE.EVENT;
				
				event_after_room_change();
				event_after_room_change = undefined;
			}
		}else if (timer == 20){
			room_goto(goto_room);
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
		
		for (var _i = 1; _i < 5; _i++){
			if (!is_undefined(options[_i])){
				options[_i][4].step();
			}
		}
		
		if (global.confirm_button and selection > 0){
			//Unless the function passed in the option variables set it otherwise, upon finishing a selection, the player regains control, a little fail safe in case you forget to place the event.
			state = GAME_STATE.PLAYER_CONTROL;
			
			options[selection][3]();
			
			var _length = array_length(options);
			for (var _i = 0; _i < _length; _i++){
				if (_i > 0){
					options[_i][3] = undefined;
					delete options[_i][4];
				}
				
				options[_i] = undefined;
			}
		}else if (global.left_button and !is_undefined(options[1])){
			selection = 1;
		}else if (global.right_button and !is_undefined(options[3])){
			selection = 3;
		}else if (global.up_button and !is_undefined(options[4])){
			selection = 4;
		}else if (global.down_button and !is_undefined(options[2])){
			selection = 2;
		}
		
		if (_prev_selection != selection and !is_undefined(options[_prev_selection]) and !is_undefined(options[selection])){
			if (_prev_selection > 0){
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