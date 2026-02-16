//Keyboard controls handler, if you don't understand it, I recommend not to touch it, don't even look at it... well ok you can in an attempt to understand, my bad, sorry...
switch (control_type){
	case CONTROL_TYPE.MAPPING_CONTROLLER:
		switch (controller_mapping_state){
			case CONTROLLER_MAPPING.WAITING_ENTER: //make macros for this in scr_init.
				if (keyboard_check_pressed(vk_enter)){
					controller_mapping_state = CONTROLLER_MAPPING.GET_CONFIRM
				}
			break
			case CONTROLLER_MAPPING.GET_CONFIRM:
				var _button_z = get_controller_button_pressed(controller_id)
				
				if (_button_z != -1){
					controller_confirm_button = _button_z
					controller_mapping_state = CONTROLLER_MAPPING.GET_CANCEL
				}
			break
			case CONTROLLER_MAPPING.GET_CANCEL:
				var _button_x = get_controller_button_pressed(controller_id)
				
				if (_button_x != -1){
					controller_cancel_button = _button_x
					controller_mapping_state = CONTROLLER_MAPPING.GET_MENU
				}
			break
			case CONTROLLER_MAPPING.GET_MENU:
				var _button_c = get_controller_button_pressed(controller_id)
				
				if (_button_c != -1){
					controller_menu_button = _button_c
					controller_mapping_state = CONTROLLER_MAPPING.DONE
					control_type = CONTROL_TYPE.CONTROLLER
					save_controller_config(controller_id)
				}
			break
		}
		
		global.up_button = 0
		global.left_button = 0
		global.down_button = 0
		global.right_button = 0
		global.confirm_button = 0
		global.cancel_button = 0
		global.menu_button = 0
		
		global.up_hold_button = 0
		global.left_hold_button = 0
		global.down_hold_button = 0
		global.right_hold_button = 0
		global.confirm_hold_button = 0
		global.cancel_hold_button = 0
		global.menu_hold_button = 0
	break
	case CONTROL_TYPE.KEYBOARD:
		global.up_button = (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up))
		global.left_button = (keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left))
		global.down_button = (keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down))
		global.right_button = (keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right))
		global.confirm_button = (keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter))
		global.cancel_button = (keyboard_check_pressed(ord("X")) or keyboard_check_pressed(vk_shift))
		global.menu_button = (keyboard_check_pressed(ord("C")) or keyboard_check_pressed(vk_control))
		
		global.up_hold_button = (keyboard_check(ord("W")) or keyboard_check(vk_up))
		global.left_hold_button = (keyboard_check(ord("A")) or keyboard_check(vk_left))
		global.down_hold_button = (keyboard_check(ord("S")) or keyboard_check(vk_down))
		global.right_hold_button = (keyboard_check(ord("D")) or keyboard_check(vk_right))
		global.confirm_hold_button = (keyboard_check(ord("Z")) or keyboard_check(vk_enter))
		global.cancel_hold_button = (keyboard_check(ord("X")) or keyboard_check(vk_shift))
		global.menu_hold_button = (keyboard_check(ord("C")) or keyboard_check(vk_control))
	break
	case CONTROL_TYPE.CONTROLLER:
		var _axislv = gamepad_axis_value(controller_id, gp_axislv)
		var _axislh = gamepad_axis_value(controller_id, gp_axislh)
		var _axislv_round = round(_axislv)
		var _axislh_round = round(_axislh)
		var _padd = gamepad_button_check(controller_id, gp_padd)
		var _padl = gamepad_button_check(controller_id, gp_padl)
		var _padu = gamepad_button_check(controller_id, gp_padu)
		var _padr = gamepad_button_check(controller_id, gp_padr)
		var _up_button = max(-_axislv_round, _padd, 0)
		var _left_button = max(-_axislh_round, _padl, 0)
		var _down_button = max(_axislv_round, _padu, 0)
		var _right_button = max(_axislh_round, _padr, 0)
		
		if (temp_up_button == _up_button){
			global.up_button = 0
		}else{
			temp_up_button = _up_button
			
			global.up_button = _up_button
		}
		
		if (temp_down_button == _down_button){
			global.down_button = 0
		}else{
			temp_down_button = _down_button
			
			global.down_button = _down_button
		}
		
		if (temp_left_button == _left_button){
			global.left_button = 0
		}else{
			temp_left_button = _left_button
			
			global.left_button = _left_button
		}
		
		if (temp_right_button == _right_button){
			global.right_button = 0
		}else{
			temp_right_button = _right_button
			
			global.right_button = _right_button
		}
		
		global.up_hold_button = max(-_axislv, _padd, 0)
		global.left_hold_button = max(-_axislh, _padl, 0)
		global.down_hold_button = max(_axislv, _padu, 0)
		global.right_hold_button = max(_axislh, _padr, 0)
		
		if (controller_mapping_state == CONTROLLER_MAPPING.DONE){
			global.confirm_button = gamepad_button_check_pressed(controller_id, controller_confirm_button)
			global.cancel_button = gamepad_button_check_pressed(controller_id, controller_cancel_button)
			global.menu_button = gamepad_button_check_pressed(controller_id, controller_menu_button)
			
			global.confirm_hold_button = gamepad_button_check(controller_id, controller_confirm_button)
			global.cancel_hold_button = gamepad_button_check(controller_id, controller_cancel_button)
			global.menu_hold_button = gamepad_button_check(controller_id, controller_menu_button)
		}else{
			global.confirm_button = gamepad_button_check_pressed(controller_id, gp_face2)
			global.cancel_button = gamepad_button_check_pressed(controller_id, gp_face1)
			global.menu_button = gamepad_button_check_pressed(controller_id, gp_face4)
			
			global.confirm_hold_button = gamepad_button_check(controller_id, gp_face2)
			global.cancel_hold_button = gamepad_button_check(controller_id, gp_face1)
			global.menu_hold_button = gamepad_button_check(controller_id, gp_face4)
		}
	break
	//If you want to add more type of controls or variantions of the previous ones add them as cases and define their macros in scr_init.
	//After that set the control_type variable on the Create event of this object to the initial control type or handle its connection and disconnection in the corresponding place.
}

