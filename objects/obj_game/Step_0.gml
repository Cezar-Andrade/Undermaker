//Keyboard controls handler, if you don't understand it, I recommend not to touch it, don't even look at it... well ok you can in an attempt to understand, my bad, sorry...
switch (control_type){
	case CONTROL_TYPE.MAPPING_CONTROLLER:
		switch (controller_mapping_state){
			case CONTROLLER_MAPPING.WAITING_ENTER: //make macros for this in scr_init.
				if (keyboard_check_pressed(vk_enter)){
					controller_mapping_state = CONTROLLER_MAPPING.GET_CONFIRM;
				}
			break;
			case CONTROLLER_MAPPING.GET_CONFIRM:
				var _button_z = get_controller_button_pressed(controller_id);
				
				if (_button_z != -1){
					controller_confirm_button = _button_z;
					controller_mapping_state = CONTROLLER_MAPPING.GET_CANCEL;
				}
			break;
			case CONTROLLER_MAPPING.GET_CANCEL:
				var _button_x = get_controller_button_pressed(controller_id);
				
				if (_button_x != -1){
					controller_cancel_button = _button_x;
					controller_mapping_state = CONTROLLER_MAPPING.GET_MENU;
				}
			break;
			case CONTROLLER_MAPPING.GET_MENU:
				var _button_c = get_controller_button_pressed(controller_id);
				
				if (_button_c != -1){
					controller_menu_button = _button_c;
					controller_mapping_state = CONTROLLER_MAPPING.DONE;
					control_type = CONTROL_TYPE.CONTROLLER;
					save_controller_config(controller_id);
				}
			break;
		}
		
		global.up_button = 0;
		global.left_button = 0;
		global.down_button = 0;
		global.right_button = 0;
		global.confirm_button = 0;
		global.cancel_button = 0;
		global.menu_button = 0;
		
		global.up_hold_button = 0;
		global.left_hold_button = 0;
		global.down_hold_button = 0;
		global.right_hold_button = 0;
		global.confirm_hold_button = 0;
		global.cancel_hold_button = 0;
		global.menu_hold_button = 0;
	break;
	case CONTROL_TYPE.KEYBOARD:
		global.up_button = (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up));
		global.left_button = (keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left));
		global.down_button = (keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down));
		global.right_button = (keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right));
		global.confirm_button = (keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter));
		global.cancel_button = (keyboard_check_pressed(ord("X")) or keyboard_check_pressed(vk_shift));
		global.menu_button = (keyboard_check_pressed(ord("C")) or keyboard_check_pressed(vk_control));
		
		global.up_hold_button = (keyboard_check(ord("W")) or keyboard_check(vk_up));
		global.left_hold_button = (keyboard_check(ord("A")) or keyboard_check(vk_left));
		global.down_hold_button = (keyboard_check(ord("S")) or keyboard_check(vk_down));
		global.right_hold_button = (keyboard_check(ord("D")) or keyboard_check(vk_right));
		global.confirm_hold_button = (keyboard_check(ord("Z")) or keyboard_check(vk_enter));
		global.cancel_hold_button = (keyboard_check(ord("X")) or keyboard_check(vk_shift));
		global.menu_hold_button = (keyboard_check(ord("C")) or keyboard_check(vk_control));
	break;
	case CONTROL_TYPE.CONTROLLER:
		var _up_button = max(-gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padd), 0);
		var _left_button = max(-gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padl), 0);
		var _down_button = max(gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padu), 0);
		var _right_button = max(gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padr), 0);
		
		if (temp_up_button == _up_button){
			global.up_button = 0;
		}else{
			temp_up_button = _up_button;
			
			global.up_button = _up_button;
		}
		
		if (temp_down_button == _down_button){
			global.down_button = 0;
		}else{
			temp_down_button = _down_button;
			
			global.down_button = _down_button;
		}
		
		if (temp_left_button == _left_button){
			global.left_button = 0;
		}else{
			temp_left_button = _left_button;
			
			global.left_button = _left_button;
		}
		
		if (temp_right_button == _right_button){
			global.right_button = 0;
		}else{
			temp_right_button = _right_button;
			
			global.right_button = _right_button;
		}
		
		global.up_hold_button = max(-gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padd), 0);
		global.left_hold_button = max(-gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padl), 0);
		global.down_hold_button = max(gamepad_axis_value(controller_id, gp_axislv), gamepad_button_check(controller_id, gp_padu), 0);
		global.right_hold_button = max(gamepad_axis_value(controller_id, gp_axislh), gamepad_button_check(controller_id, gp_padr), 0);
		
		if (controller_mapping_state == CONTROLLER_MAPPING.DONE){
			global.confirm_button = gamepad_button_check_pressed(controller_id, controller_confirm_button);
			global.cancel_button = gamepad_button_check_pressed(controller_id, controller_cancel_button);
			global.menu_button = gamepad_button_check_pressed(controller_id, controller_menu_button);
			
			global.confirm_hold_button = gamepad_button_check(controller_id, controller_confirm_button);
			global.cancel_hold_button = gamepad_button_check(controller_id, controller_cancel_button);
			global.menu_hold_button = gamepad_button_check(controller_id, controller_menu_button);
		}else{
			global.confirm_button = gamepad_button_check_pressed(controller_id, gp_face2);
			global.cancel_button = gamepad_button_check_pressed(controller_id, gp_face1);
			global.menu_button = gamepad_button_check_pressed(controller_id, gp_face4);
			
			global.confirm_hold_button = gamepad_button_check(controller_id, gp_face2);
			global.cancel_hold_button = gamepad_button_check(controller_id, gp_face1);
			global.menu_hold_button = gamepad_button_check(controller_id, gp_face4);
		}
	break;
	//If you want to add more type of controls or variantions of the previous ones add them as cases and define their macros in scr_init.
	//After that set the control_type variable on the Create event of this object to the initial control type or handle its connection and disconnection in the corresponding place.
}

