/*draw_set_font(fnt_determination_sans);
draw_text(0, 0, "Control type: " + string(control_type));
draw_text(0, 20, "Up: " + string(global.up_hold_button))
draw_text(0, 40, "Left: " + string(global.left_hold_button))
draw_text(0, 60, "Down: " + string(global.down_hold_button))
draw_text(0, 80, "Right: " + string(global.right_hold_button))
draw_text(0, 100, "Z: " + string(global.confirm_hold_button))
draw_text(0, 120, "X: " + string(global.cancel_hold_button))
draw_text(0, 140, "C: " + string(global.menu_hold_button))
draw_text(0, 160, "Escape: " + string(global.escape_hold_button))*/

switch (state){
	case GAME_STATE.BATTLE:
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_font(fnt_battle_status);
		
		draw_text(battle_player_stats.x, battle_player_stats.y - 10, global.UI_texts.hp);
		
		draw_healthbar(battle_player_stats.x + 31, battle_player_stats.y + 6, battle_player_stats.x + 31 + battle_player_stats.health_size, battle_player_stats.y - 16, 100*global.player.hp/global.player.max_hp, c_red, c_lime, c_lime, 0, true, false);
		
		switch (global.player.status_effect.type){
			case PLAYER_STATUS_EFFECT.KARMIC_RETRIBUTION:
				var _kr_color = global.player.status_effect.color;
				var _kr_amount = global.player.status_effect.value;
				
				draw_healthbar(battle_player_stats.x + 31, battle_player_stats.y + 6, battle_player_stats.x + 31 + battle_player_stats.health_size*global.player.hp/global.player.max_hp, battle_player_stats.y - 16, 100*_kr_amount/global.player.hp, c_red, _kr_color, _kr_color, 1, false, false);
				
				draw_text(battle_player_stats.x + 41 + battle_player_stats.health_size, battle_player_stats.y - 10, global.UI_texts[$"status effects"][$"karmic retribution"]);
				
				if (_kr_amount > 0){
					draw_set_color(_kr_color);
				}
			break;
		}
		
		draw_set_font(fnt_mars_needs_cunnilingus);
		
		draw_text(battle_player_stats.x + 46 + battle_player_stats.aux + battle_player_stats.health_size, battle_player_stats.y - 15, string_concat(global.player.hp, " / ", global.player.max_hp));
		
		draw_set_color(c_white);
		
		draw_text(battle_player_stats.x + 326, battle_player_stats.y - 15, global.player.name);
		draw_text(battle_player_stats.x + 429, battle_player_stats.y - 15, global.UI_texts.lv);
		draw_text(battle_player_stats.x + 473, battle_player_stats.y - 15, global.player.lv);
		
		var _length = array_length(global.battle_enemies);
		for (var _i=0; _i<_length; _i++){
			global.battle_enemies[_i].draw();
		}
		
		/*if (State == "Defending"){
			for (var i=0;i<array_length(CurrentAttacks);i++){
				CurrentAttacks[i].Draw();
			}
		}*/
	break;
}

//Move this
if (control_type == CONTROL_TYPE.MAPPING_CONTROLLER){
	switch (controller_mapping_state){
		case CONTROLLER_MAPPING.WAITING_ENTER:
			draw_text(100, 140, "Controlador detectado.\nPresiona Enter para empezar\nel mapeado.");
		break;
		case CONTROLLER_MAPPING.GET_CONFIRM:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar Z.");
		break;
		case CONTROLLER_MAPPING.GET_CANCEL:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar X.");
		break;
		case CONTROLLER_MAPPING.GET_MENU:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar C.");
		break;
	}
}