#macro GAME_WIDTH 640
#macro GAME_HEIGHT 480

enum CONTROL_TYPE{
	KEYBOARD,
	CONTROLLER,
	MAPPING_CONTROLLER
}

enum MAPPING{
	WAITING_ENTER,
	GET_CONFIRM,
	GET_CANCEL,
	GET_MENU,
	DONE
}

globalvar player_max_hp, player_hp, player_lv, player_name, player_inventory, player_inventory_size;
globalvar box_inventory, box_inventory_size;
globalvar confirm_button, cancel_button, menu_button, confirm_hold_button, cancel_hold_button, menu_hold_button, up_button, down_button, left_button, right_button, escape_hold_button;