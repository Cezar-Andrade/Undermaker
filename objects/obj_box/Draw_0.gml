/// @description Arena draw

draw_rectangle_colour(x - round(width)/2 - 5, y, x + round(width)/2 + 4, y - round(height) - 11, c_white, c_white, c_white, c_white, false)
draw_rectangle_colour(x - round(width)/2, y - 5, x + round(width)/2 - 1, y - round(height) - 6, c_black, c_black, c_black, c_black, false)

switch (obj_game.battle_state){
	case BATTLE_STATE.PLAYER_ENEMY_SELECT:
		if (obj_game.battle_button_order[obj_game.battle_selection[0]].button_type == BUTTON.FIGHT){
			var _length = array_length(obj_game.battle_selectable_enemies)
			for (var _i=0; _i<_length; _i++){
				var _enemie = obj_game.battle_selectable_enemies[_i]
				
				if (_enemie.show_hp){
					draw_healthbar(x + 46, y - 93 + 36*_i, x + 46 + _enemie.hp_bar_width, y - 111 + 36*_i, 100*_enemie.hp/_enemie.max_hp, c_red, _enemie.hp_bar_color, _enemie.hp_bar_color, 0, true, false)
				}
			}
		}
	break
	case BATTLE_STATE.PLAYER_ATTACK:
		obj_game.battle_player_attack.draw()
	break
}