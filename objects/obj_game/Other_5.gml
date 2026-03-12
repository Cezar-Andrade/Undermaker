/// @description End room function

//Stores the previous room, so when starting the next one, depending on the previous room different stuff can happen.
previous_room = room

//Execution of the ending room function if defined
if (!is_undefined(end_room_function)){
	if (is_undefined(end_room_function())){
		end_room_function = undefined
	}
}