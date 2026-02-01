function battle_apply_rewards(_sound=true){
	with (obj_game){
		global.player.gold += battle_gold
		global.player.exp += battle_exp
		global.player.next_exp -= battle_exp
		
		if (global.player.next_exp <= 0){ //Here is where the stats are applied once the EXP is met.
			if (_sound){
				audio_play_sound(snd_player_love_up, 100, false)	
			}
			
			var _stats = global.stat_levels[global.player.lv]
			
			global.player.lv++
			global.player.atk = _stats.atk
			global.player.def = _stats.def
			global.player.next_exp += _stats.next_exp
			global.player.max_hp = _stats.max_hp
			global.player.hp_bar_width = _stats.hp_bar_width
		}
		
		battle_gold = 0
		battle_exp = 0
	}
}

function battle_box_dialog(_dialogues, _x_offset=0, _face_sprite=undefined, _face_subimages=undefined){
	with (obj_game){
		battle_dialog_x_offset = _x_offset
		
		dialog.set_dialogues(_dialogues, obj_box.box_size.x/2 - 15 - _x_offset/2, 0, _face_sprite, _face_subimages)
		dialog.set_scale(2, 2)
		dialog.set_container_sprite(-1)
		dialog.set_container_tail_sprite(-1)
		dialog.set_container_tail_mask_sprite(-1)
		dialog.move_to(obj_box.x - obj_box.width/2 + 14.5 + battle_dialog_x_offset, obj_box.y - obj_box.height + 10)
		
		//By order of constant definition, BATTLE_STATE.END is the last integer that will keep the dialogs from progressing because it's the player moving in the UI or animations, the other states after that are meant that the player presses a button to advance the dialogs.
		if (battle_state <= BATTLE_STATE.END){
			dialog.can_progress = false
		}
	}
}

function battle_enemy_dialog(_enemy){
	if (typeof(_enemy.next_dialog) == "array"){
		_enemy.next_dialog[0] = "[font:" + string(int64(fnt_monster)) + "][color_rgb:0,0,0][asterisk:false]" + _enemy.next_dialog[0]
	}else{
		_enemy.next_dialog = "[font:" + string(int64(fnt_monster)) + "][color_rgb:0,0,0][asterisk:false]" + _enemy.next_dialog
	}
	
	var _dialog = new DisplayDialog(_enemy.x + _enemy.bubble_x, _enemy.y + _enemy.bubble_y, _enemy.next_dialog, _enemy.bubble_width, 0, 1, 1,,,, _enemy.bubble_sprite, _enemy.bubble_tail_sprite, _enemy.bubble_tail_mask_sprite)
	
	_enemy.next_dialog = undefined
	
	array_push(battle_enemies_dialogs, _dialog)
}

function battle_forgive_enemy(_index){
	var _enemy = global.battle_enemies[_index]
	if (!is_undefined(_enemy.destroy)){
		_enemy.destroy()
	}
	
	if (!is_undefined(_enemy.forgiven)){
		_enemy.forgiven()
	}
	
	audio_play_sound(snd_enemie_vanish, 100, false)
	array_push(obj_game.battle_cleared_enemies, _enemy)
	
	var _length = irandom_range(7, 12)
	for (var _i=0; _i<_length; _i++){
		var _width = sprite_get_width(_enemy.sprite_spared)
		var _height = sprite_get_height(_enemy.sprite_spared)
		var _offset_x = (_width/2 - sprite_get_xoffset(_enemy.sprite_spared))*_enemy.sprite_xscale
		var _offset_y = (_height/2 - sprite_get_yoffset(_enemy.sprite_spared))*_enemy.sprite_yscale
		var _range_x = _width*_enemy.sprite_xscale/2
		var _range_y = _height*_enemy.sprite_yscale/2
		var _x = irandom_range(-_range_x, _range_x)
		var _y = irandom_range(-_range_y, _range_y)
		var _direction = point_direction(0, 0, _x, _y)
		
		array_push(obj_game.battle_dust_clouds, {timer: 0, x: _enemy.x + _offset_x + _x, y: _enemy.y + _offset_y + _y, direction: _direction, distance: min(point_distance(0, 0, _x, _y)/point_distance(0, 0, dcos(_direction)*_range_x, -dsin(_direction)*_range_y), 1)})
	}
	
	obj_game.battle_gold += _enemy.give_gold_on_spared
	
	global.battle_enemies[_index] = undefined
}

