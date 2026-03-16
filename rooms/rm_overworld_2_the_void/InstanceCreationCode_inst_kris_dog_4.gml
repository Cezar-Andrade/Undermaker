add_instance_reference(id, "inst_entity_9")

array_pop(collision_ids) //Remove the collision on id 0 so it doesn't collide with that one, but the player does.
array_push(collision_ids, 1) //Add collision to the 1.

become_pushable = function(){
	inst_kris_dog_4.can_player_push = true
	inst_kris_dog_4.can_entities_push = true
	inst_kris_dog_4.image_blend = c_yellow
	inst_kris_dog_4.dialogs = global.dialogues.the_void.entity_9.pushable
}

has_changed_dialogs = false
dialogs = global.dialogues.the_void.entity_9.not_pushable

sprite_index = spr_kris_dog

interaction = function(){
	overworld_dialog(dialogs,, false)
}

step = function(){
	if (!has_changed_dialogs and (x != 460 or y != 540)){
		has_changed_dialogs = true
		dialogs = global.dialogues.the_void.entity_9.pushed
	}
}