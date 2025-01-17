/// @description Arena draw

draw_rectangle_colour(x - round(width)/2 - 5, y, x + round(width)/2 + 4, y - round(height) - 11, c_white, c_white, c_white, c_white, false);
draw_rectangle_colour(x - round(width)/2, y - 5, x + round(width)/2 - 1, y - round(height) - 6, c_black, c_black, c_black, c_black, false);

switch (obj_game.battle_state){
	case BATTLE_STATE.PLAYER_ENEMY_SELECT:
		if (obj_game.battle_button_order[obj_game.battle_selection[0]].button_type == BUTTON.FIGHT){
			//for (var i=0;i<array_length(Enemies);i++){ //modify
				//draw_healthbar(x - 33, y - 93, x + 67, y - 111, Enemies[i].HP/Enemies[i].maxHP*100, c_red, c_yellow, c_yellow, 0, true, false);
			//}
		}
	break;
	case BATTLE_STATE.PLAYER_ATTACK:
		//obj_Encounter.PlayerFight.Draw();
	break;
}