/*draw_set_font(fnt_determination_sans)
draw_text(0, 0, "Control type: " + string(control_type))
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
		dialog.move_to(obj_box.x - obj_box.width/2 + 14.5 + battle_dialog_x_offset, obj_box.y - obj_box.height + 10)
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		draw_set_font(fnt_battle_status)
		
		draw_text(battle_player_stats.x + 214, battle_player_stats.y - 10, global.UI_texts.hp)
		
		var _hp_bar_color = global.player.hp_bar_color
		var _x_offset = 0
		
		draw_healthbar(battle_player_stats.x + 245, battle_player_stats.y + 6, battle_player_stats.x + 245 + global.player.hp_bar_width, battle_player_stats.y - 16, 100*global.player.hp/global.player.max_hp, c_red, _hp_bar_color, _hp_bar_color, 0, true, false)
		
		switch (global.player.status_effect.type){
			case PLAYER_STATUS_EFFECT.KARMIC_RETRIBUTION:
				var _kr_color = global.player.status_effect.color
				var _kr_amount = global.player.status_effect.value
				_x_offset += 32
				
				draw_healthbar(battle_player_stats.x + 245, battle_player_stats.y + 6, battle_player_stats.x + 245 + global.player.hp_bar_width*global.player.hp/global.player.max_hp, battle_player_stats.y - 16, 100*_kr_amount/global.player.hp, c_red, _kr_color, _kr_color, 1, false, false)
				
				draw_text(battle_player_stats.x + 255 + battle_player_stats.health_size, battle_player_stats.y - 10, global.UI_texts[$"status effects"][$"karmic retribution"])
				
				if (_kr_amount > 0){
					draw_set_color(_kr_color)
				}
			break
		}
		
		draw_set_font(fnt_mars_needs_cunnilingus)
		
		draw_text(battle_player_stats.x + 260 + _x_offset + global.player.hp_bar_width, battle_player_stats.y - 14, string_concat(global.player.hp, " / ", global.player.max_hp))
		
		draw_set_color(c_white)
		
		draw_text(battle_player_stats.x, battle_player_stats.y - 14, global.player.name)
		draw_text(battle_player_stats.x + 102, battle_player_stats.y - 14, global.UI_texts.lv)
		draw_text(battle_player_stats.x + 146, battle_player_stats.y - 14, global.player.lv)
		
		var _length = array_length(global.battle_enemies)
		for (var _i=0; _i<_length; _i++){
			var _enemy = global.battle_enemies[_i]
			
			if (is_undefined(_enemy)){
				continue
			}
			
			if (!is_undefined(_enemy.draw)){
				_enemy.draw()
			}
		}
		
		_length = array_length(battle_cleared_enemies)
		for (var _i=0; _i<_length; _i++){
			var _enemy = battle_cleared_enemies[_i]
			
			if (_enemy.spared){
				draw_sprite_ext(_enemy.sprite_spared, _enemy.sprite_spared_index, _enemy.x, _enemy.y, _enemy.sprite_xscale, _enemy.sprite_yscale, 0, c_gray, 1)
			}else if (_enemy.last_animation_timer < sprite_get_height(_enemy.sprite_killed)){
				var _dust_pixels = _enemy.last_animation_timer
				var _offset_x = sprite_get_xoffset(_enemy.sprite_killed)
				var _offset_y = sprite_get_yoffset(_enemy.sprite_killed)
				
				draw_sprite_part_ext(_enemy.sprite_killed, _enemy.sprite_killed_index, 0, _dust_pixels, sprite_get_width(_enemy.sprite_killed), sprite_get_height(_enemy.sprite_killed), _enemy.x - _offset_x, _enemy.y + (_dust_pixels - _offset_y)*_enemy.sprite_yscale, _enemy.sprite_xscale, _enemy.sprite_yscale, c_white, 1)
			}
		}
		
		_length = array_length(battle_enemies_parts)
		for (var _i=0; _i<_length; _i++){
			var _part = battle_enemies_parts[_i]
			
			draw_sprite_part_ext(_part.sprite, _part.sprite_index, 0, _part.part, sprite_get_width(_part.sprite), 1, _part.x, _part.y, _part.xscale, _part.yscale, c_white, _part.alpha)
		}
		
		_length = array_length(battle_dust_clouds)
		for (var _i=0; _i<_length; _i++){
			var _dust = battle_dust_clouds[_i]
			var _size = 1 + (1 - _dust.distance)*_dust.timer/10
			
			draw_sprite_ext(spr_dust_cloud, floor(_dust.timer/5), _dust.x, _dust.y, _size, _size, 0, c_white, 1)
		}
		
		_length = array_length(battle_damage_text)
		for (var _i=0; _i<_length; _i++){
			var _text = battle_damage_text[_i]
			var _timer = min(_text.timer/60, 1)
			
			draw_set_halign(fa_center)
			draw_set_valign(fa_bottom)
			draw_set_font(fnt_hachiko)
			
			draw_text_color(_text.x, _text.y - 10 - 20*dsin(180*_timer), _text.text, _text.text_color, _text.text_color, _text.text_color, _text.text_color, 1)
			if (_text.draw_bar){
				draw_healthbar(_text.x - _text.bar_width/2, _text.y + 5, _text.x + _text.bar_width/2, _text.y - 13, 100*(_text.hp - _text.damage*_timer)/_text.max_hp, c_red, _text.bar_color, _text.bar_color, 0, true, true)
			}
		}
		
		_length = array_length(battle_enemies_dialogs)
		for (var _i=0; _i<_length; _i++){
			var _dialog = battle_enemies_dialogs[_i]
			if (is_undefined(_dialog)){
				continue
			}
			
			_dialog.draw()
		}
		
		_length = array_length(battle_enemies_attacks)
		for (var _i=0; _i<_length; _i++){
			var _attack = battle_enemies_attacks[_i]
			
			if (!is_undefined(_attack.draw)){
				_attack.draw()
			}
		}
	break
}

//Move this
if (control_type == CONTROL_TYPE.MAPPING_CONTROLLER){
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	switch (controller_mapping_state){
		case CONTROLLER_MAPPING.WAITING_ENTER:
			draw_text(100, 140, "Controlador detectado.\nPresiona Enter para empezar\nel mapeado.")
		break
		case CONTROLLER_MAPPING.GET_CONFIRM:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar Z.")
		break
		case CONTROLLER_MAPPING.GET_CANCEL:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar X.")
		break
		case CONTROLLER_MAPPING.GET_MENU:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar C.")
		break
	}
}