/// @description Start room function

room_persistent = false;

if (!is_undefined(start_room_function)){
	if (is_undefined(start_room_function())){
		start_room_function = undefined;
	}
}