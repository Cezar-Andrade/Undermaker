add_instance_reference(id, "inst_entity_7")

interaction = function(){
	overworld_dialog(global.dialogues.the_void.entity_7,, false)
}

draw = function(){
	draw_sprite_ext(spr_kris_dog, image_index, x + 14, y - 60, 2, 2, 180, c_white, 1)
}