trigger_function = function(){
	if (room_persistent){
		room_persistent = false;
	}
	
	change_room(rm_overworld_2_the_void, inst_spawn_point_2);
}