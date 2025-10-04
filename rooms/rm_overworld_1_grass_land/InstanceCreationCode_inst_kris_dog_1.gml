sprite_index = spr_kris_dog;

interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(real(id)) + "]Hi[w:10], I'm a test entity that has a dialog interaction.","If you talk to the other entity on the left I will look as if I'm talking too.","[bind_instance:" + string(real(object_index)) + "]That's because we both are instances of the same object[w:10], but with different data on creation","isn't that really neat simply?"], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}