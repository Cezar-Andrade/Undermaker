add_instance_reference(id, "inst_entity_4")
add_instance_reference(inst_plate_1.id, "inst_plate_1") //Add it here is the same as adding it on the plate instance itself.

sprite_index = spr_kris_dog

instance = undefined
timer = 0

//This is just so 1 instance talks with this entity, edit it to allow for multiple entities of course, there are many ways to do it alongside the system.
instance_talk = function(_inst){
	inst_kris_dog_3.instance = get_instance_reference(_inst) //Must specify the inst_kris_dog_3 as this function is called in the scope of the dialog structure, which may not be ideal, so it is needed to do point the instance variables that want to be changed.
	inst_kris_dog_3.timer = 2 //Delay it takes for the dialog to begin, defined by its text_speed which is 2.
}

interaction = function(){
	overworld_dialog(global.dialogues.the_void.entity_4,, false)
	inst_plate_1.can_update = false
}

step = function(){
	if (!is_undefined(instance)){
		if (!obj_game.dialog.is_finished()){
			if (obj_game.dialog.is_talking() or instance.image_index > 0){
				timer++
				
				if (timer >= 10){
					timer -= 10
					instance.image_index++
					
					if (instance.image_index > 1){
						instance.image_index -= 2
					}
				}
			}else{
				instance.image_index = 0
				timer = 2 //Delay it takes for the dialog to begin, defined by its text speed which is 2.
			}
		}else{
			instance.image_index = 0
			instance = undefined
			timer = 0
			inst_plate_1.can_update = true
		}
	}
}