timer = 0;
has_interacted = false;
dialog_1 = new DisplayDialog(440, 740, ["[next]"], 50,,,,,,, spr_box_normal, spr_box_normal_tiny_tail, spr_box_normal_mask);
dialog_2 = new DisplayDialog(360, 780, ["[next]"], 50,,,,,,, spr_box_normal, spr_box_normal_tiny_tail, spr_box_normal_mask);
dialog_3 = new DisplayDialog(490, 780, ["[next]"], 50,,,,,,, spr_box_normal, spr_box_normal_tiny_tail, spr_box_normal_mask);
dialog_1.set_container_tail_position(22, 50);
dialog_2.set_container_tail_position(90, 30);
dialog_3.set_container_tail_position(-15, 30);


detect_movement = function(){
	return (global.up_button or global.down_button or global.right_button or global.left_button);
}

interaction = function(){
	if (timer > 0 and obj_game.dialog.is_finished()){
		timer = -300;
		overworld_dialog(["[progress_mode:none][bind_instance:" + string(id) + "]Don't interrupt me.[w:20]\nI'm trying to annoy the dog on the left.[w:120][next]"]);
		dialog_1.bind_instance(undefined);
		dialog_2.bind_instance(undefined);
		dialog_3.bind_instance(undefined);
	}
}

update = function(){
	timer++;
	
	if (timer%180 == 61){
		dialog_1.add_dialogues(["[no_voice][no_skip][bind_instance:" + string(id) + "][effect:oscillate][progress_mode:none][apply_to_asterisk]Bark.[w:60][next]"]);
	}
	
	if (timer%180 == 121){
		dialog_2.add_dialogues(["[no_voice][no_skip][bind_instance:" + string(id) + "][effect:oscillate][progress_mode:none][apply_to_asterisk]Woof.[w:60][next]"]);
	}
	
	if (timer%180 == 1){
		dialog_3.add_dialogues(["[no_voice][no_skip][bind_instance:" + string(id) + "][effect:oscillate][progress_mode:none][apply_to_asterisk]Meow.[w:60][next]"]);
	}
	
	dialog_1.step();
	dialog_2.step();
	dialog_3.step();
}

draw = function(){
	draw_self();
	dialog_1.draw();
	dialog_2.draw();
	dialog_3.draw();
}