movement_speed = 2;

sprite_index = spr_kris_dog;

interaction = function(_direction){
	if (path_position == path_positionprevious){
		var _move_entity = function(){
			with (inst_move_entity){
				path_start(path_npc_movement_1, movement_speed, path_action_stop, true);
				movement_speed = -movement_speed;
			}
		}
	
		obj_game.state = GAME_STATE.EVENT;
		overworld_dialog(["[bind_instance:" + string(id) + "]I'm an entity that will move when you talk to me using a path resource.","When this dialog ends I'm gonna move.","Anytime now...[wait_key:confirm]\nAlmost there...[wait_key:confirm]\n..........","Dude end already.[wait_key:confirm]\n..........[wait_key:confirm]\nOk enough, I will move.","[func:" + string(method_get_index(_move_entity)) + "]Even with a dialog playing.[w:20]\nScrew you game."], false);
		obj_game.event_end_condition = obj_game.dialog.is_finished;
	}
}

after_update = function(){ //Must use after_update (which run in the end_step event) function since paths update after the update event (which run on the step event)
	if (path_position == 1 and path_positionprevious != 1){
		image_xscale = -image_xscale;
	}
}