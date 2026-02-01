var _screen_height = resolutions_height[resolution_active]
var _game_width = _screen_height*(4/3)
var _ui_not_showing = (state == GAME_STATE.PLAYER_MENU_CONTROL or state == GAME_STATE.BATTLE_END or (state == GAME_STATE.BATTLE and battle_state == BATTLE_STATE.ATTACK_END) or state == GAME_STATE.GAME_OVER or state == GAME_STATE.ROOM_CHANGE or state == GAME_STATE.BATTLE_START_ANIMATION or !dialog.is_finished())

if (_ui_not_showing){
	if (!surface_exists(ui_surface)){
		ui_surface = surface_create(GAME_WIDTH, GAME_HEIGHT)
	}
	surface_set_target(ui_surface)
	
	draw_clear_alpha(c_black, 0)
	
	switch (state){
		case GAME_STATE.GAME_OVER:
			var _number = 255*(clamp(game_over_timer - 225, 0, 75) - clamp(game_over_timer - 352, 0, 75))/75
			var _color = make_colour_rgb(_number, _number, _number)
			
			draw_clear_alpha(c_black, 1 - max(game_over_timer - 472, 0)/20)
			draw_sprite_ext(spr_game_over, 0, 320, 160, 1, 1, 0, _color, 1 - clamp(game_over_timer - 472, 0, 1))
			
			if (game_over_timer < 75){
				draw_sprite_ext(spr_player_heart, game_over_heart_index, game_over_heart_x, game_over_heart_y, game_over_heart_xscale, game_over_heart_yscale, game_over_heart_angle, game_over_heart_color, 1)
			}else if (game_over_timer < 150){
				draw_sprite_ext(spr_player_heart_broken, game_over_heart_index, game_over_heart_x, game_over_heart_y, game_over_heart_xscale, game_over_heart_yscale, game_over_heart_angle, game_over_heart_color, 1)
			}
			
			var _length = array_length(game_over_shards)
			for (var _i=0; _i<_length; _i++){
				var _shard = game_over_shards[_i]
				
				draw_sprite_ext(spr_player_heart_shard, floor(game_over_timer/6), _shard.x, _shard.y, 1, 1, 0, game_over_heart_color, 1)
			}
		break
	}
	
	dialog.draw()
	
	switch (state){
		case GAME_STATE.BATTLE_END:
			draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, c_black, 1 - anim_timer/20)
		break
		case GAME_STATE.BATTLE:
			//Special effects of the battle can be placed here.
			switch (battle_state){
				case BATTLE_STATE.ATTACK_END:
				case BATTLE_STATE.END:
					draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, c_black, anim_timer/20)
				break
			}
		break
		case GAME_STATE.ROOM_CHANGE:
			draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, c_black, (min(anim_timer, room_change_fade_in_time) - max(anim_timer - room_change_wait_time, 0))/20)
		break
		case GAME_STATE.BATTLE_START_ANIMATION:
			if (anim_timer >= 0){
				draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, c_black, 1)
				
				var _camera_x = camera_get_view_x(view_camera[0])
				var _camera_y = camera_get_view_y(view_camera[0])
				
				//If multiple players are on screen, they will do this, makes for a cool effect if you ever need multiple player instances on screen, kinda like surreal.
				with (obj_player_overworld){
					var _player_x = (obj_player_overworld.x - _camera_x)
					var _player_y = (obj_player_overworld.y - _camera_y)
					
					if (other.anim_timer < 24){
						draw_sprite_ext(sprite_index, image_index, _player_x, _player_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
					}
					
					_player_x += image_xscale
					_player_y += image_yscale*(5 - round(sprite_height/(2*image_yscale)))
					
					if (other.anim_timer >= 20 or (other.anim_timer < 20 and other.anim_timer%8 < 4)){
						var _lerp = clamp(other.anim_timer - 24, 0, 20)/20
						
						draw_sprite_ext(spr_player_heart, other.player_heart_subimage, _player_x + _lerp*(other.battle_start_animation_player_heart_x - _player_x), _player_y + _lerp*(other.battle_start_animation_player_heart_y - _player_y), 1, 1, 0, other.player_heart_color, 1)
					}
				}
			}
		break
		case GAME_STATE.DIALOG_CHOICE:
			for (var _i = 0; _i < 4; _i++){
				if (!is_undefined(options[_i])){
					options[_i][4].draw()
				}
			}
			
			if (selection >= 0){
				draw_sprite_ext(choice_sprite, choice_index, options_x + options[selection][0], options_y + options[selection][1], 1, 1, 0, player_heart_color, 1)
			}else{
				draw_sprite_ext(choice_sprite, choice_index, options_x, options_y, 1, 1, 0, player_heart_color, 1)
			}
		break
		case GAME_STATE.PLAYER_MENU_CONTROL:
			draw_set_halign(fa_left)
			draw_set_valign(fa_top)
			draw_set_font(fnt_determination_sans)
			
			var _heart_x = 0
			var _heart_y = 0
			
			switch (player_menu_state){
				case PLAYER_MENU_STATE.BOX:
					var _items_string = ""
					var _box_string = ""
					var _amount_items = array_length(global.player.inventory)
					var _amount_box = array_length(global.box.inventory[player_box_index])
					_heart_x = 49 + 302*player_box_cursor[0]
					_heart_y = 88 + 32*player_box_cursor[1]
					
					draw_sprite_ext(player_menu_box, 0, 15, 15, 610/30, 450/30, 0, c_white, 1)
					
					draw_line_color(318, 92, 318, 392, c_white, c_white)
					draw_line_color(320, 92, 320, 392, c_white, c_white)
					
					for (var _i = 0; _i < min(global.player.inventory_size, 10); _i++){
						if (_i < _amount_items){
							var _item = global.item_pool[global.player.inventory[_i]]
							var _item_name = _item[$"inventory name"]
							
							_items_string += _item_name + "\n"
						}else{
							var _height = 92 + 32*_i
							
							draw_line_color(78, _height, 258, _height, c_red, c_red)
						}
					}
					
					for (var _i = 0; _i < min(global.box.inventory_size[player_box_index], 10); _i++){
						if (_i < _amount_box){
							var _item = global.item_pool[global.box.inventory[player_box_index][_i]]
							var _item_name = _item[$"inventory name"]
							
							_box_string += _item_name + "\n"
						}else{
							var _height = 92 + 32*_i
							
							draw_line_color(380, _height, 560, _height, c_red, c_red)
						}
					}
					
					draw_text_ext_transformed(67, 71, _items_string, 16, 400, 2, 2, 0)
					draw_text_ext_transformed(369, 71, _box_string, 16, 400, 2, 2, 0)
					
					draw_set_halign(fa_center)
					
					draw_text_transformed(167, 29, global.UI_texts[$"box inventory"], 2, 2, 0)
					draw_text_transformed(472, 29, global.UI_texts[$"box box"], 2, 2, 0)
					draw_text_transformed(320, 405, global.UI_texts[$"box exit"], 2, 2, 0)
				break
				case PLAYER_MENU_STATE.SAVE:
					_heart_x = 151 + 180*player_save_cursor
					_heart_y = 257
					
					if (player_save_cursor == 2){
						draw_set_color(c_yellow)
					}
					
					draw_sprite_ext(player_menu_box, 0, 108, 118, 424/30, 174/30, 0, c_white, 1)
					
					draw_text_transformed(140, 140, global.last_save.player.name, 2, 2, 0)
					draw_text_transformed(300, 140, string_concat(global.UI_texts.lv, " ", global.last_save.player.lv), 2, 2, 0)
					draw_text_transformed(140, 180, global.last_save.room_name, 2, 2, 0)
					draw_text_transformed(170, 240, global.UI_texts[$"save save"], 2, 2, 0)
					draw_text_transformed(350, 240, global.UI_texts[$"save return"], 2, 2, 0)
					
					draw_set_halign(fa_right)
					
					draw_text_transformed(498, 140, string_concat(global.last_save.minutes, (global.last_save.seconds >= 10) ? ":" : ":0", global.last_save.seconds), 2, 2, 0)
					
					if (player_save_cursor == 2){
						draw_set_color(c_white)
					}
				break
				default:
					var _stats_x = 32
					var _stats_y = 320
					var _box_height = 0 //Height of the box of the items, cell and stats.
					_amount_items = array_length(global.player.inventory)
					var _amount_cell = array_length(global.player.cell_options)
					var _item_color = (_amount_items > 0) ? c_white : c_gray 
					var _cell_color = (_amount_cell > 0) ? c_white : c_gray//Color of the item option.
					
					if (player_menu_top){
						_stats_y = 52
					}
					
					switch (player_menu_state){
						case PLAYER_MENU_STATE.INITIAL:
							_heart_x = 64
							_heart_y = 204 + 36*player_menu_selection[0]
						break
						case PLAYER_MENU_STATE.STATS:
							_box_height = 418
						break
						case PLAYER_MENU_STATE.INVENTORY:
							_box_height = 362
							_heart_x = 217
							_heart_y = 97 + 32*player_menu_selection[1]
						break
						case PLAYER_MENU_STATE.ITEM_SELECTED:
							_box_height = 362
							_heart_x = 217 + min(96*player_menu_selection[2], 105)*player_menu_selection[2]
							_heart_y = 377
						break
						case PLAYER_MENU_STATE.CELL:
							_box_height = 270
							_heart_x = 217
							_heart_y = 97 + 32*player_menu_selection[1]
						break
					}
				
					draw_sprite_ext(player_menu_box, 0, 32, 167, 142/30, 148/30, 0, c_white, 1) //Menu box
					draw_sprite_ext(player_menu_box, 0, _stats_x, _stats_y, 142/30, 110/30, 0, c_white, 1) //Stats box
				
					if (player_menu_state != PLAYER_MENU_STATE.INITIAL and player_menu_state != PLAYER_MENU_STATE.WAITING_DIALOG_END){
						draw_sprite_ext(player_menu_box, 0, 188, 52, 346/30, _box_height/30, 0, c_white, 1) //Multi-purpose box
				
						switch (player_menu_state){
							case PLAYER_MENU_STATE.STATS:
								_box_height = 418
								var _player_weapon = global.UI_texts.none
								var _player_armor = global.UI_texts.none
								
								if (!is_undefined(global.player.weapon) and global.player.weapon >= 0){
									var _weapon = global.item_pool[global.player.weapon]
									_player_weapon = _weapon[$"inventory name"]
								}
								
								if (!is_undefined(global.player.armor) and global.player.armor >= 0){
									var _armor = global.item_pool[global.player.armor]
									_player_armor = _armor[$"inventory name"]
								}
						
								draw_text_transformed(216, 84, "\"" + global.player.name + "\"", 2, 2, 0)
								draw_text_ext_transformed(216, 144, string_concat(global.UI_texts.lv ,"  ", global.player.lv, "\n", global.UI_texts.hp, "  ", global.player.hp, " / ", global.player.max_hp, "\n\n", global.UI_texts[$"stat attack"], "  ", global.player.atk, " (", global.player.equipped_atk, ")\n", global.UI_texts[$"stat defense"], "  ", global.player.def, " (", global.player.equipped_def, ")\n\n", global.UI_texts[$"stat weapon"], ": ", _player_weapon, "\n", global.UI_texts[$"stat armor"], ": ", _player_armor), 16, 400, 2, 2, 0)
								draw_text_ext_transformed(384, 240, string_concat(global.UI_texts[$"stat exp"], ": ", global.player.exp, "\n", global.UI_texts[$"stat next"], ": ", (is_infinity(global.player.next_exp) ? global.UI_texts.none : global.player.next_exp)), 16, 400, 2, 2, 0)
								draw_text_transformed(216, 408, string_concat(global.UI_texts[$"stat gold"], ": ", global.player.gold), 2, 2, 0)
							break
							case PLAYER_MENU_STATE.INVENTORY: case PLAYER_MENU_STATE.ITEM_SELECTED:
								_box_height = 362
								_items_string = ""
						
								for (var _i = 0; _i < _amount_items; _i++){
									var _item = global.item_pool[global.player.inventory[_i]]
									var _item_name = _item[$"inventory name"]
							
									_items_string += _item_name + "\n"
								}
						
								draw_text_ext_transformed(232, 80, _items_string, 16, 400, 2, 2, 0)
								draw_text_transformed(232, 360, global.UI_texts[$"item use"], 2, 2, 0)
								draw_text_transformed(328, 360, global.UI_texts[$"item info"], 2, 2, 0)
								draw_text_transformed(442, 360, global.UI_texts[$"item drop"], 2, 2, 0)
							break
							case PLAYER_MENU_STATE.CELL:
								_box_height = 270
								var _cell_string = ""
						
								for (var _i = 0; _i < _amount_cell; _i++){
									var _option = global.UI_texts[$"cell options"][global.player.cell_options[_i]]
							
									_cell_string += _option + "\n"
								}
						
								draw_text_ext_transformed(232, 80, _cell_string, 16, 400, 2, 2, 0)
							break
						}
					}
				
					draw_text_transformed(_stats_x + 13, _stats_y + 7, global.player.name, 2, 2, 0)
					draw_text_transformed_color(83, 187, global.UI_texts[$"menu item"], 2, 2, 0, _item_color, _item_color, _item_color, _item_color, 1)
					draw_text_transformed(83, 223, global.UI_texts[$"menu stat"], 2, 2, 0)
			
					if (global.player.cell){
						draw_text_transformed_color(83, 259, global.UI_texts[$"menu cell"], 2, 2, 0, _cell_color, _cell_color, _cell_color, _cell_color, 1)
					}
			
					draw_set_font(fnt_crypt_of_tomorrow)
			
					draw_text_ext_transformed(_stats_x + 13, _stats_y + 49, string_concat(global.UI_texts.lv, "\n", global.UI_texts.hp, "\n", global.UI_texts.gold), 9, 100, 2, 2, 0)
					draw_text_ext_transformed(_stats_x + 49, _stats_y + 49, string_concat(global.player.lv, "\n", global.player.hp, "/", global.player.max_hp, "\n", global.player.gold), 9, 100, 2, 2, 0)
				break
			}
			
			if ((player_menu_state != PLAYER_MENU_STATE.BOX or player_box_cursor[0] != -1) and (player_menu_state != PLAYER_MENU_STATE.SAVE or player_save_cursor < 2) and player_menu_state != PLAYER_MENU_STATE.WAITING_DIALOG_END and player_menu_state != PLAYER_MENU_STATE.STATS){
				draw_sprite_ext(spr_player_heart, player_heart_subimage, _heart_x, _heart_y, 1, 1, 0, player_heart_color, 1)
			}
		break
	}

	surface_reset_target()
}

