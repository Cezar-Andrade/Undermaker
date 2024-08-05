switch (ds_map_find_value(async_load, "event_type")){
	case "gamepad discovered":
		if (controller_id == -1){
			var _index_connected = ds_map_find_value(async_load, "pad_index");
			var _config = get_controller_config(_index_connected);
			if (_config == -1){
				gamepad_set_axis_deadzone(_index_connected, 0.2);
			}else{
				gamepad_set_axis_deadzone(_index_connected, _config.deadzone);
			}
			var _CONTROLLER_MAPPING = gamepad_get_CONTROLLER_MAPPING(_index_connected);
			if (_index_connected >= 4 and _CONTROLLER_MAPPING == "no CONTROLLER_MAPPING"){
				controller_id = _index_connected;
				if (_config == -1){
					control_type = CONTROL_TYPE.MAPPING_CONTROLLER;
					controller_CONTROLLER_MAPPING_state = CONTROLLER_MAPPING.WAITING_ENTER;
					map_controller(_index_connected);
				}else{
					control_type = CONTROL_TYPE.CONTROLLER;
					controller_CONTROLLER_MAPPING_state = CONTROLLER_MAPPING.DONE;
					controller_confirm_button = _config.confirm;
					controller_cancel_button = _config.cancel;
					controller_menu_button = _config.menu;
				}
			}else if (_CONTROLLER_MAPPING != "device index out of range" and _CONTROLLER_MAPPING != ""){
				controller_id = _index_connected;
				control_type = CONTROL_TYPE.CONTROLLER;
			}
		}/*else{
			//There's already a controller connected, cannot assign another.	
		}*/
	break;
	case "gamepad lost":
		var _index_disconnected = ds_map_find_value(async_load, "pad_index");
		if (controller_id == _index_disconnected){
			control_type = CONTROL_TYPE.KEYBOARD;
			controller_id = -1;
			controller_CONTROLLER_MAPPING_state = -1;
			controller_confirm_button = -1;
			controller_cancel_button = -1;
			controller_menu_button = -1;
		}
	break;
}