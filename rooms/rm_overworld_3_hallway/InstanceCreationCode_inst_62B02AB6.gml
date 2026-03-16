add_instance_reference(id, "inst_kris_4")

timer = -1

sprite_index = spr_kris_dog
image_xscale = -2

interaction = function(_direction){
	overworld_dialog(global.dialogues.hot_room.kris_4)
}

step = function(){ //Important the order of creation or events, the ball must update first and then the 2 entities that play with it, or it will push them.
	if (place_meeting(x, y, inst_ball_entity) and timer == -1){
		inst_ball_entity.force = 2
		timer = 0
	}
	
	if (timer >= 0){
		timer++
		
		if (timer <= 30){
			x = 640 + 20*dsin(6*timer)
		}else{
			timer = -1
		}
	}
}