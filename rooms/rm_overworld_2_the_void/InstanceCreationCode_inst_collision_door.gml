if (global.puzzle_1){
	collision_id = 1;
	image_blend = #A19E42;
}else{
	when_colliding = function(){
		obj_player_overworld.player_anim_stop();
		obj_game.state = GAME_STATE.EVENT;
		overworld_dialog(["Hey hey hey![w:20]\nDo not dare to approach me.","You cannot pass through me[w:10], unless you solve that puzzle over there."]);
		obj_game.event_end_condition = obj_game.dialog.is_finished;
	}
}