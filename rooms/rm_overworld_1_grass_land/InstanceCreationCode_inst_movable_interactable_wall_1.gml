if (global.wall_1_moved){
	y = 240;
}

interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	
	if (!global.wall_1_moved){
		move_wall = false;
	
		epic_movement = function(){
			inst_movable_interactable_wall_1.move_wall = true;
		}
	
		var _option_1 = function(){
			obj_game.state = GAME_STATE.EVENT;
			overworld_dialog("[asterisk:true]Go kill yourself instead[w:20], he's not that important in the story to be the center of everything.", false);
		}
	
		var _option_2 = function(){
			obj_game.state = GAME_STATE.EVENT;
			overworld_dialog(["[asterisk:true]Just because it's the brother of the one skeleton that beats you up good in genocide...","Doesn't mean it can be a king to the underground[w:20], don't be stupid."], false);
		}
	
		var _option_3 = function(){
			obj_game.state = GAME_STATE.EVENT;
			overworld_dialog("[asterisk:true]Wing Gaster?[w:20] Pff[w:20], don't be stupid[w:20], that dude doesn't exist.", false);
		}
	
		var _option_4 = function(){
			obj_game.state = GAME_STATE.EVENT;
			overworld_dialog(["[asterisk:true]...[w:20]Well[w:20], at least you're honest[w:20], you may pass then.","[func:" + string(method_get_index(epic_movement)) + "][next]"], false);
		}
	
		create_choice_option("left", 120, 390, "Sans", _option_1);
		create_choice_option("right", 430, 390, "Papyrus", _option_2);
		create_choice_option("up", 260, 350, "Gaster", _option_3);
		create_choice_option("down", 220, 430, "I don't know.", _option_4);
	
		overworld_dialog(["Halt![w:20] if you want to pass[w:20], then tell me who's the king of the underground.","[progress_mode:none][asterisk:false][func:" + string(start_choice) + ", 320, 390]"]);
	
		obj_game.event_update = function(){
			if (move_wall){
				if (inst_movable_interactable_wall_1.y < 240){
					inst_movable_interactable_wall_1.y += 2;
				}else{
					global.wall_1_moved = true;
				}
			}
		}
		obj_game.event_end_condition = function(){
			return (obj_game.dialog.is_finished() and (!move_wall or global.wall_1_moved));
		}
	}else{
		overworld_dialog("Hello again[w:29], the path is open for you now.");
		obj_game.event_end_condition = obj_game.dialog.is_finished;
	}
}