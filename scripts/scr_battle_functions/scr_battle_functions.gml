function battle_box_dialog(_dialogues, _x_offset=0, _face_sprite=undefined, _face_subimages=undefined){
	obj_game.dialog.set_dialogues(_dialogues, obj_box.width/2 - 15 - _x_offset/2, 0, _face_sprite, _face_subimages);
	obj_game.dialog.can_progress = false;
	obj_game.dialog.set_scale(2, 2);
	obj_game.dialog.set_container_sprite(-1);
	obj_game.dialog.set_container_tail_sprite(-1);
	obj_game.dialog.set_container_tail_mask_sprite(-1);
	obj_game.dialog.move_to(obj_box.x - obj_box.width/2 + 14.5 + _x_offset, obj_box.y - obj_box.height + 10);
}
