become_red = function(){
	inst_kris_dog_angy.image_blend = c_red;
	inst_kris_dog_angy.dialogs = ["[bind_instance:" + string(inst_kris_dog_angy.id) + "][text_speed:10]...[w:20][text_speed:2]\nI don't know how to turn back to normal..."]
}

dialogs = ["[bind_instance:" + string(id) + "]The puzzle on the left isn't much of a puzzle if you ask me.","You only push boxes around the maze to the buttons.[w:20][effect:shake,0.5]\nAND THAT'S IT!","[effect:shake,1]THIS IS NOT A PUZZLE, IT'S A STUPID LAME EXCUSE OF A \"PUZZLE\".","[effect:shake,1.5]I-[w:10]I-[w:10]I'M SO MAD I WILL TURN [func:" + string(method_get_index(become_red)) + "][color_rgb:255,0,0]RED[color_rgb:255,255,255]!"];

interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(dialogs, false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}