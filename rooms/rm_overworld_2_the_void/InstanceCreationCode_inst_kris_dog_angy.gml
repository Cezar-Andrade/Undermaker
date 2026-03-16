add_instance_reference(id, "inst_entity_3")

become_red = function(){
	inst_kris_dog_angy.image_blend = c_red
	inst_kris_dog_angy.dialogs = global.dialogues.the_void.entity_3.angy
}

dialogs = global.dialogues.the_void.entity_3.not_angy

interaction = function(){
	overworld_dialog(dialogs,, false)
}