global.escape_button = keyboard_check_pressed(vk_escape) //Exclusive to keyboard.
global.escape_hold_button = keyboard_check(vk_escape) //Exclusive to keyboard.

if (keyboard_check_pressed(ord("V"))){
	perform_game_load()
}

//Little system that sets the equipped atk, equipped def and invulnerability frames.
if (global.player.prev_weapon != global.player.weapon or global.player.prev_armor != global.player.armor){
	global.player.prev_weapon = global.player.weapon
	global.player.prev_armor = global.player.armor
	
	global.player.equipped_atk = 0
	global.player.equipped_def = 0
	global.player.invulnerability_frames = PLAYER_BASE_INVULNERABILITY_FRAMES
	
	var _weapon = global.item_pool[global.player.weapon]

	global.player.equipped_atk += ((is_undefined(_weapon[$"atk"])) ? 0 : _weapon[$"atk"])
	global.player.equipped_def += ((is_undefined(_weapon[$"def"])) ? 0 : _weapon[$"def"])
	global.player.invulnerability_frames += ((is_undefined(_weapon[$"inv_frames"])) ? 0 : _weapon[$"inv_frames"])
	
	var _armor = global.item_pool[global.player.armor]
	
	global.player.equipped_atk += ((is_undefined(_armor[$"atk"])) ? 0 : _armor[$"atk"])
	global.player.equipped_def += ((is_undefined(_armor[$"def"])) ? 0 : _armor[$"def"])
	global.player.invulnerability_frames += ((is_undefined(_armor[$"inv_frames"])) ? 0 : _armor[$"inv_frames"])
}

if (global.player.hp <= 0 and state != GAME_STATE.GAME_OVER){
	trigger_game_over()
}

