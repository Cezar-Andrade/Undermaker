//Keyboard controls handler
switch (control_type){
	case CONTROL_TYPE.MAPPING_CONTROLLER:
		switch (controller_mapping_state){
			case MAPPING.WAITING_ENTER: //make macros for this
				if (keyboard_check_pressed(vk_enter)){
					controller_mapping_state = MAPPING.GET_CONFIRM;
				}
			break;
			case MAPPING.GET_CONFIRM:
				var _button_z = get_controller_button_pressed(controller_id);
				if (_button_z != -1){
					controller_confirm_button = _button_z;
					controller_mapping_state = MAPPING.GET_CANCEL;
				}
			break;
			case MAPPING.GET_CANCEL:
				var _button_x = get_controller_button_pressed(controller_id);
				if (_button_x != -1){
					controller_cancel_button = _button_x;
					controller_mapping_state = MAPPING.GET_MENU;
				}
			break;
			case MAPPING.GET_MENU:
				var _button_c = get_controller_button_pressed(controller_id);
				if (_button_c != -1){
					controller_menu_button = _button_c;
					controller_mapping_state = MAPPING.DONE;
					control_type = CONTROL_TYPE.CONTROLLER;
					save_controller_config(controller_id);
				}
			break;
		}
		up_button = 0;
		left_button = 0;
		left_button = 0;
		down_button = 0;
		right_button = 0;
		confirm_button = 0;
		cancel_button = 0;
		menu_button = 0;
		confirm_hold_button = 0;
		cancel_hold_button = 0;
		menu_hold_button = 0;
	break;
	case CONTROL_TYPE.KEYBOARD:
		up_button = (keyboard_check(ord("W")) or keyboard_check(vk_up));
		left_button = (keyboard_check(ord("A")) or keyboard_check(vk_left));
		down_button = (keyboard_check(ord("S")) or keyboard_check(vk_down));
		right_button = (keyboard_check(ord("D")) or keyboard_check(vk_right));
		confirm_button = (keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter));
		cancel_button = (keyboard_check_pressed(ord("X")) or keyboard_check_pressed(vk_shift));
		menu_button = (keyboard_check_pressed(ord("C")) or keyboard_check_pressed(vk_control));
		confirm_hold_button = (keyboard_check(ord("Z")) or keyboard_check(vk_enter));
		cancel_hold_button = (keyboard_check(ord("X")) or keyboard_check(vk_shift));
		menu_hold_button = (keyboard_check(ord("C")) or keyboard_check(vk_control));
	break;
	case CONTROL_TYPE.CONTROLLER:
		up_button = max(-gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padd), 0);
		left_button = max(-gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padl), 0);
		down_button = max(gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padu), 0);
		right_button = max(gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padr), 0);
		if (controller_mapping_state == MAPPING.DONE){
			confirm_button = gamepad_button_check_pressed(controller_id, controller_confirm_button);
			cancel_button = gamepad_button_check_pressed(controller_id, controller_cancel_button);
			menu_button = gamepad_button_check_pressed(controller_id, controller_menu_button);
			confirm_hold_button = gamepad_button_check(controller_id, controller_confirm_button);
			cancel_hold_button = gamepad_button_check(controller_id, controller_cancel_button);
			menu_hold_button = gamepad_button_check(controller_id, controller_menu_button);
		}else{
			confirm_button = gamepad_button_check_pressed(controller_id, gp_face2);
			cancel_button = gamepad_button_check_pressed(controller_id, gp_face1);
			menu_button = gamepad_button_check_pressed(controller_id, gp_face4);
			confirm_hold_button = gamepad_button_check(controller_id, gp_face2);
			cancel_hold_button = gamepad_button_check(controller_id, gp_face1);
			menu_hold_button = gamepad_button_check(controller_id, gp_face4);
		}
	break;
	//If you want to add more type of controls or variantions of the previous ones add them as cases and define their macros in scr_init.
}
escape_hold_button = keyboard_check(vk_escape);

//Fullscreen toggle
if (keyboard_check_pressed(vk_f4)){
	change_resolution((resolution_active + 1) % array_length(resolutions_width));
}

//Border toggle
if (keyboard_check_pressed(ord("D"))){
	toggle_border(!with_border);
}