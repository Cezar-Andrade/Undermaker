interaction = function(){
	obj_game.state = GAME_STATE.EVENT;
	overworld_dialog(["[bind_instance:" + string(real(id)) + "]We all in this room have temperature resistance actually.","That guy that transformed into a rock was just not from this room though...","He tried to leave but a collision told him to solve the puzzle.","Unfortunatelly the puzzle was on the other side...[w:20]\nSuch a sad fate..."], false);
	obj_game.event_end_condition = obj_game.dialog.is_finished;
}