switch (state){
	case GAME_STATE.GAME_OVER: {
		game_over_timer++
		
		switch (game_over_timer){
			case 75:
				audio_play_sound(snd_player_heart_break, 100, false)
			break
			case 150:
				audio_play_sound(snd_player_heart_shatter, 100, false)
				
				for (var _i=0; _i<6; _i++){
					array_push(game_over_shards, {x: game_over_heart_x, y: game_over_heart_y, x_speed: irandom_range(-40, 40), y_speed: irandom(40)})
				}
			break
			case 225:
				audio_play_sound(game_over_music, 100, true)
			break
			case 350:
				dialog.set_dialogues(game_over_dialog, 170)
				dialog.set_scale(2, 2)
				dialog.set_container_sprite(undefined)
				dialog.set_container_tail_sprite(undefined)
				dialog.set_container_tail_mask_sprite(undefined)
				dialog.move_to(150, 340)
			break
			case 351:
				if (!dialog.is_finished()){
					game_over_timer--
				}
			break
			case 352:
				if (!global.confirm_button){
					game_over_timer--	
				}else{
					audio_sound_gain(game_over_music, 0, 1333)
				}
			break
			case 472:
				if (room == rm_battle){
					var _length = array_length(global.battle_enemies)
					for (var _i=0; _i<_length; _i++){
						array_pop(global.battle_enemies)
					}
					
					_length = array_length(battle_enemies_dialogs)
					for (var _i=0; _i<_length; _i++){ //This one already got cleared before getting here, but just in case somehow something trigger as you're still in the battle room, clear it again.
						array_pop(battle_enemies_dialogs)
					}
				
					_length = array_length(battle_cleared_enemies)
					for (var _i=0; _i<_length; _i++){
						array_pop(battle_cleared_enemies)
					}
				
					_length = array_length(battle_dust_clouds)
					for (var _i=0; _i<_length; _i++){
						array_pop(battle_dust_clouds)
					}
					
					start_room_function = death_reset
				
					room_goto(player_prev_room)
				}else{
					perform_game_load()
				}
			break
			case 492:
				state = GAME_STATE.PLAYER_CONTROL
			break
		}
		
		var _length = array_length(game_over_shards)
		for (var _i=0; _i<_length; _i++){
			var _shard = game_over_shards[_i]
			
			_shard.x += _shard.x_speed/10
			_shard.y -= _shard.y_speed/10
			_shard.y_speed--
			
			if (_shard.y > 490){
				array_delete(game_over_shards, _i, 1)
				_i--
				_length--
			}
		}
	break }
	case GAME_STATE.BATTLE: { //You're already in the battle room when in this state, if not then errors may happen.
		depth = battle_player_stats.depth
		
		if (battle_state != BATTLE_STATE.START and battle_state != BATTLE_STATE.START_DODGE_ATTACK){
			if (is_battle_only_attack_undefined){
				var _length = array_length(global.battle_enemies)
				for (var _i=0; _i<_length; _i++){
					var _enemy = global.battle_enemies[_i]
				
					if (is_undefined(_enemy)){
						array_delete(global.battle_enemies, _i, 1)
					
						_i--
						_length--
					
						continue
					}
				
					if (!is_undefined(_enemy.update)){
						_enemy.update()
					}
				}
				
				_length = array_length(battle_cleared_enemies)
				for (var _i=0; _i<_length; _i++){
					var _enemy = battle_cleared_enemies[_i]
			
					if (!_enemy.spared and _enemy.last_animation_timer < sprite_get_height(_enemy.sprite_killed)){
						var _dust_pixels = _enemy.last_animation_timer
						var _offset_x = sprite_get_xoffset(_enemy.sprite_killed)
						var _offset_y = sprite_get_yoffset(_enemy.sprite_killed)
				
						array_push(battle_enemies_parts, {sprite: _enemy.sprite_killed, sprite_index: _enemy.sprite_killed_index, part: _enemy.last_animation_timer, x: _enemy.x - _offset_x, y: _enemy.y + (_dust_pixels - _offset_y)*_enemy.sprite_yscale, xscale: _enemy.sprite_xscale, yscale: _enemy.sprite_yscale, direction: irandom_range(60, 120), alpha: 1})
				
						_enemy.last_animation_timer++
					}
				}
		
				_length = array_length(battle_enemies_parts)
				for (var _i=0; _i<_length; _i++){
					var _part = battle_enemies_parts[_i]
			
					_part.alpha -= 0.05
					var _movement = 2 - _part.alpha
					_part.x += _movement*dcos(_part.direction)
					_part.y -= _movement*dsin(_part.direction)
			
					if (_part.alpha <= 0){
						array_delete(battle_enemies_parts, _i, 1)
				
						_i--
						_length--
					}
				}
		
				_length = array_length(battle_dust_clouds)
				for (var _i=0; _i<_length; _i++){
					var _dust = battle_dust_clouds[_i]
			
					_dust.timer++
					_dust.x += 2*_dust.distance*dcos(_dust.direction)
					_dust.y -= 2*_dust.distance*dsin(_dust.direction)
			
					if (_dust.timer >= 15){
						array_delete(battle_dust_clouds, _i, 1)
				
						_i--
						_length--
					}
				}
		
				_length = array_length(battle_damage_text)
				for (var _i=0; _i<_length; _i++){
					var _text = battle_damage_text[_i]
			
					_text.timer++
			
					if (_text.timer >= 90){
						array_delete(battle_damage_text, _i, 1)
				
						_i--
						_length--
					}
				}
			}
			
			var _length = array_length(battle_bullets)
			for (var _i=0; _i<_length; _i++){
				var _bullet = battle_bullets[_i]
				
				if (!instance_exists(_bullet)){
					array_delete(battle_bullets, _i, 1)
					_i--
					_length--
				}
			}
		}
		
		switch (battle_state){
			case BATTLE_STATE.START:{
				battle_exp = 0
				battle_gold = 0
				battle_flee_event_type = FLEE_EVENT.IMPROVED
				battle_fled = false
				battle_button_order = [btn_fight, btn_act, btn_item, btn_mercy]
				
				var _length = array_length(global.battle_enemies)
				var _x = 640/(_length + 1)
				_to_check = []
				
				for (var _i=0; _i<_length; _i++){
					var _enemy = new enemy(global.battle_enemies[_i], _x*(_i + 1), 240)
					_enemy.name = string_trim(_enemy.name)
				
					array_push(_to_check, _i)
				
					global.battle_enemies[_i] = _enemy
				}
				
				for (var _i=0; _i<_length - 1; _i++){
					var _count = 0
					var _enemy_1 = global.battle_enemies[_to_check[_i]]
					
					for (var _j=_i + 1; _j<_length; _j++){
						var _enemy_2 = global.battle_enemies[_to_check[_j]]
					
						if (_enemy_1.name == _enemy_2.name){
							_enemy_2.name += string_concat(" ", chr(66 + _count)) //Starts at B the chr()
							_count++
						
							array_delete(_to_check, _j, 1)
							_j--
							_length--
						}
					}
					
					if (_count > 0){
						_enemy_1.name += " A"
					}
				}
			}
			case BATTLE_STATE.START_DODGE_ATTACK:{
				with (obj_player_battle){
					x = other.battle_start_animation_player_heart_x
					y = other.battle_start_animation_player_heart_y
				}
				
				is_battle_only_attack_undefined = is_undefined(battle_only_attack)
				if (!is_undefined(battle_init_function)){
					battle_init_function()
					battle_init_function = undefined
				}
				
				if (battle_state == BATTLE_STATE.START and is_battle_only_attack_undefined){
					battle_go_to_state(BATTLE_STATE.PLAYER_BUTTONS)
				}else if (!is_battle_only_attack_undefined){
					battle_state = BATTLE_STATE.ENEMY_ATTACK
					
					with (obj_battle_button){
						instance_destroy()
					}
					
					//Just in case you decided to populate these, won't allow it
					var _length = array_length(battle_enemies_dialogs)
					if (_length){
						array_delete(battle_enemies_dialogs, 0, _length)
					}
					_length = array_length(battle_enemies_attacks)
					if (_length){
						array_delete(battle_enemies_attacks, 0, _length)
					}
					
					if (typeof(battle_only_attack) == "array"){
						_length = array_length(battle_only_attack)
						for (var _i=0; _i<_length; _i++){
							array_push(battle_enemies_attacks, new enemy_attack(battle_only_attack[_i], 0))
						}
					}else{
						array_push(battle_enemies_attacks, new enemy_attack(battle_only_attack, 0))
					}
					
					with (obj_player_battle){
						x = obj_box.x
						y = obj_box.y - round(obj_box.height)/2 - 5
					}
					
					with (obj_box){
						width = box_size.x
						height = box_size.y
					}
				}
			break}
			case BATTLE_STATE.PLAYER_BUTTONS:{
				var _length = array_length(battle_enemies_dialogs)
				for (var _i=0; _i<_length; _i++){
					var _dialog = battle_enemies_dialogs[_i]
					_dialog.step()
				}
				
				if (global.left_button){
					audio_play_sound(snd_menu_selecting, 0, false)
					
					battle_selection[0]--
					
					if (battle_selection[0] <= -1){
						battle_selection[0] += battle_options_amount
					}
				}
				
				if (global.right_button){
					audio_play_sound(snd_menu_selecting, 0, false)
					
					battle_selection[0]++
					
					if (battle_selection[0] >= battle_options_amount){
						battle_selection[0] -= battle_options_amount
					}
				}
				
				var _button = battle_button_order[battle_selection[0]]
				
				if (global.confirm_button){
					audio_play_sound(snd_menu_confirm, 0, false)
					
					switch (_button.button_type){
						case BUTTON.MERCY:
							battle_go_to_state(BATTLE_STATE.PLAYER_MERCY)
						break
						case BUTTON.ITEM:
							battle_go_to_state(BATTLE_STATE.PLAYER_ITEM)
						break
						case BUTTON.ACT:
							battle_go_to_state(BATTLE_STATE.PLAYER_ENEMY_SELECT)
						break
						case BUTTON.FIGHT:
							battle_go_to_state(BATTLE_STATE.PLAYER_ENEMY_SELECT)
						break
					}	
				}
				
				with (obj_player_battle){
					image_alpha = 1
					x = _button.x + _button.heart_button_position_x
					y = _button.y + _button.heart_button_position_y
				}
			break}
			case BATTLE_STATE.PLAYER_ENEMY_SELECT: case BATTLE_STATE.PLAYER_MERCY:{
				var _length = array_length(battle_enemies_dialogs)
				for (var _i=0; _i<_length; _i++){
					var _dialog = battle_enemies_dialogs[_i]
					_dialog.step()
				}
				
				if (battle_options_amount > 0){
					if (global.up_button){
						audio_play_sound(snd_menu_selecting, 0, false)
					
						battle_selection[1]--
					
						if (battle_selection[1] <= -1){
							battle_selection[1] += battle_options_amount
						}
					}
				
					if (global.down_button){
						audio_play_sound(snd_menu_selecting, 0, false)
					
						battle_selection[1]++
					
						if (battle_selection[1] >= battle_options_amount){
							battle_selection[1] -= battle_options_amount
						}
					}
				
					if (global.confirm_button){
						audio_play_sound(snd_menu_confirm, 0, false)
					
						if (battle_state == BATTLE_STATE.PLAYER_ENEMY_SELECT){
							var _enemy = battle_selectable_enemies[battle_selection[1]]
							switch (battle_button_order[battle_selection[0]].button_type){
								case BUTTON.FIGHT:
									battle_go_to_state(BATTLE_STATE.PLAYER_ATTACK, _enemy)
								break
								case BUTTON.ACT:
									battle_go_to_state(BATTLE_STATE.PLAYER_ACT, _enemy)
								break
							}
						}else{
							switch (battle_selection[1]){
								case 0: //Spare
									battle_go_to_state(BATTLE_STATE.PLAYER_DIALOG_RESULT, undefined, battle_state)
								break
								case 1: //Flee
									battle_go_to_state(BATTLE_STATE.PLAYER_FLEE)
								break
							}
						}
					}
				}
				
				if (global.cancel_button){
					audio_play_sound(snd_menu_selecting, 0, false)
					
					battle_go_to_state(BATTLE_STATE.PLAYER_BUTTONS)
				}
				
				with (obj_player_battle){
					x = 72
					y = 286 + 32*other.battle_selection[1]
				}					
			break}
			case BATTLE_STATE.PLAYER_ITEM:{
				var _amount_items = array_length(global.player.inventory)
				var _page = battle_item_page
				
				if (global.left_button){
					if (battle_selection[2]%2 == 1){
						audio_play_sound(snd_menu_selecting, 0, false)
						
						battle_selection[2]--
					}else if (battle_selection[2]%2 == 0 and battle_item_page > 1){
						audio_play_sound(snd_menu_selecting, 0, false)
						
						battle_selection[2]++
						battle_item_page--
					}
				}
				
				if (global.right_button){
					if (battle_selection[2]%2 == 0 and _amount_items > battle_selection[2] + 4*(battle_item_page - 1) + 1){
						audio_play_sound(snd_menu_selecting, 0, false)
						
						battle_selection[2]++
					}else if (battle_selection[2]%2 == 1 and _amount_items > 4*battle_item_page){
						audio_play_sound(snd_menu_selecting, 0, false)
						
						if (_amount_items > 4*battle_item_page + 2 and battle_selection[2] == 3){
							battle_selection[2] = 2
						}else{
							battle_selection[2] = 0
						}
						
						battle_item_page++
					}
				}
				
				if (global.up_button){
					if (battle_selection[2] < 2 and _amount_items > battle_selection[2] + 2 + 4*(battle_item_page - 1)){
						audio_play_sound(snd_menu_selecting, 0, false)
						
						battle_selection[2] += 2
					}else if (battle_selection[2] > 1){
						audio_play_sound(snd_menu_selecting, 0, false)
						
						battle_selection[2] -= 2
					}
				}
				
				if (global.down_button){
					if (battle_selection[2] < 2 and _amount_items > battle_selection[2] + 2 + 4*(battle_item_page - 1)){
						audio_play_sound(snd_menu_selecting, 0, false)
						
						battle_selection[2] += 2
					}else if (battle_selection[2] > 1){
						audio_play_sound(snd_menu_selecting, 0, false)
						
						battle_selection[2] -= 2
					}
				}
				
				if (_page != battle_item_page){
					var _text = "[skip:false][asterisk:false]"
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
					
					_text += string_repeat("\n", ceil((4 - (min(_amount_items, 4 + 4*_page_index) - 4*_page_index))/2)) + string_repeat(" ", 21) + "PAGE " + string(battle_item_page)
					
					battle_set_box_dialog(_text)
				}
				
				if (global.confirm_button and _amount_items > 0){
					audio_play_sound(snd_menu_confirm, 100, false)
					
					battle_go_to_state(BATTLE_STATE.PLAYER_DIALOG_RESULT,, battle_state)
				}
				
				if (global.cancel_button){
					audio_play_sound(snd_menu_selecting, 100, false)
					
					battle_go_to_state(BATTLE_STATE.PLAYER_BUTTONS)
				}
				
				with (obj_player_battle){
					x = 72 + 256*(other.battle_selection[2]%2)
					y = 286 + 32*floor(other.battle_selection[2]/2)
				}
			break}
			case BATTLE_STATE.PLAYER_ATTACK:{
				var _length = array_length(battle_enemies_dialogs)
				for (var _i=0; _i<_length; _i++){
					var _dialog = battle_enemies_dialogs[_i]
					_dialog.step()
				}
				
				battle_player_attack.update()
			break}
			case BATTLE_STATE.PLAYER_WON:{
				if (global.confirm_button and obj_game.dialog.is_done_displaying()){
					battle_go_to_state(BATTLE_STATE.END)
				}
			break}
			case BATTLE_STATE.PLAYER_FLEE:{
				var _length = array_length(battle_enemies_dialogs)
				for (var _i=0; _i<_length; _i++){
					var _dialog = battle_enemies_dialogs[_i]
					_dialog.step()
				}
				
				battle_flee_event.update()
				
				if (battle_flee_event.is_finished){
					if (battle_flee_event.success){
						battle_fled = true
						
						battle_go_to_state(BATTLE_STATE.END)
					}else{
						battle_go_to_state(BATTLE_STATE.ENEMY_DIALOG)
					}
				}
			break}
			case BATTLE_STATE.PLAYER_ACT:{
				var _length = array_length(battle_enemies_dialogs)
				for (var _i=0; _i<_length; _i++){
					var _dialog = battle_enemies_dialogs[_i]
					_dialog.step()
				}
				
				if (battle_options_amount > 0){
					if (global.left_button){
						if (battle_selection[2]%2 == 1){
							audio_play_sound(snd_menu_selecting, 0, false)
						
							battle_selection[2]--
						}else if (battle_selection[2]%2 == 0 and battle_options_amount > battle_selection[2] + 1){
							audio_play_sound(snd_menu_selecting, 0, false)
						
							battle_selection[2]++
						}
					}
				
					if (global.right_button){
						if (battle_selection[2]%2 == 0 and battle_options_amount > battle_selection[2] + 1){
							audio_play_sound(snd_menu_selecting, 0, false)
						
							battle_selection[2]++
						}else if (battle_selection[2]%2 == 1){
							audio_play_sound(snd_menu_selecting, 0, false)
						
							battle_selection[2]--
						}
					}
				
					if (global.up_button){
						if (battle_selection[2] > 1){
							audio_play_sound(snd_menu_selecting, 0, false)
						
							battle_selection[2] -= 2
						}else{
							audio_play_sound(snd_menu_selecting, 0, false)
						
							battle_selection[2] = battle_options_amount + battle_options_amount%2 + battle_selection[2]*(1 - 2*(battle_options_amount%2)) - 2
						}
					}
				
					if (global.down_button){
						if (battle_options_amount <= battle_selection[2] + 2){
							audio_play_sound(snd_menu_selecting, 0, false)
						
							battle_selection[2] = battle_selection[2]%2
						}else{
							audio_play_sound(snd_menu_selecting, 0, false)
						
							battle_selection[2] += 2
						}
					}
				
					if (global.confirm_button){
						audio_play_sound(snd_menu_confirm, 0, false)
					
						battle_go_to_state(BATTLE_STATE.PLAYER_DIALOG_RESULT, battle_selectable_enemies[battle_selection[1]], battle_state)
					}
				}
				
				if (global.cancel_button){
					audio_play_sound(snd_menu_selecting, 0, false)
					
					battle_go_to_state(BATTLE_STATE.PLAYER_ENEMY_SELECT, undefined, BATTLE_STATE.PLAYER_ACT)
				}
				
				with (obj_player_battle){
					x = 72 + 256*(other.battle_selection[2]%2)
					y = 286 + 32*floor(other.battle_selection[2]/2)
				}
			break}
			case BATTLE_STATE.PLAYER_DIALOG_RESULT:{
				var _length = array_length(battle_enemies_dialogs)
				for (var _i=0; _i<_length; _i++){
					var _dialog = battle_enemies_dialogs[_i]
					_dialog.step()
				}
				
				if (obj_game.dialog.is_finished()){
					battle_go_to_state(BATTLE_STATE.ENEMY_DIALOG)
				}
			break}
			case BATTLE_STATE.ENEMY_DIALOG:{
				var _length = array_length(battle_enemies_dialogs)
				var _dialog_finished = true
				for (var _i=0; _i<_length; _i++){
					var _dialog = battle_enemies_dialogs[_i]
					_dialog.step()
					
					if (!_dialog.is_finished()){
						_dialog_finished = false
					}
				}
				
				if (_dialog_finished){
					battle_go_to_state(BATTLE_STATE.ENEMY_ATTACK)
				}
				
				with (obj_player_battle){
					x = obj_box.x
					y = obj_box.y - round(obj_box.height)/2 - 5
				}
			break}
			case BATTLE_STATE.TURN_END:{
				var _length = array_length(battle_enemies_dialogs)
				var _dialog_finished = true
				for (var _i=0; _i<_length; _i++){
					var _dialog = battle_enemies_dialogs[_i]
					_dialog.step()
					
					if (!_dialog.is_finished()){
						_dialog_finished = false
					}
				}
				
				if (obj_game.dialog.is_finished() and _dialog_finished){
					battle_go_to_state(BATTLE_STATE.PLAYER_BUTTONS)
				}
			break}
			case BATTLE_STATE.END_DODGE_ATTACK:
			case BATTLE_STATE.ENEMY_ATTACK:{
				var _length = array_length(battle_enemies_attacks)
				var _attacks_done = true
				for (var _i=0; _i<_length; _i++){
					var _attack = battle_enemies_attacks[_i]
					_attack.update()
					
					if (_attacks_done and !_attack.attack_done){
						_attacks_done = false
					}
				}
				
				if (battle_state == BATTLE_STATE.ENEMY_ATTACK){
					if (_attacks_done){
						if (is_battle_only_attack_undefined){
							for (var _i=0; _i<_length; _i++){
								var _attack = battle_enemies_attacks[_i]
								if (!is_undefined(_attack.cleanup)){
									_attack.cleanup()
								}
							}
						
							battle_go_to_state(BATTLE_STATE.TURN_END)
						}else{
							battle_state = BATTLE_STATE.END_DODGE_ATTACK
						
							if (!is_undefined(battle_end_function)){
								start_room_function = function(){
									battle_end_function()
									battle_end_function = undefined
								}
							}
						
							anim_timer = 0
						}
					}
					break
				}
			}
			case BATTLE_STATE.END:{
				anim_timer++
				if (anim_timer == 20){
					obj_player_overworld.image_alpha = 1
					
					while (!dialog.is_finished()){
						dialog.next_dialog()
					}
					
					var _length = array_length(battle_enemies_dialogs)
					for (var _i=0; _i<_length; _i++){
						array_pop(battle_enemies_dialogs)
					}
					
					_length = array_length(battle_dust_clouds)
					for (var _i=0; _i<_length; _i++){
						array_pop(battle_dust_clouds)
					}
					
					_length = array_length(battle_bullets) //You never know when some of these bullets was set to persist
					for (var _i=_length - 1; _i>=0; _i--){
						var _bullet = battle_bullets[_i]
					
						if (instance_exists(_bullet)){
							instance_destroy(_bullet)
						}
					
						array_pop(battle_bullets)
					}
					
					anim_timer = 0
					state = GAME_STATE.BATTLE_END
					
					room_goto(player_prev_room)
				}
			break}
		}
	break}
	case GAME_STATE.BATTLE_START_ANIMATION:{
		//Depending on the animation the animation timer may go faster or start early, either way, it stops counting at 100.
		switch (battle_start_animation_type){
			case BATTLE_START_ANIMATION.NORMAL: case BATTLE_START_ANIMATION.NO_WARNING:{
				anim_timer++
			break}
			default:{ //BATTLE_START_ANIMATION.FAST or BATTLE_START_ANIMATION.NO_WARNING_FAST.
				anim_timer += 2
			break}
		}
		
		switch (anim_timer){
			case 0: case 8: case 16:{
				audio_play_sound(snd_switch_flip, 100, false)
			break}
			case 24:{
				audio_play_sound(snd_battle_start, 100, false)
			break}
			case 48:{
				state = GAME_STATE.BATTLE
				obj_player_overworld.image_alpha = 0
				
				if (room != rm_battle){
					player_prev_room = room
				}
				
				room_persistent = true
				
				room_goto(rm_battle)
			break}
		}
	break}
	case GAME_STATE.PLAYER_CONTROL:{
		//Nothing, in this state the control is given to the player, an obj_player_overworld handles the logic now with movement and interactions, and triggers all sorts of events in here from there, if you need to do something while the player can move around, here is the place to do it.
	break}
	case GAME_STATE.PLAYER_MENU_CONTROL:{
		switch (player_menu_state){
			case PLAYER_MENU_STATE.INITIAL:{
				if (global.up_button and player_menu_selection[0] > 0){
					player_menu_selection[0]--
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}else if (global.down_button and player_menu_selection[0] < 1 + global.player.cell){
					player_menu_selection[0]++
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
				
				if (global.confirm_button){
					switch (player_menu_selection[0]){
						case PLAYER_MENU_OPTIONS.ITEM:
							if (array_length(global.player.inventory) > 0){
								player_menu_state = PLAYER_MENU_STATE.INVENTORY
								player_menu_selection[1] = 0
							}
						break
						case PLAYER_MENU_OPTIONS.STAT:
							player_menu_state = PLAYER_MENU_STATE.STATS
						break
						case PLAYER_MENU_OPTIONS.CELL:
							if (array_length(global.player.cell_options) > 0){
								player_menu_state = PLAYER_MENU_STATE.CELL
								player_menu_selection[1] = 0
							}
						break
					}
					
					if (player_menu_state != PLAYER_MENU_STATE.INITIAL){
						audio_play_sound(snd_menu_confirm, 0, false)
					}
				}else if (global.cancel_button){
					state = GAME_STATE.PLAYER_CONTROL
				}
			break}
			case PLAYER_MENU_STATE.STATS:{
				if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INITIAL
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
			break}
			case PLAYER_MENU_STATE.INVENTORY:{
				if (global.up_button and player_menu_selection[1] > 0){
					player_menu_selection[1]--
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}else if (global.down_button and player_menu_selection[1] < array_length(global.player.inventory) - 1){
					player_menu_selection[1]++
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
				
				if (global.confirm_button){
					player_menu_state = PLAYER_MENU_STATE.ITEM_SELECTED
					player_menu_selection[2] = 0
					
					audio_play_sound(snd_menu_confirm, 0, false)
				}else if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INITIAL
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
			break}
			case PLAYER_MENU_STATE.ITEM_SELECTED:{
				if (global.left_button and player_menu_selection[2] > 0){
					player_menu_selection[2]--
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}else if (global.right_button and player_menu_selection[2] < 2){
					player_menu_selection[2]++
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
				
				if (global.confirm_button){
					player_menu_state = PLAYER_MENU_STATE.WAITING_DIALOG_END
					var _dialog = ""
					
					switch (player_menu_selection[2]){
						case PLAYER_MENU_INVENTORY_OPTIONS.USE:
							_dialog = use_item(player_menu_selection[1])[0]
						break
						case PLAYER_MENU_INVENTORY_OPTIONS.INFO:
							_dialog = item_info(player_menu_selection[1])
						break
						case PLAYER_MENU_INVENTORY_OPTIONS.DROP:
							_dialog = drop_item(player_menu_selection[1])
						break
					}
					
					if (_dialog != ""){
						player_menu_prev_state = PLAYER_MENU_STATE.INVENTORY
						
						overworld_dialog(_dialog,, !player_menu_top,,,,, player_menu_box, player_menu_tail, player_menu_tail_mask)
					}
				}else if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INVENTORY
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
			break}
			case PLAYER_MENU_STATE.CELL:{
				if (global.up_button and player_menu_selection[1] > 0){
					player_menu_selection[1]--
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}else if (global.down_button and player_menu_selection[1] < array_length(global.player.cell_options) - 1){
					player_menu_selection[1]++
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
				
				if (global.confirm_button){
					player_menu_state = PLAYER_MENU_STATE.WAITING_DIALOG_END
					var _dialog = cell_use(player_menu_selection[1])
					
					if (_dialog != ""){
						player_menu_prev_state = PLAYER_MENU_STATE.CELL
						
						overworld_dialog(_dialog,, !player_menu_top,,,,, player_menu_box, player_menu_tail, player_menu_tail_mask)
					}
				}else if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INITIAL
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
			break}
			case PLAYER_MENU_STATE.BOX:{
				var _box = global.box.inventory[player_box_index]
				var _box_amount = array_length(_box)
				var _inventory_amount = array_length(global.player.inventory)
				
				if (global.left_button and player_box_cursor[0] == 1 and _inventory_amount > 0){
					player_box_cursor[0]--
					player_box_cursor[1] = min(player_box_cursor[1], _inventory_amount - 1)
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}else if (global.right_button and player_box_cursor[0] == 0 and _box_amount > 0){
					player_box_cursor[0]++
					player_box_cursor[1] = min(player_box_cursor[1], _box_amount - 1)
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
				
				if (global.up_button and player_box_cursor[1] > 0){
					player_box_cursor[1]--
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}else if (global.down_button and ((player_box_cursor[0] == 0 and player_box_cursor[1] < _inventory_amount - 1) or (player_box_cursor[0] == 1 and player_box_cursor[1] < _box_amount - 1))){
					player_box_cursor[1]++
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
				
				if (global.confirm_button and (_inventory_amount > 0 or _box_amount > 0)){
					if (player_box_cursor[0] == 0 and _box_amount < global.box.inventory_size[player_box_index]){
						array_push(global.box.inventory[player_box_index], global.player.inventory[player_box_cursor[1]])
						array_delete(global.player.inventory, player_box_cursor[1], 1)
						_inventory_amount--
						
						if (_inventory_amount == 0){
							player_box_cursor[0] = 1
						}else{
							player_box_cursor[1] = min(player_box_cursor[1], _inventory_amount - 1)
						}
					}else if (player_box_cursor[0] == 1 and _inventory_amount < global.player.inventory_size){
						array_push(global.player.inventory, global.box.inventory[player_box_index][player_box_cursor[1]])
						array_delete(global.box.inventory[player_box_index], player_box_cursor[1], 1)
						_box_amount--
						
						if (_box_amount == 0){
							player_box_cursor[0] = 0
						}else{
							player_box_cursor[1] = min(player_box_cursor[1], _box_amount - 1)
						}
					}
				}else if (global.cancel_button){
					if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
						player_menu_state = PLAYER_MENU_STATE.CELL
					}else{
						state = GAME_STATE.PLAYER_CONTROL
					}
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
			break}
			case PLAYER_MENU_STATE.SAVE:{
				if (global.left_button and player_save_cursor == 1){
					player_save_cursor--
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}else if (global.right_button and player_save_cursor == 0){
					player_save_cursor++
					
					audio_play_sound(snd_menu_selecting, 0, false)
				}
				
				if (global.confirm_button){
					if (player_save_cursor == 0){
						if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
							perform_game_save(room, obj_player_overworld.x, obj_player_overworld.y, 0)
						}else{
							var _inst = player_save_spawn_point_inst
							var _angle = _inst.image_angle
							var _size_x = 10*_inst.image_xscale
							var _size_y = 10*_inst.image_yscale
							var _x = _inst.x + _size_x*dcos(_angle) + _size_y*dsin(_angle)
							var _y = _inst.y + _size_y*dcos(_angle) - _size_x*dsin(_angle)
							
							if (_angle < 0){
								_angle = 359 - (abs(_angle) - 1)%360
							}else if (_angle >= 360){
								_angle %= 360
							}
							
							var _direction = 0
							var _x_direction = sign(_inst.image_xscale)
							if (_angle <= 45 or _angle > 315){
								_direction = 2 - _x_direction
							}else if (_angle <= 135){
								_direction = 1 + _x_direction
							}else if (_angle <= 225){
								_direction = 2 + _x_direction
							}else{
								_direction = 1 - _x_direction
							}
							
							perform_game_save(room, _x, _y, _direction)
						}
						
						audio_play_sound(snd_game_saved, 100, false)
						
						player_save_cursor = 2
					}else{
						if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
							player_menu_state = PLAYER_MENU_STATE.CELL
							
							audio_play_sound(snd_menu_selecting, 100, false)
						}else{
							state = GAME_STATE.PLAYER_CONTROL
							player_menu_prev_state = -2 //Necessary so it doesn't trigger again.
						}
					}
				}else if (global.cancel_button){
					if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
						player_menu_state = PLAYER_MENU_STATE.CELL
						
						audio_play_sound(snd_menu_selecting, 0, false)
					}else{
						state = GAME_STATE.PLAYER_CONTROL
					}
				}
			break}
			case PLAYER_MENU_STATE.WAITING_DIALOG_END:{
				if (dialog.is_finished()){
					player_menu_state = player_menu_prev_state
					
					switch (player_menu_state){
						case PLAYER_MENU_STATE.INVENTORY:{
							var _items_remaining = array_length(global.player.inventory)
							
							if (_items_remaining == 0){
								player_menu_state = PLAYER_MENU_STATE.INITIAL
							}else{
								player_menu_selection[1] = min(player_menu_selection[1], array_length(global.player.inventory) - 1)
							}
						break}
					}
				}
			break}
		}
	break}
	case GAME_STATE.ROOM_CHANGE:{
		anim_timer++
		
		if (anim_timer == room_change_fade_in_time){
			room_goto(goto_room)
		}else if (anim_timer == room_change_fade_out_time){
			state = GAME_STATE.PLAYER_CONTROL
			
			if (!is_undefined(after_transition_function)){
				after_transition_function()
				after_transition_function = undefined
			}
		}
	break}
	case GAME_STATE.BATTLE_END:{
		anim_timer++
		
		var _is_undefined = is_undefined(event_end_condition)
		if (anim_timer == 20){
			if (_is_undefined){
				state = GAME_STATE.PLAYER_CONTROL
				
				break
			}else{
				state = GAME_STATE.EVENT
			}
		}
		
		if (_is_undefined){
			break
		}
	}
	case GAME_STATE.EVENT:{
		if (!is_undefined(event_update)){
			event_update()
		}
		
		if (event_end_condition()){
			if (state == GAME_STATE.EVENT){
				state = GAME_STATE.PLAYER_CONTROL
			}
			
			event_update = undefined
			event_end_condition = undefined
		}
	break}
	case GAME_STATE.DIALOG_CHOICE:{
		var _prev_selection = selection
		
		if (!is_undefined(event_update)){
			event_update()
		}
		
		for (var _i = 0; _i < 4; _i++){
			if (!is_undefined(options[_i])){
				options[_i][4].step()
			}
		}
		
		if (global.confirm_button and selection >= 0){
			//Unless the function passed in the option variables set it otherwise, upon finishing a selection, the player regains control, a little fail safe in case you forget to place the event.
			state = GAME_STATE.PLAYER_CONTROL
			
			options[selection][3]()
			
			for (var _i = 0; _i < 4; _i++){
				if (_i >= 0){
					options[_i][3] = undefined
					delete options[_i][4]
				}
				
				options[_i] = undefined
			}
		}else if (global.left_hold_button and selection != 0 and !is_undefined(options[0])){
			audio_play_sound(snd_menu_selecting, 0, false)
			
			selection = 0
		}else if (global.down_hold_button and selection != 1 and !is_undefined(options[1])){
			audio_play_sound(snd_menu_selecting, 0, false)
			
			selection = 1
		}else if (global.right_hold_button and selection != 2 and !is_undefined(options[2])){
			audio_play_sound(snd_menu_selecting, 0, false)
			
			selection = 2
		}else if (global.up_hold_button and selection != 3 and !is_undefined(options[3])){
			audio_play_sound(snd_menu_selecting, 0, false)
			
			selection = 3
		}
		
		if (_prev_selection != selection and (_prev_selection < 0 or !is_undefined(options[_prev_selection])) and !is_undefined(options[selection])){
			if (_prev_selection >= 0){
				options[_prev_selection][4].set_dialogues("[skip:false][progress_mode:none][asterisk:false]" + options[_prev_selection][2])
			}
			
			options[selection][4].set_dialogues("[skip:false][progress_mode:none][asterisk:false][color_rgb:255,255,0]" + options[selection][2])
		}
	break}
}

//Fullscreen toggle
if (keyboard_check_pressed(vk_f4)){
	change_resolution((resolution_active + 1) % array_length(resolutions_width))
}

//Border toggle
if (keyboard_check_pressed(ord("D"))){
	toggle_border(!with_border)
}

if (keyboard_check_pressed(ord("Q"))){
	var _end_function = function(_enemies_left, _enemies_killed, _enemies_spared, _battle_fled){
		var _text = ""
		
		var _length = array_length(_enemies_left)
		for (var _i=0; _i<_length; _i++){
			var _enemy = _enemies_left[_i]
			_text += string_concat(_enemy.name, " was left alive.\n")
		}
		
		_length = array_length(_enemies_killed)
		for (var _i=0; _i<_length; _i++){
			var _enemy = _enemies_killed[_i]
			_text += string_concat(_enemy.name, " was killed.\n")
		}
		
		_length = array_length(_enemies_spared)
		for (var _i=0; _i<_length; _i++){
			var _enemy = _enemies_spared[_i]
			_text += string_concat(_enemy.name, " was spared.\n")
		}
		
		_text += string_concat("You ", ((_battle_fled) ? "fled" : "didn't flee"), " the battle.")
		
		overworld_dialog(_text,, (obj_player_overworld.y > 210))
	}
	
	start_battle([ENEMY.MAD_DUMMY_DRAWN, ENEMY.MAD_DUMMY_SPRITED], "Oh no, two dummies...[w:20]\nAnd they are mad!",,, _end_function)
}

if (keyboard_check_pressed(ord("E"))){
	var _end_function = function(){
		overworld_dialog("It seems you are alive, nice.",, (obj_player_overworld.y > 210))
	}
	
	var _random = irandom(2)
	var _attacks = ENEMY_ATTACK.MAD_DUMMY_1
	if (_random == 1){
		_attacks = ENEMY_ATTACK.MAD_DUMMY_2
	}else if (_random == 2){
		_attacks = [ENEMY_ATTACK.MAD_DUMMY_1, ENEMY_ATTACK.MAD_DUMMY_2]
	}
	
	_attacks = ENEMY_ATTACK.PLATFORM_1
	
	start_attack(_attacks,,, _end_function)
}

if (keyboard_check_pressed(ord("R"))){
	state = GAME_STATE.PLAYER_CONTROL
	
	room_goto(player_prev_room)
}

dialog.step()