function battle_kill_enemy(_index){
	var _enemy = global.battle_enemies[_index]
	if (!is_undefined(_enemy.destroy)){
		_enemy.destroy()
	}
	
	if (!is_undefined(_enemy.killed)){
		_enemy.killed()
	}
	
	audio_play_sound(snd_enemie_vanish, 100, false)
	array_push(obj_game.battle_cleared_enemies, _enemy)
	
	_enemy.last_animation_timer = 0
	obj_game.battle_gold += _enemy.give_gold_on_kill
	obj_game.battle_exp += _enemy.give_exp
	
	global.battle_enemies[_index] = undefined
}

function battle_box_resize(_x, _y){
	with (obj_box){
		box_size.x = _x
		box_size.y = _y
	}
}

function battle_box_move_to(_x, _y){
	with (obj_box){
		box_position.x = _x
		box_position.y = _y
	}	
}

function death_reset(){
	perform_game_load()
	
	return 0
}

function battle_go_to_state(_state, _enemy=undefined, _prev_state=undefined){
	with (obj_game){
		if (!is_undefined(battle_only_attack)){
			return
		}
		battle_state = _state

		switch (_state){
			case BATTLE_STATE.PLAYER_BUTTONS:
				battle_options_amount = array_length(battle_button_order)
				
				var _length = array_length(global.battle_enemies)
				var _enemies_still_available = false
				for (var _i=0; _i<_length; _i++){
					_enemy = global.battle_enemies[_i]
					
					if (is_undefined(_enemy)){
						continue
					}
					
					if (!is_undefined(_enemy.turn_starts)){
						_enemy.turn_starts()
					}
					
					if (_enemy.hp <= 0){
						battle_kill_enemy(_i)
					}else if (_enemy.spared){
						battle_forgive_enemy(_i)
					}else{
						_enemies_still_available = true
					}
				}
				
				if (_enemies_still_available){
					battle_box_dialog(battle_current_box_dialog)
				}else{
					battle_go_to_state(BATTLE_STATE.PLAYER_WON)
				}
			break
			case BATTLE_STATE.PLAYER_ENEMY_SELECT:
				if (_prev_state != BATTLE_STATE.PLAYER_ACT){
					battle_selection[1] = 0
				}
				battle_options_amount = 0
				
				_length = array_length(battle_selectable_enemies)
				for (var _i=0; _i<_length; _i++){
					array_pop(battle_selectable_enemies)
				}
				
				_length = array_length(global.battle_enemies)
				for (var _i=0; _i<_length; _i++){
					_enemy = global.battle_enemies[_i]
					
					if (_enemy.selectionable){
						battle_options_amount++
						
						array_push(battle_selectable_enemies, _enemy)
					}
				}
				
				var _text = "[skip:false][asterisk:false]   "
				
				if (battle_options_amount == 0){
					_text += "[color_rgb:127,127,127]* " + global.UI_texts[$"battle no enemy"]
				}else{
					_length = array_length(battle_selectable_enemies)
					for (var _i=0; _i<_length; _i++){
						_enemy = battle_selectable_enemies[_i]
					
						if (is_undefined(_enemy)){
							continue
						}
					
						if (_enemy.can_spare){
							_text += "[color_rgb:255,255,0]* " + _enemy.name + "[color_rgb:255,255,255]"
						}else{
							_text += "* " + _enemy.name
						}
					
						if (_i + 1 < _length){
							_text += "\r   "
						}
					}
				}
				
				battle_box_dialog(_text)
			break
			case BATTLE_STATE.PLAYER_ATTACK:
				dialog.next_dialog(false)
				
				obj_player_battle.image_alpha = 0
				battle_box_resize(565, 130)
				
				battle_player_attack = new player_attack(global.player.weapon, _enemy)
			break
			case BATTLE_STATE.PLAYER_ACT:
				battle_selection[2] = 0
				battle_options_amount = array_length(_enemy.act_commands)
				
				_text = "[skip:false][asterisk:false]   "
				if (battle_options_amount == 0){
					_text += "[color_rgb:127,127,127]* " + global.UI_texts[$"battle no acts"]
				}else{
					for (var _i=0; _i<battle_options_amount; _i++){
						var _act_command = global.UI_texts[$"battle acts"][_enemy.act_commands[_i]]
						_text += "* " + _act_command + string_repeat(" ", max(11 - string_length(_act_command), 0))
					
						if ((_i + 1)%2 == 0){
							_text += "\n   "
						}
					}
				}
				
				battle_box_dialog(_text)
			break
			case BATTLE_STATE.PLAYER_ITEM:
				battle_selection[2] = 0
				
				var _amount_items = array_length(global.player.inventory)
				if (_amount_items > 0){
					_text = "[skip:false][asterisk:false]"
					battle_item_page = min(battle_item_page, ceil(_amount_items/4))
					
					var _page_index = battle_item_page - 1
					for (var _i=4*_page_index; _i<min(_amount_items, 4*battle_item_page); _i++){
						var _item_name = undefined
						if (global.battle_serious_mode){
							_item_name = global.item_pool[global.player.inventory[_i]][$"serious name"]
							
							if (is_undefined(_item_name)){
								_item_name = global.item_pool[global.player.inventory[_i]][$"short name"]
							}
						}else{
							_item_name = global.item_pool[global.player.inventory[_i]][$"short name"]
						}
						
						if (is_undefined(_item_name)){
							_item_name = global.item_pool[global.player.inventory[_i]][$"inventory name"]
						}
						
						_text += "   * " + _item_name + string_repeat(" ", max(11 - string_length(_item_name), 0))
						
						if ((_i + 1)%2 == 0){
							_text += "\n"
						}
					}
					
					_text += string_repeat("\n", ceil((4 - (min(_amount_items, 4*battle_item_page) - 4*_page_index))/2)) + string_repeat(" ", 21) + "PAGE " + string(battle_item_page)
					
					battle_box_dialog(_text)
				}else{
					var _randmsg = global.UI_texts[$"no items"]
					if (global.battle_serious_mode){
						_randmsg = _randmsg.serious
					}else{
						_randmsg = _randmsg.normal
					}
					
					var _msg = _randmsg[irandom(array_length(_randmsg) - 1)]
					_text = "[skip:false][color_rgb:127,127,127][apply_to_asterisk]" + _msg
					
					battle_box_dialog(_text, 48)
				}
			break
			case BATTLE_STATE.PLAYER_MERCY:
				battle_selection[1] = 0
				battle_options_amount = 1 + battle_can_flee
				
				var _can_spare = false
				_length = array_length(global.battle_enemies)
				for (var _i=0; _i<_length; _i++){
					_enemy = global.battle_enemies[_i]
					
					if (is_undefined(_enemy)){
						continue
					}
					
					if (_enemy.can_spare){
						_can_spare = true
						
						break
					}
				}
				
				_text = "[skip:false][asterisk:false]"
				if (_can_spare){
					_text += "   [color_rgb:255,255,0]* " + global.UI_texts[$"battle spare"] + "[color_rgb:255,255,255]"
				}else{
					_text += "   * " + global.UI_texts[$"battle spare"]
				}
				
				if (battle_can_flee){
					_text += "\r   * " + global.UI_texts[$"battle flee"]
				}
				
				battle_box_dialog(_text)
			break
			case BATTLE_STATE.PLAYER_WON:
				battle_box_resize(565, 130)
				battle_box_move_to(320, 390)
				
				obj_player_battle.image_alpha = 0
				
				var _victory_text = string_replace(string_replace(global.UI_texts[$"battle won"], "[ExpWon]", battle_exp), "[GoldWon]", battle_gold)
				
				if (global.player.next_exp - battle_exp <= 0){
					_victory_text += "\n" + global.UI_texts[$"battle love up"]
				}
				
				battle_apply_rewards()
				battle_box_dialog(_victory_text)
			break
			case BATTLE_STATE.PLAYER_FLEE:
				obj_player_battle.sprite_index = spr_player_heart_run_away
				obj_player_battle.image_index = 0
				
				//By default a dialog is given to you and if the flee was successful as well, you can do whatever you want with it on the flee event if you desire a different dialog and outcome.
				var _success = (irandom(99) <= battle_flee_chance)
				var _flee_dialog = global.UI_texts[$"battle flee dialogs"]
				_flee_dialog = _flee_dialog[irandom(array_length(_flee_dialog) - 1)]
				
				if (_success){
					if (battle_exp > 0 or battle_gold > 0){
						_flee_dialog += "\n" + string_replace(string_replace(global.UI_texts[$"battle flee earning"], "[ExpWon]", battle_exp), "[GoldWon]", battle_gold)
						
						if (global.player.next_exp - battle_exp <= 0){
							_flee_dialog += "\n" + global.UI_texts[$"battle love up"]
						}
						
						battle_apply_rewards()
					}
					
					battle_flee_chance = max(battle_flee_chance - 30, 0)
				}else{
					battle_flee_chance = min(battle_flee_chance + 10, 100)
				}
				
				battle_box_dialog("[skip:false]" + _flee_dialog)
				
				_length = array_length(global.battle_enemies)
				for (var _i=0; _i<_length; _i++){
					_enemy = global.battle_enemies[_i]
					
					if (is_undefined(_enemy)){
						continue
					}
					
					if (!is_undefined(_enemy.flee)){
						_enemy.flee()
					}
				}
				
				battle_flee_event = new flee_event(battle_flee_event_type, _success)
				
				if (battle_flee_event.is_finished){
					battle_go_to_state(BATTLE_STATE.ENEMY_DIALOG)
				}
			break
			case BATTLE_STATE.PLAYER_DIALOG_RESULT:
				obj_player_battle.image_alpha = 0
				
				switch (_prev_state){
					case BATTLE_STATE.PLAYER_ACT:
						var _dialog = _enemy.act(_enemy.act_commands[battle_selection[2]])
						
						if (!is_undefined(_dialog)){
							battle_box_dialog(_dialog)
						}else{
							dialog.next_dialog(false)
						}
					break
					case BATTLE_STATE.PLAYER_ITEM:
						_dialog = use_item(battle_selection[2] + 4*(battle_item_page - 1)) //This returns an array of the dialog and the item index that it was, don't get confused by the name of the variable.
						var _item_index = _dialog[1]
						_dialog = _dialog[0] //It eventually holds the dialog only.
						
						_length = array_length(global.battle_enemies)
						for (var _i=0; _i<_length; _i++){
							_enemy = global.battle_enemies[_i]
							
							if (is_undefined(_enemy)){
								continue
							}
							
							if (!is_undefined(_enemy.item_used)){
								_enemy.item_used(_item_index)
							}
						}
						
						battle_box_dialog(_dialog)
					break
					case BATTLE_STATE.PLAYER_MERCY:
						dialog.next_dialog(false)
						
						_length = array_length(global.battle_enemies)
						for (var _i=0; _i<_length; _i++){
							_enemy = global.battle_enemies[_i]
							
							if (is_undefined(_enemy)){
								continue
							}
							
							if (!is_undefined(_enemy.spare)){
								_enemy.spare()
							}
							
							if (_enemy.can_spare){
								_enemy.spared = true
							}
						}
					break
				}
				
				_length = array_length(battle_enemies_dialogs)
				for (var _i=0; _i<_length; _i++){
					if (battle_enemies_dialogs[_i].is_finished()){
						array_delete(battle_enemies_dialogs, _i, 1)
						
						_i--
						_length--
					}
				}
				
				if (dialog.is_finished()){
					battle_go_to_state(BATTLE_STATE.ENEMY_DIALOG)
				}
			break
			case BATTLE_STATE.ENEMY_DIALOG:
				_length = array_length(battle_enemies_dialogs)
				if (_length){
					array_delete(battle_enemies_dialogs, 0, _length)
				}
				
				battle_box_resize(155, 130)
				
				dialog.next_dialog(false)
				
				_length = array_length(global.battle_enemies)
				for (var _i=0; _i<_length; _i++){
					_enemy = global.battle_enemies[_i]
					
					if (is_undefined(_enemy)){
						continue
					}
					
					if (!is_undefined(_enemy.dialog_starts)){
						_enemy.dialog_starts()
					}
					
					if (!is_undefined(_enemy.next_dialog)){
						battle_enemy_dialog(_enemy)
					}else if (_enemy.hp <= 0){
						battle_kill_enemy(_i)
					}else if (_enemy.spared){
						battle_forgive_enemy(_i)
					}
				}
				
				with (obj_player_battle){
					sprite_index = spr_player_heart
					image_alpha = 1
					image_index = other.player_heart_subimage
					x = obj_box.x
					y = obj_box.y - round(obj_box.height)/2 - 5
				}
				
				if (array_length(battle_enemies_dialogs) == 0){ //No enemie wants to speak, then it just attacks.
					battle_go_to_state(BATTLE_STATE.ENEMY_ATTACK)
				}
			break
			case BATTLE_STATE.ENEMY_ATTACK:
				array_delete(battle_enemies_dialogs, 0, array_length(battle_enemies_dialogs))
				array_delete(battle_enemies_attacks, 0, array_length(battle_enemies_attacks))
				
				var _enemy_attack = false
				var _enemies_count = array_length(global.battle_enemies)
				_enemies_still_available = false
				for (var _i=0; _i<_enemies_count; _i++){
					_enemy = global.battle_enemies[_i]
				
					if (is_undefined(_enemy)){
						continue
					}
				
					if (!is_undefined(_enemy.attack_starts)){
						_enemy.attack_starts()
					}
				
					if (!is_undefined(_enemy.next_attack)){
						_enemies_still_available = true
						_enemy_attack = true
					
						array_push(battle_enemies_attacks, new enemy_attack(_enemy.next_attack, _i))
					}else if (_enemy.hp <= 0){
						battle_kill_enemy(_i)
					}else if (_enemy.spared){
						battle_forgive_enemy(_i)
					}else{
						_enemies_still_available = true
					}
				}
				
				if (!_enemies_still_available){
					battle_go_to_state(BATTLE_STATE.PLAYER_WON)
				}else if (!_enemy_attack){
					array_push(battle_enemies_attacks, new enemy_attack(ENEMY_ATTACK.SPARE, 0))
				}
			break
			case BATTLE_STATE.TURN_END:
				battle_box_resize(565, 130)
				battle_box_move_to(320, 390)
				
				obj_player_battle.image_alpha = 0
				
				_length = array_length(battle_bullets)
				for (var _i=0; _i<_length; _i++){
					var _bullet = battle_bullets[_i]
					
					if (instance_exists(_bullet)){
						instance_destroy(_bullet)
					}
					
					array_delete(battle_bullets, _i, 1)
					_i--
					_length--
				}
				
				//Some people may want their enemy spared or dead after an attack, therefor they must set the data before the attack ends, luckily enemies have a function that executes when an attack ends.
				_enemies_count = array_length(global.battle_enemies)
				_enemies_still_available = false
				var _enemy_dialog = false
				for (var _i=0; _i<_enemies_count; _i++){
					_enemy = global.battle_enemies[_i]
					
					if (is_undefined(_enemy)){
						continue
					}
					
					if (!is_undefined(_enemy.turn_ends)){
						_enemy.turn_ends()
					}
					
					if (!is_undefined(_enemy.next_dialog)){
						_enemies_still_available = true
						_enemy_dialog = true
						
						battle_enemy_dialog(_enemy)
					}else if (_enemy.hp <= 0){
						battle_kill_enemy(_i)
					}else if (_enemy.spared){
						battle_forgive_enemy(_i)
					}else{
						_enemies_still_available = true
					}
				}
				
				if (!_enemies_still_available){
					battle_go_to_state(BATTLE_STATE.PLAYER_WON)
				}else if (!_enemy_dialog){
					battle_go_to_state(BATTLE_STATE.PLAYER_BUTTONS)
				}
			break
			case BATTLE_STATE.END:
				if (!is_undefined(battle_end_function)){
					start_room_function = function(){
						var _killed_enemies = []
						var _spared_enemies = []
					
						var _length = array_length(battle_cleared_enemies)
						for (var _i=0; _i<_length; _i++){
							var _enemy = battle_cleared_enemies[_i]
						
							if (_enemy.hp <= 0){
								array_push(_killed_enemies, _enemy)
							}else{
								array_push(_spared_enemies, _enemy)
							}
						}
					
						battle_end_function(global.battle_enemies, _killed_enemies, _spared_enemies, battle_fled)
						battle_end_function = undefined
						
						_length = array_length(global.battle_enemies)
						for (var _i=_length - 1; _i>=0; _i--){
							var _enemy = global.battle_enemies[_i]
							if (!is_undefined(_enemy.destroy)){
								_enemy.destroy()
							}
							array_pop(global.battle_enemies)
						}
			
						_length = array_length(battle_cleared_enemies)
						for (var _i=0; _i<_length; _i++){
							array_pop(battle_cleared_enemies)
						}
					}
				}
				
				anim_timer = 0
				battle_apply_rewards(false)
			break
		}
	}
}