global.escape_button = keyboard_check_pressed(vk_escape); //Exclusive to keyboard.
global.escape_hold_button = keyboard_check(vk_escape); //Exclusive to keyboard.

if (keyboard_check_pressed(ord("V"))){
	perform_game_load();
}

switch (state){
	case GAME_STATE.GAME_OVER: {
		timer++;
		if (!Dunked){
			if (state == "Continue"){
				obj_game.circle = 500*max(timer + 95, 0)/40;
			}
			if (state == "Continue" and timer >= -170 and timer <= -155){
				if (timer == -155){
					x = 320;
					y = 360;
					image_index = 0;
					audio_play_sound(snd_heartbreaks, 0, false);
				}else{
					x = 320 + irandom_range(-2,2);
					y = 360 + irandom_range(-2,2);
				}
			}else if (state == "Continue" and timer >= -125 and timer <= -95){
				y = 360 - 60*dsin(3*(timer + 125));
				if (timer == -95){
					audio_play_sound(snd_revive, 100, false);
				}
			}else if (state == "Continue" and timer >= -80 and timer < -20){
				image_alpha = (-timer - 20)/60;
			}else if (state == "Give up" and timer == -100){
				audio_play_sound(snd_dead, 100, false);
				audio_play_sound(snd_heartexplotion, 0, false);
				image_alpha = 0;
				for (var i=0;i <= 5;i++){
					Shards[i] = {xpos: x, ypos: y, xspeed: random_range(-4,4), yspeed: random_range(2, -2), frame: 0}
				}
			}else if (timer == -20){
				if (state == "Continue"){
					Reset(c_white);
				}else{
					Player.HP = 92;
					transition_black([0.02,0.005],45,room_menu,true);
				}
				audio_stop_sound(musica);
				instance_destroy();
			}else if (timer == 1){
				audio_stop_all();
				audio_play_sound(snd_hurt, 0, false);
			}else if (timer == 15){
				audio_play_sound(snd_heartbreaks, 0, false);
				image_index = 75;
			}else if (timer == 45){
				if (timer == 45){
					audio_play_sound(snd_fall, 0, false);
				}
				diffX = (320 - x)/2;
				diffY = (360 - y)/2;
				diffR = -image_angle/2;
				holdX = x + diffX;
				holdY = y + diffY;
				holdR = image_angle + diffR;
			}else if (timer > 45 and timer <= 75){
				var counter = dcos(6*(timer - 45));
				x = holdX - diffX*counter;
				y = holdY - diffY*counter;
				image_angle = holdR - diffR*counter;
				if (timer == 75){
					musica = audio_play_sound(mus_gameover, 100, true);
					audio_sound_gain(musica, 1, 2000);
				}
			}else if (timer == 110){
				GameOverText.Create(160, 380, lanGetText("Game Over"), "[font:" + string(fn_big_8bit) + "][xspace:16][yspace:36]");
			}else if (timer == 111 and !ds_list_empty(GameOverText.AllTextData)){
				timer--;
			}else if (timer == 165){
				audio_play_sound(snd_pip, 0, false);
			}else if (timer > 165){
				if ((keyboard_check_pressed(settings.left[0]) or keyboard_check_pressed(settings.left[1])) and select == 1){
					select = 0;
					audio_play_sound(snd_pip, 0, false);
				}else if ((keyboard_check_pressed(settings.right[0]) or keyboard_check_pressed(settings.right[1])) and select == 0){
					select = 1;
					audio_play_sound(snd_pip, 0, false);
				}
				if (keyboard_check(settings.confirm[0]) or keyboard_check(settings.confirm[1])){
					switch (select){
						case 0:
							state = "Continue";
						break;
						default:
							state = "Give up";
						break;
					}
					timer = -200;
					audio_play_sound(snd_pipcheck, 0, false);
					audio_sound_gain(musica, 0, 2000);
				}
			}
			if (timer == 110){
				GameOverText.Update();
			}
		}else{
			if (timer == -110){
				if (state == "Continue"){
					Reset();
				}else{
					Player.HP = 92;
					transition_black([1,0.005],45,room_menu,true);
				}
				audio_stop_sound(musica);
				instance_destroy();
			}else if (timer == 1){
				audio_stop_all();
				audio_play_sound(snd_hurt, 0, false);
			}else if (timer == 15){
				audio_play_sound(snd_heartbreaks, 0, false);
				image_index = 75;
			}else if (timer == 60){
				audio_play_sound(snd_heartexplotion, 0, false);
				image_alpha = 0;
				for (var i=0;i <= 5;i++){
					Shards[i] = {xpos: x, ypos: y, xspeed: random_range(-4,4), yspeed: random_range(2, -2), frame: 0}
				}
			}else if (timer == 90){
				musica = audio_play_sound(mus_getdunked, 100, true);
			}else if (timer == 160){
				GameOverText.Create(160, 320, lanGetText("Get Dunked On"), "[font:" + string(fn_big_8bit) + "][xspace:16][yspace:36]");
			}else if (timer == 161 and !ds_list_empty(GameOverText.AllTextData)){
				timer--;
			}else if (timer == 215){
				audio_play_sound(snd_pip, 0, false);
			}else if (timer > 215){
				if ((keyboard_check_pressed(settings.left[0]) or keyboard_check_pressed(settings.left[1])) and select == 1){
					select = 0;
					audio_play_sound(snd_pip, 0, false);
				}else if ((keyboard_check_pressed(settings.right[0]) or keyboard_check_pressed(settings.right[1])) and select == 0){
					select = 1;
					audio_play_sound(snd_pip, 0, false);
				}
				if (keyboard_check(settings.confirm[0]) or keyboard_check(settings.confirm[1])){
					switch (select){
						case 0:
							state = "Continue";
						break;
						default:
							state = "Give up";
						break;
					}
					timer = -200;
					audio_play_sound(snd_pipcheck, 0, false);
					audio_sound_gain(musica, 0, 2000);
				}
			}
			if (timer == 160){
				GameOverText.Update();
			}
		}
		for (var i=0;i<array_length(Shards);i++){
			Shards[i].xpos += Shards[i].xspeed;
			Shards[i].yspeed += 0.2;
			Shards[i].ypos += Shards[i].yspeed;
			if (abs(timer)%2 == 1){
				Shards[i].frame++;
				if (Shards[i].frame > 3){
					Shards[i].frame = 0;
				}
			}
		}
	break; }
	case GAME_STATE.BATTLE: //You're already in the battle room when in this state, if not then errors may happen.
		switch (battle_state){
			case BATTLE_STATE.START:
				battle_state = BATTLE_STATE.PLAYER_BUTTONS;
				battle_button_order = [btn_fight, btn_act, btn_item, btn_mercy];
				
				with (obj_player_battle){
					x = other.battle_start_animation_player_heart_x;
					y = other.battle_start_animation_player_heart_y;
				}
				
				var _length = array_length(global.battle_enemies);
				var _x = 640/(_length + 1);
				for (var _i=0; _i<_length; _i++){
					global.battle_enemies[_i] = new enemy(global.battle_enemies[_i], _x*(_i + 1), 240);
				}
				
				battle_box_dialog(battle_initial_box_dialog);
				
				if (!is_undefined(battle_init_function)){
					battle_init_function();
				}
				battle_init_function = undefined;
			break;
			case BATTLE_STATE.PLAYER_BUTTONS:
				var _options_length = array_length(battle_button_order);
				
				if (global.left_button){
					audio_play_sound(snd_menu_selecting, 0, false);
					
					battle_selection[0]--;
					
					if (battle_selection[0] <= -1){
						battle_selection[0] += _options_length;
					}
				}
				
				if (global.right_button){
					audio_play_sound(snd_menu_selecting, 0, false);
					
					battle_selection[0]++;
					
					if (battle_selection[0] >= _options_length){
						battle_selection[0] -= _options_length;
					}
				}
				
				var _button = battle_button_order[battle_selection[0]];
				
				if (global.confirm_button){
					audio_play_sound(snd_menu_confirm, 0, false);
					
					switch (_button.button_type){
						case BUTTON.MERCY:
							battle_state = BATTLE_STATE.PLAYER_MERCY;
							
							var _spare = false;
							var _length = array_length(global.battle_enemies);
							for (var _i=0; _i<_length; _i++){
								if (global.battle_enemies[_i].can_spare){
									_spare = true;
									
									break;
								}
							}
							
							var _aux = "[skip:false][asterisk:false]";
							if (_spare){
								_aux += "   [color_rgb:255,255,0]* Spare[color_rgb:255,255,255]";
							}else{
								_aux += "   * Spare";
							}
							
							if (battle_can_flee){
								_aux += "\r   * Flee";
							}
							
							battle_box_dialog(_aux);
						break;
						case BUTTON.ITEM:
							battle_state = BATTLE_STATE.PLAYER_ITEM;
							
							var _aux = "[skip:false][asterisk:false]";
							var _amountItems = array_length(global.player.inventory);
							if (_amountItems <= 4 and battle_item_page == 2){
								battle_item_page = 1;
							}
							
							var _page_index = battle_item_page - 1;
							if (_amountItems > 0){
								for (var _i=4*_page_index; _i<min(_amountItems, 4 + 4*_page_index); _i++){
									var _item_name;
									if (global.battle_serious_mode){
										_item_name = global.item_pool[global.player.inventory[_i]][$"serious name"];
									}else{
										_item_name = global.item_pool[global.player.inventory[_i]][$"short name"];
									}
									
									_aux += "   * " + _item_name + string_repeat(" ", max(11 - string_length(_item_name), 0));
									
									if ((_i + 1)%2 == 0){
										_aux += "\n";
									}
								}
								
								_aux += string_repeat("\n", ceil((4 - (min(_amountItems, 4 + 4*_page_index) - 4*_page_index))/2)) + string_repeat(" ", 21) + "PAGE " + string(battle_item_page);
								
								battle_box_dialog(_aux);
							}else{
								var _randmsg = global.UI_texts[$"no items"];
								if (global.battle_serious_mode){
									_randmsg = _randmsg.serious;
								}else{
									_randmsg = _randmsg.normal;
								}
								
								var _msg = _randmsg[irandom(array_length(_randmsg) - 1)];
								_aux = "[skip:false][color_rgb:127,127,127][apply_to_asterisk]" + _msg;
								
								battle_box_dialog(_aux, 48);
							}
						break;
						case BUTTON.ACT:
							battle_state = BATTLE_STATE.PLAYER_ENEMY_SELECT;
							
							var _aux = "[skip:false][asterisk:false]";
							var _length = array_length(global.battle_enemies);
							for (var _i=0; _i<_length; _i++){
								if (global.battle_enemies[_i].can_spare){
									_aux += "   [color_rgb:255,255,0]* " + global.battle_enemies[_i].name + "[color_rgb:255,255,255]";
								}else{
									_aux += "   * " + global.battle_enemies[_i].name;
								}
								
								if (_i + 1 < _length){
									_aux += "\r";
								}
							}
							
							battle_box_dialog(_aux);
						break;
						case BUTTON.FIGHT:
							battle_state = BATTLE_STATE.PLAYER_ENEMY_SELECT;
							
							var _aux = "[skip:false][asterisk:false]";
							var _length = array_length(global.battle_enemies);
							for (var _i=0; _i<_length; _i++){
								if (global.battle_enemies[_i].can_spare){
									_aux += "   [color_rgb:255,255,0]* " + global.battle_enemies[_i].name + "[color_rgb:255,255,255]";
								}else{
									_aux += "   * " + global.battle_enemies[_i].name;
								}
								
								if (_i + 1 < _length){
									_aux += "\r";
								}
							}
							
							battle_box_dialog(_aux);
						break;
					}	
				}
				
				with (obj_player_battle){
					x = _button.x + _button.heart_button_position_x;
					y = _button.y + _button.heart_button_position_y;
				}
			break;
			case BATTLE_STATE.PLAYER_ENEMY_SELECT: case BATTLE_STATE.PLAYER_MERCY:
				with (obj_player_battle){
					x = 72;
					y = 286 + 32*other.battle_selection[1];
				}					
			break;
			case BATTLE_STATE.PLAYER_ACT: case BATTLE_STATE.PLAYER_ITEM:
				with (obj_player_battle){
					x = 72 + 256*(other.battle_selection[2]%2);
					y = 286 + 32*floor(other.battle_selection[2]/2);
				}
			break;
			case BATTLE_STATE.PLAYER_DIALOG_RESULT:
				//TODO
			break;
			case BATTLE_STATE.ENEMY_DIALOG:
				with (obj_player_battle){
					x = obj_box.x;
					y = obj_box.y - round(obj_box.height)/2 - 5;
				}
			break;
			case BATTLE_STATE.ENEMY_ATTACK:
				//TODO
			break;
			case BATTLE_STATE.TURN_END:
				//TODO
			break;
		}
	break;
	case GAME_STATE.BATTLE_START_ANIMATION:
		//Depending on the animation the animation timer may go faster or start early, either way, it stops counting at 100.
		switch (battle_start_animation_type){
			case BATTLE_START_ANIMATION.NORMAL: case BATTLE_START_ANIMATION.NO_WARNING:
				anim_timer++;
			break;
			default: //BATTLE_START_ANIMATION.FAST or BATTLE_START_ANIMATION.NO_WARNING_FAST.
				anim_timer += 2;
			break;
		}
		
		switch (anim_timer){
			case 0: case 8: case 16:
				audio_play_sound(snd_switch_flip, 100, false);
			break;
			case 24:
				audio_play_sound(snd_battle_start, 100, false);
			break;
			case 48:
				state = GAME_STATE.BATTLE;
				player_prev_room = room;
				obj_player_overworld.image_alpha = 0;
				
				room_persistent = true;
				
				room_goto(rm_battle);
			break;
		}
	break;
	case GAME_STATE.PLAYER_MENU_CONTROL:
		switch (player_menu_state){
			case PLAYER_MENU_STATE.INITIAL:
				if (global.up_button and player_menu_selection[0] > 0){
					player_menu_selection[0]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.down_button and player_menu_selection[0] < 1 + global.player.cell){
					player_menu_selection[0]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					switch (player_menu_selection[0]){
						case PLAYER_MENU_OPTIONS.ITEM:
							if (array_length(global.player.inventory) > 0){
								player_menu_state = PLAYER_MENU_STATE.INVENTORY;
								player_menu_selection[1] = 0;
							}
						break;
						case PLAYER_MENU_OPTIONS.STAT:
							player_menu_state = PLAYER_MENU_STATE.STATS;
						break;
						case PLAYER_MENU_OPTIONS.CELL:
							if (array_length(global.player.cell_options) > 0){
								player_menu_state = PLAYER_MENU_STATE.CELL;
								player_menu_selection[1] = 0;
							}
						break;
					}
					
					if (player_menu_state != PLAYER_MENU_STATE.INITIAL){
						audio_play_sound(snd_menu_confirm, 0, false);
					}
				}else if (global.cancel_button){
					state = GAME_STATE.PLAYER_CONTROL;
				}
			break;
			case PLAYER_MENU_STATE.STATS:
				if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INITIAL;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.INVENTORY:
				if (global.up_button and player_menu_selection[1] > 0){
					player_menu_selection[1]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.down_button and player_menu_selection[1] < array_length(global.player.inventory) - 1){
					player_menu_selection[1]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					player_menu_state = PLAYER_MENU_STATE.ITEM_SELECTED;
					player_menu_selection[2] = 0;
					
					audio_play_sound(snd_menu_confirm, 0, false);
				}else if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INITIAL;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.ITEM_SELECTED:
				if (global.left_button and player_menu_selection[2] > 0){
					player_menu_selection[2]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.right_button and player_menu_selection[2] < 2){
					player_menu_selection[2]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					player_menu_state = PLAYER_MENU_STATE.WAITING_DIALOG_END;
					var _dialog = "";
					
					switch (player_menu_selection[2]){
						case PLAYER_MENU_INVENTORY_OPTIONS.USE:
							_dialog = use_item(player_menu_selection[1])[0];
						break;
						case PLAYER_MENU_INVENTORY_OPTIONS.INFO:
							_dialog = item_info(player_menu_selection[1]);
						break;
						case PLAYER_MENU_INVENTORY_OPTIONS.DROP:
							_dialog = drop_item(player_menu_selection[1]);
						break;
					}
					
					if (_dialog != ""){
						player_menu_prev_state = PLAYER_MENU_STATE.INVENTORY;
						
						overworld_dialog(_dialog, !player_menu_top,,,,, player_menu_box, player_menu_tail, player_menu_tail_mask);
					}
				}else if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INVENTORY;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.CELL:
				if (global.up_button and player_menu_selection[1] > 0){
					player_menu_selection[1]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.down_button and player_menu_selection[1] < array_length(global.player.cell_options) - 1){
					player_menu_selection[1]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					player_menu_state = PLAYER_MENU_STATE.WAITING_DIALOG_END;
					var _dialog = cell_use(player_menu_selection[1]);
					
					if (_dialog != ""){
						player_menu_prev_state = PLAYER_MENU_STATE.CELL;
						
						overworld_dialog(_dialog, !player_menu_top,,,,, player_menu_box, player_menu_tail, player_menu_tail_mask);
					}
				}else if (global.cancel_button){
					player_menu_state = PLAYER_MENU_STATE.INITIAL;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.BOX:
				var _box = global.box.inventory[player_box_index];
				var _box_amount = array_length(_box);
				var _inventory_amount = array_length(global.player.inventory);
				
				if (global.left_button and player_box_cursor[0] == 1 and _inventory_amount > 0){
					player_box_cursor[0]--;
					player_box_cursor[1] = min(player_box_cursor[1], _inventory_amount - 1);
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.right_button and player_box_cursor[0] == 0 and _box_amount > 0){
					player_box_cursor[0]++;
					player_box_cursor[1] = min(player_box_cursor[1], _box_amount - 1);
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.up_button and player_box_cursor[1] > 0){
					player_box_cursor[1]--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.down_button and ((player_box_cursor[0] == 0 and player_box_cursor[1] < _inventory_amount - 1) or (player_box_cursor[0] == 1 and player_box_cursor[1] < _box_amount - 1))){
					player_box_cursor[1]++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button and (_inventory_amount > 0 or _box_amount > 0)){
					if (player_box_cursor[0] == 0 and _box_amount < global.box.inventory_size[player_box_index]){
						array_push(global.box.inventory[player_box_index], global.player.inventory[player_box_cursor[1]]);
						array_delete(global.player.inventory, player_box_cursor[1], 1);
						_inventory_amount--;
						
						if (_inventory_amount == 0){
							player_box_cursor[0] = 1;
						}else{
							player_box_cursor[1] = min(player_box_cursor[1], _inventory_amount - 1);
						}
					}else if (player_box_cursor[0] == 1 and _inventory_amount < global.player.inventory_size){
						array_push(global.player.inventory, global.box.inventory[player_box_index][player_box_cursor[1]]);
						array_delete(global.box.inventory[player_box_index], player_box_cursor[1], 1);
						_box_amount--;
						
						if (_box_amount == 0){
							player_box_cursor[0] = 0;
						}else{
							player_box_cursor[1] = min(player_box_cursor[1], _box_amount - 1);
						}
					}
				}else if (global.cancel_button){
					if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
						player_menu_state = PLAYER_MENU_STATE.CELL;
					}else{
						state = GAME_STATE.PLAYER_CONTROL;
					}
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
			break;
			case PLAYER_MENU_STATE.SAVE:
				if (global.left_button and player_save_cursor == 1){
					player_save_cursor--;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}else if (global.right_button and player_save_cursor == 0){
					player_save_cursor++;
					
					audio_play_sound(snd_menu_selecting, 0, false);
				}
				
				if (global.confirm_button){
					if (player_save_cursor == 0){
						if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
							perform_game_save(room, obj_player_overworld.x, obj_player_overworld.y, 0);
						}else{
							var _inst = player_save_spawn_point_inst;
							var _angle = _inst.image_angle;
							var _size_x = 10*_inst.image_xscale;
							var _size_y = 10*_inst.image_yscale;
							var _x = _inst.x + _size_x*dcos(_angle) + _size_y*dsin(_angle);
							var _y = _inst.y + _size_y*dcos(_angle) - _size_x*dsin(_angle);
							
							if (_angle < 0){
								_angle = 359 - (abs(_angle) - 1)%360;
							}else if (_angle >= 360){
								_angle %= 360;
							}
							
							var _direction = 0;
							var _x_direction = sign(_inst.image_xscale);
							if (_angle <= 45 or _angle > 315){
								_direction = 2 - _x_direction;
							}else if (_angle <= 135){
								_direction = 1 + _x_direction;
							}else if (_angle <= 225){
								_direction = 2 + _x_direction;
							}else{
								_direction = 1 - _x_direction;
							}
							
							perform_game_save(room, _x, _y, _direction);
						}
						
						audio_play_sound(snd_game_saved, 100, false);
						
						player_save_cursor = 2;
					}else{
						if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
							player_menu_state = PLAYER_MENU_STATE.CELL;
							
							audio_play_sound(snd_menu_selecting, 100, false);
						}else{
							state = GAME_STATE.PLAYER_CONTROL;
							player_menu_prev_state = -2; //Necessary so it doesn't trigger again.
						}
					}
				}else if (global.cancel_button){
					if (player_menu_prev_state == PLAYER_MENU_STATE.CELL){
						player_menu_state = PLAYER_MENU_STATE.CELL;
						
						audio_play_sound(snd_menu_selecting, 0, false);
					}else{
						state = GAME_STATE.PLAYER_CONTROL;
					}
				}
			break;
			case PLAYER_MENU_STATE.WAITING_DIALOG_END:
				if (dialog.is_finished()){
					player_menu_state = player_menu_prev_state;
					
					switch (player_menu_state){
						case PLAYER_MENU_STATE.INVENTORY:
							var _items_remaining = array_length(global.player.inventory);
							
							if (_items_remaining == 0){
								player_menu_state = PLAYER_MENU_STATE.INITIAL;
							}else{
								player_menu_selection[1] = min(player_menu_selection[1], array_length(global.player.inventory) - 1);
							}
						break;
					}
				}
			break;
		}
	break;
	case GAME_STATE.ROOM_CHANGE:
		anim_timer++;
		
		if (anim_timer == room_change_fade_in_time){
			room_goto(goto_room);
		}else if (anim_timer == room_change_fade_out_time){
			state = GAME_STATE.PLAYER_CONTROL;
			
			if (!is_undefined(after_transition_function)){
				after_transition_function();
				after_transition_function = undefined;
			}
		}
	break;
	case GAME_STATE.EVENT:
		if (!is_undefined(event_update)){
			event_update();
		}
		
		if (event_end_condition()){
			state = GAME_STATE.PLAYER_CONTROL;
			
			event_update = undefined;
			event_end_condition = undefined;
		}
	break;
	case GAME_STATE.DIALOG_CHOICE:
		var _prev_selection = selection;
		
		if (!is_undefined(event_update)){
			event_update();
		}
		
		for (var _i = 0; _i < 4; _i++){
			if (!is_undefined(options[_i])){
				options[_i][4].step();
			}
		}
		
		if (global.confirm_button and selection >= 0){
			//Unless the function passed in the option variables set it otherwise, upon finishing a selection, the player regains control, a little fail safe in case you forget to place the event.
			state = GAME_STATE.PLAYER_CONTROL;
			
			options[selection][3]();
			
			for (var _i = 0; _i < 4; _i++){
				if (_i >= 0){
					options[_i][3] = undefined;
					delete options[_i][4];
				}
				
				options[_i] = undefined;
			}
		}else if (global.left_hold_button and selection != 0 and !is_undefined(options[0])){
			audio_play_sound(snd_menu_selecting, 0, false);
			
			selection = 0;
		}else if (global.down_hold_button and selection != 1 and !is_undefined(options[1])){
			audio_play_sound(snd_menu_selecting, 0, false);
			
			selection = 1;
		}else if (global.right_hold_button and selection != 2 and !is_undefined(options[2])){
			audio_play_sound(snd_menu_selecting, 0, false);
			
			selection = 2;
		}else if (global.up_hold_button and selection != 3 and !is_undefined(options[3])){
			audio_play_sound(snd_menu_selecting, 0, false);
			
			selection = 3;
		}
		
		if (_prev_selection != selection and (_prev_selection < 0 or !is_undefined(options[_prev_selection])) and !is_undefined(options[selection])){
			if (_prev_selection >= 0){
				options[_prev_selection][4].set_dialogues("[skip:false][progress_mode:none][asterisk:false]" + options[_prev_selection][2]);
			}
			
			options[selection][4].set_dialogues("[skip:false][progress_mode:none][asterisk:false][color_rgb:255,255,0]" + options[selection][2]);
		}
	break;
}

//Fullscreen toggle
if (keyboard_check_pressed(vk_f4)){
	change_resolution((resolution_active + 1) % array_length(resolutions_width));
}

//Border toggle
if (keyboard_check_pressed(ord("D"))){
	toggle_border(!with_border);
}

if (keyboard_check_pressed(ord("Q"))){
	start_battle(ENEMY.MAD_DUMMY_DRAWN, "The heroine appears.")
}

if (keyboard_check_pressed(ord("R"))){
	state = GAME_STATE.PLAYER_CONTROL;
	
	room_goto(player_prev_room);
}

dialog.step();