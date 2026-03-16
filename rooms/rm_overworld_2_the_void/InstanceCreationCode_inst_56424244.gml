add_instance_reference(id, "inst_entity_10")

has_interacted = false

detect_movement = function(){
	return (global.up_hold_button or global.down_hold_button or global.right_hold_button or global.left_hold_button)
}

interaction = function(){
	if (!has_interacted and obj_game.dialog.is_finished()){
		has_interacted = true
		overworld_dialog(global.dialogues.the_void.entity_10, false,,,,,,, spr_box_normal_tail, spr_box_normal_mask)
	}
}

step = function(){
	if (has_interacted){
		if (obj_game.dialog.is_finished()){
			has_interacted = false
		}else{
			obj_game.dialog.set_container_tail_position((x + 6.5 - camera_get_view_x(view_camera[0]) - obj_game.dialog.x - obj_game.dialog.dialog_x_offset)/2, (y - 50 - camera_get_view_y(view_camera[0]) - obj_game.dialog.y - obj_game.dialog.dialog_y_offset)/2)
		}
	}
}