add_instance_reference(id, "inst_entity_2")

timer = 0
angle = 0

interaction = function(){
	overworld_dialog(global.dialogues.the_void.entity_2,, false)
}

step = function(){
	timer++
	
	angle = 10*dsin(pi*timer)
}

draw = function(){
	draw_sprite_ext(spr_kris_dog, image_index, x, y - 10 + 10*dsin(timer), -2, 2, angle, c_white, 1)
}