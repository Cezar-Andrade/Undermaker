sprite_index = spr_kris_dog;

interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(id) + "]Hi![w:10] I'm just chilling out here.","[bind_instance:" + string(object_index) + "]As you can see there are many interaction collisions around here.","You can exit this room if you talk to the interaction object on the right.","[bind_instance:" + string(inst_kris_dog_1.id) + "]Just tell it that you don't know and it will let you pass[w:10], easy as that."], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}