if (with_border){
	if (window_get_fullscreen()){
		_game_width /= 1.125
		
		var _screen_width = resolutions_width[resolution_active]
		var _game_height = _screen_height/1.125
		var _border_width = _screen_height*(16/9)
		var _x = (_screen_width - _game_width)/2
		var _y = _screen_height*0.0625/1.125
		
		var _x_scale = _game_width/GAME_WIDTH
		var _y_scale = _game_height/GAME_HEIGHT
		
		draw_sprite_ext(spr_border, border_id, (_screen_width - _border_width)/2, 0, _border_width/1920, _screen_height/1080, 0, c_white, 1)
		draw_surface_ext(application_surface, _x, _y, _x_scale, _y_scale, 0, c_white, 1)
		
		if (_ui_not_showing){
			draw_surface_ext(ui_surface, _x, _y, _x_scale, _y_scale, 0, c_white, 1)
		}
	}else{
		var _x = (1.5*resolutions_width[resolution_active] - _game_width)/2
		var _y = _screen_height*0.0625
		var _x_scale = _game_width/GAME_WIDTH
		var _y_scale = _screen_height/GAME_HEIGHT
		
		draw_sprite_ext(spr_border, border_id, 0, 0, _screen_height*(16/9)*1.125/1920, _screen_height*1.125/1080, 0, c_white, 1)
		draw_surface_ext(application_surface, _x, _y, _x_scale, _y_scale, 0, c_white, 1)
		
		if (_ui_not_showing){
			draw_surface_ext(ui_surface, _x, _y, _x_scale, _y_scale, 0, c_white, 1)
		}
	}
}else{
	var _x = (resolutions_width[resolution_active] - _game_width)/2
	var _x_scale = _game_width/GAME_WIDTH
	var _y_scale = _screen_height/GAME_HEIGHT
	
	draw_surface_ext(application_surface, _x, 0, _x_scale, _y_scale, 0, c_white, 1)
	
	if (_ui_not_showing){
		draw_surface_ext(ui_surface, _x, 0, _x_scale, _y_scale, 0, c_white, 1)
	}
}

if (!_ui_not_showing and surface_exists(ui_surface)){
	surface_free(ui_surface)
	ui_surface = -1
}