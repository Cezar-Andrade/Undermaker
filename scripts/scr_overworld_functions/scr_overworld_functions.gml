function change_room(_room_id, _spawn_point_instance, _event=undefined){
	obj_game.state = GAME_STATE.ROOM_CHANGE;
	obj_game.goto_room = _room_id;
	obj_game.event_after_room_change = _event;
	obj_game.timer = 0;
	obj_player_overworld.spawn_point_reference = _spawn_point_instance;
	obj_player_overworld.spawn_point_offset = -y - 10*image_yscale + obj_player_overworld.y;
	instance_destroy();
}