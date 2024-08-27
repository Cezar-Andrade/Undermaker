interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(id) + "]My name is Drake.","[bind_instance:" + string(object_index) + "]We are part of the entity group kris dog.","That means we are instances of an object that heredates from the entity object[w:10], kind of like classes."], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}