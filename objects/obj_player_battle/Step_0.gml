/// @description Soul modes, menu handling

if (invulnerability_time > 0){
	invulnerability_time--;
}

switch (obj_game.battle_state){
	case BATTLE_STATE.ENEMY_ATTACK:
		switch (mode){
			case HEART_MODE.NORMAL:
				var _current_speed = (movement_speed + movement_speed*global.cancel_hold_button)/2;
				
				x = movement_speed*(global.right_hold_button - global.left_hold_button);
				y = movement_speed*(global.down_hold_button - global.up_hold_button);
				
				if (instance_exists(obj_box)){ ////PROBABLY CHANGE THE WAY THIS IS DONE
					x = min(max(x, obj_box.x - round(obj_box.width)/2 + 8), obj_box.x + round(obj_box.width)/2 - 8);
					y = min(max(y, obj_box.y - round(obj_box.height) + 3), obj_box.y - 13);
				}
				
				image_blend = c_red;
			break;
			case HEART_MODE.GRAVITY:
				if (!gravity_data.ignore_first_frame){
					if (gravity_data.Jump > -3 and gravity_data.Jump < 3){
						gravity_data.Jump -= 1;
					}else{ if (gravity_data.Jump > -10 and gravity_data.Jump < -3){
						gravity_data.Jump = -10;
					}else{ if (gravity_data.Jump < -3){
						gravity_data.Jump -= 3;
					}else{
						gravity_data.Jump -= 2;
					}}}
				}else{
					gravity_data.ignore_first_frame = false;
				}
				if (gravity_data.Dir == "Down"){
					if (gravity_data.OnPlatform){
						x = gravity_data.Plat.x;
						y = gravity_data.Plat.y;
					}else{
						if (gravity_data.Jump <= 0 and gravity_data.Push.val != 0){
							gravity_data.Push.count++;
							x += gravity_data.Push.val;
							if (gravity_data.Push.count > 4){
								gravity_data.Push.val -= min(max(gravity_data.Push.val, -1), 1);
							}
						}else{
							gravity_data.Push.val = 0;
							gravity_data.Push.count = 0;
						}
					}
					if ((keyboard_check(settings.right[0]) or keyboard_check(settings.right[1]))){
						x += 4;
					}
					if ((keyboard_check(settings.left[0]) or keyboard_check(settings.left[1]))){
						x -= 4;
					}
					if (y <= obj_Box.y - round(obj_Box.height) + 3 + max(Diff, 0) and gravity_data.Jump > 0){
						gravity_data.Jump = 0;
					}else{ if (gravity_data.OnPlatform){
						if ((keyboard_check(settings.up[0]) or keyboard_check(settings.up[1]))){
							if (!gravity_data.CannotJump){
								gravity_data.Jump = gravity_data.MaxJump;
							}else{
								x += gravity_data.Plat.vel.x;
								y += gravity_data.Plat.vel.y;
								xprevious += gravity_data.Plat.vel.x;
								if (gravity_data.PrevPlat.plat.Type[1] <= 0){
									gravity_data.PrevPlat.plat.Type[1] = 1;
								}
							}
						}else{
							x += gravity_data.Plat.vel.x;
							y += gravity_data.Plat.vel.y;
							xprevious += gravity_data.Plat.vel.x;
							if (!gravity_data.CannotStopJump){
								gravity_data.Jump = 0;
							}
						}
					}else{ if (y >= obj_Box.y - 13 + max(Diff, 0)){
						if (gravity_data.Jump <= -200){
							audio_play_sound(snd_slam, 0, false);
							obj_Encounter.Shake = [5, 5];
						}
						if ((keyboard_check(settings.up[0]) or keyboard_check(settings.up[1]))){
							gravity_data.Jump = gravity_data.MaxJump;
						}else{
							gravity_data.Jump = 0;
						}
					}}}
					if (!(keyboard_check(settings.up[0]) or keyboard_check(settings.up[1])) and gravity_data.Jump > 3 and !gravity_data.CannotStopJump){
						gravity_data.Jump = 2;
					}else{ if (gravity_data.CannotStopJump and gravity_data.Jump <= 2){
						gravity_data.CannotStopJump = false;
					}}
					y -= gravity_data.Jump/5;
					image_angle = 0;
				}
				if (gravity_data.Dir == "Left"){
					if (gravity_data.OnPlatform){
						x = gravity_data.Plat.x;
						y = gravity_data.Plat.y;
					}else{
						if (gravity_data.Jump <= 0 and gravity_data.Push.val != 0){
							gravity_data.Push.count++;
							y += gravity_data.Push.val;
							if (gravity_data.Push.count > 4){
								gravity_data.Push.val -= min(max(gravity_data.Push.val, -1), 1);
							}
						}else{
							gravity_data.Push.val = 0;
							gravity_data.Push.count = 0;
						}
					}
					if ((keyboard_check(settings.down[0]) or keyboard_check(settings.down[1]))){
						y += 4;
					}
					if ((keyboard_check(settings.up[0]) or keyboard_check(settings.up[1]))){
						y -= 4;
					}
					if (x >= obj_Box.x + round(obj_Box.width)/2 - 8 + min(Diff, 0) and gravity_data.Jump > 0){
						gravity_data.Jump = 0;
					}else{ if (gravity_data.OnPlatform){
						if ((keyboard_check(settings.right[0]) or keyboard_check(settings.right[1]))){
							if (!gravity_data.CannotJump){
								gravity_data.Jump = gravity_data.MaxJump;
							}else{
								x += gravity_data.Plat.vel.x;
								y += gravity_data.Plat.vel.y;
								yprevious += gravity_data.Plat.vel.y;
								if (gravity_data.PrevPlat.plat.Type[1] <= 0){
									gravity_data.PrevPlat.plat.Type[1] = 1;
								}
							}
						}else{
							x += gravity_data.Plat.vel.x;
							y += gravity_data.Plat.vel.y;
							yprevious += gravity_data.Plat.vel.y;
							if (!gravity_data.CannotStopJump){
								gravity_data.Jump = 0;
							}
						}
					}else{ if (x <= obj_Box.x - round(obj_Box.width)/2 + 8 + min(Diff, 0)){
						if (gravity_data.Jump <= -200){
							audio_play_sound(snd_slam, 0, false);
							obj_Encounter.Shake = [5, 5];
						}
						if ((keyboard_check(settings.right[0]) or keyboard_check(settings.right[1]))){
							gravity_data.Jump = gravity_data.MaxJump;
						}else{
							gravity_data.Jump = 0;
						}
					}}}
					if (!(keyboard_check(settings.right[0]) or keyboard_check(settings.right[1])) and gravity_data.Jump > 3 and !gravity_data.CannotStopJump){
						gravity_data.Jump = 2;
					}else{ if (gravity_data.CannotStopJump and gravity_data.Jump <= 2){
						gravity_data.CannotStopJump = false;
					}}
					x += gravity_data.Jump/5;
					image_angle = 270;
				}
				if (gravity_data.Dir == "Up"){
					if (gravity_data.OnPlatform){
						x = gravity_data.Plat.x;
						y = gravity_data.Plat.y;
					}else{
						if (gravity_data.Jump <= 0 and gravity_data.Push.val != 0){
							gravity_data.Push.count++;
							x += gravity_data.Push.val;
							if (gravity_data.Push.count > 4){
								gravity_data.Push.val -= min(max(gravity_data.Push.val, -1), 1);
							}
						}else{
							gravity_data.Push.val = 0;
							gravity_data.Push.count = 0;
						}
					}
					if ((keyboard_check(settings.right[0]) or keyboard_check(settings.right[1]))){
						x += 4;
					}
					if ((keyboard_check(settings.left[0]) or keyboard_check(settings.left[1]))){
						x -= 4;
					}
					if (y >= obj_Box.y - 13 + min(Diff, 0) and gravity_data.Jump > 0){
						gravity_data.Jump = 0;
					}else{ if (gravity_data.OnPlatform){
						if ((keyboard_check(settings.down[0]) or keyboard_check(settings.down[1]))){
							if (!gravity_data.CannotJump){
								gravity_data.Jump = gravity_data.MaxJump;
							}else{
								x += gravity_data.Plat.vel.x;
								y += gravity_data.Plat.vel.y;
								xprevious += gravity_data.Plat.vel.x;
								if (gravity_data.PrevPlat.plat.Type[1] <= 0){
									gravity_data.PrevPlat.plat.Type[1] = 1;
								}
							}
						}else{
							x += gravity_data.Plat.vel.x;
							y += gravity_data.Plat.vel.y;
							xprevious += gravity_data.Plat.vel.x;
							if (!gravity_data.CannotStopJump){
								gravity_data.Jump = 0;
							}
						}
					}else{ if (y <= obj_Box.y - round(obj_Box.height) + 3 + min(Diff, 0)){
						if (gravity_data.Jump <= -200){
							audio_play_sound(snd_slam, 0, false);
							obj_Encounter.Shake = [5, 5];
						}
						if ((keyboard_check(settings.down[0]) or keyboard_check(settings.down[1]))){
							gravity_data.Jump = gravity_data.MaxJump;
						}else{
							gravity_data.Jump = 0;
						}
					}}}
					if (!(keyboard_check(settings.down[0]) or keyboard_check(settings.down[1])) and gravity_data.Jump > 3 and !gravity_data.CannotStopJump){
						gravity_data.Jump = 2;
					}else{ if (gravity_data.CannotStopJump and gravity_data.Jump <= 2){
						gravity_data.CannotStopJump = false;
					}}
					y += gravity_data.Jump/5;
					image_angle = 180;
				}
				if (gravity_data.Dir == "Right"){
					if (gravity_data.OnPlatform){
						x = gravity_data.Plat.x;
						y = gravity_data.Plat.y;
					}else{
						if (gravity_data.Jump <= 0 and gravity_data.Push.val != 0){
							gravity_data.Push.count++;
							y += gravity_data.Push.val;
							yprevious += gravity_data.Push.val;
							if (gravity_data.Push.count > 4){
								gravity_data.Push.val -= min(max(gravity_data.Push.val, -1), 1);
							}
						}else{
							gravity_data.Push.val = 0;
							gravity_data.Push.count = 0;
						}
					}
					if ((keyboard_check(settings.down[0]) or keyboard_check(settings.down[1]))){
						y += 4;
					}
					if ((keyboard_check(settings.up[0]) or keyboard_check(settings.up[1]))){
						y -= 4;
					}
					if (x <= obj_Box.x - round(obj_Box.width)/2 + 8 + max(Diff, 0) and gravity_data.Jump > 0){
						gravity_data.Jump = 0;
					}else{ if (gravity_data.OnPlatform){
						if ((keyboard_check(settings.left[0]) or keyboard_check(settings.left[1]))){
							if (!gravity_data.CannotJump){
								gravity_data.Jump = gravity_data.MaxJump;
							}else{
								x += gravity_data.Plat.vel.x;
								y += gravity_data.Plat.vel.y;
								yprevious += gravity_data.Plat.vel.y;
								if (gravity_data.PrevPlat.plat.Type[1] <= 0){
									gravity_data.PrevPlat.plat.Type[1] = 1;
								}
							}
						}else{
							x += gravity_data.Plat.vel.x;
							y += gravity_data.Plat.vel.y;
							if (!gravity_data.CannotStopJump){
								gravity_data.Jump = 0;
							}
						}
					}else{ if (x >= obj_Box.x + round(obj_Box.width)/2 - 8 + max(Diff, 0)){
						if (gravity_data.Jump <= -200){
							audio_play_sound(snd_slam, 0, false);
							obj_Encounter.Shake = [5, 5];
						}
						if ((keyboard_check(settings.left[0]) or keyboard_check(settings.left[1]))){
							gravity_data.Jump = gravity_data.MaxJump;
						}else{
							gravity_data.Jump = 0;
						}
					}}}
					if (!(keyboard_check(settings.left[0]) or keyboard_check(settings.left[1])) and gravity_data.Jump > 3 and !gravity_data.CannotStopJump){
						gravity_data.Jump = 2;
					}else{ if (gravity_data.CannotStopJump and gravity_data.Jump <= 0){
						gravity_data.CannotStopJump = false;
					}}
					x -= gravity_data.Jump/5;
					image_angle = 90;
				}
				gravity_data.CannotJump = false;
				gravity_data.OnPlatform = false;
				if (gravity_data.PrevPlat.found and gravity_data.PrevPlat.plat.image_alpha >= 0.5 and (!place_meeting(x - gravity_data.PrevPlat.plat.hspeed, y - gravity_data.PrevPlat.plat.vspeed, gravity_data.PrevPlat.plat) or (gravity_data.PrevPlat.plat.Fragile[0] > 0 and gravity_data.PrevPlat.plat.Fragile[2] != 0))){
					if (gravity_data.PrevPlat.plat.Type[0] == "Sticky"){
						gravity_data.PrevPlat.plat.Type[1] = 0;
					}
					gravity_data.PrevPlat.found = false;
					gravity_data.PrevPlat.plat = undefined;
				}
				x = min(max(x, obj_Box.x - round(obj_Box.width)/2 + 8), obj_Box.x + round(obj_Box.width)/2 - 8);
				y = min(max(y, obj_Box.y - round(obj_Box.height) + 3), obj_Box.y - 13);
				if (!gravity_data.PrevPlat.found and gravity_data.Jump <= 0){
					with (obj_Platform){
						if (image_alpha >= 0.5 and (Fragile[0] <= 0 or Fragile[2] == 0) and obj_PlayerH.image_angle == image_angle){
							if (image_angle == 0 and obj_PlayerH.y <= y - 8 - obj_PlayerH.gravity_data.Jump/5 + vspeed and obj_PlayerH.x > x - Length/2 - 4 and obj_PlayerH.x < x + Length/2 + 4){
								obj_PlayerH.y = min(obj_PlayerH.y, y - 8 + vspeed);
							}else{ if (image_angle == 90 and obj_PlayerH.x <= x - 8 - obj_PlayerH.gravity_data.Jump/5 + hspeed and obj_PlayerH.y > y - Length/2 - 4 and obj_PlayerH.y < y + Length/2 + 4){
								obj_PlayerH.x = min(obj_PlayerH.x, x - 8 + hspeed);
							}else{ if (image_angle == 180 and obj_PlayerH.y >= y + 8 + obj_PlayerH.gravity_data.Jump/5 + vspeed and obj_PlayerH.x > x - Length/2 - 4 and obj_PlayerH.x < x + Length/2 + 4){
								obj_PlayerH.y = max(obj_PlayerH.y, y + 8 + vspeed);
							}else{ if (image_angle == 270 and obj_PlayerH.x >= x + 8 + obj_PlayerH.gravity_data.Jump/5 + hspeed and obj_PlayerH.y > y - Length/2 - 4 and obj_PlayerH.y < y + Length/2 + 4){
								obj_PlayerH.x = max(obj_PlayerH.x, x + 8 + hspeed);
							}}}}
						}
					}
				}
				image_index = 0;
			break;
		}
	break;
}
