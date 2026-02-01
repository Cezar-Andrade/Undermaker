sprite_index = spr_kris_dog

interaction = function(){
	overworld_dialog(["[bind_instance:" + string(real(id)) + "]Hi![w:10] I'm just chilling out here.","[bind_instance:" + string(real(object_index)) + "]As you can see there are many interaction collisions around here.","You can exit this room if you talk to the interaction object on the right.","[bind_instance:" + string(real(inst_kris_dog_1.id)) + "]Just tell it that you don't know and it will let you pass[w:10], easy as that."],, false)
}