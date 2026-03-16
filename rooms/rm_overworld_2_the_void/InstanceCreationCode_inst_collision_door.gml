if (global.save_data.puzzle_1){
	collision_id = 1
	image_blend = c_red
}else{
	when_colliding = function(){
		obj_player_overworld.player_anim_stop()
		overworld_dialog(global.dialogues.the_void.collision)
	}
}