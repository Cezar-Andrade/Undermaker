sprite_index = spr_kris_dog;

interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(real(object_index)) + ",0,1]I'm not part of the kris dog group sadly...","Therefor I have no name[w:10], my dialogs however use the object index to make me talk.","As you can see the kris group and even the button down there is affected by this.","This is not a good way to animate overworld sprites if there are multiple entity objects here.","So instead you should use a custom function like the one on the right does."], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}