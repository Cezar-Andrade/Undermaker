function player_attack(type) constructor{
	switch (type) {
		case "Hard Chopsticks":
			Initial = function(){
				X = (irandom(1) == 0) ? -280 : 280;
				X2 = 0;
				dir = sign(-X);
				vel = 14*dir;
				timer = 0;
				timer2 = 0;
				damage = 0;
				Attacked = false;
				color = c_white;
				color2 = c_gray;
				secondBar = false;
			}
			Update = function(){
				if (!Attacked){
					if (secondBar){
						timer2++;
						vel = clamp(vel - dir, -14, 14);
						X2 += vel;
						if (sign(vel) == sign(-dir)){
							color2 = c_white;
						}
						if (sign(vel) == sign(-dir) and (keyboard_check_pressed(settings.confirm[0]) or keyboard_check_pressed(settings.confirm[1]))){
							audio_play_sound(snd_slice, 0, false);
							Attacked = true;
							var bonus = 0;
							if (X == X2){
								color2 = c_yellow;
								bonus = 0.2;
							}else if (abs(X - X2) > 60){
								color2 = c_red;
							}
							damage = Enemies[obj_Encounter.Selecting[1]].CalculateDamage(((184 - abs(X - X2))/184)*(280 - abs(X))/350 + bonus);
						}
						if (abs(X - X2) > 91){
							audio_play_sound(snd_slice, 0, false);
							Attacked = true;
							damage = Enemies[obj_Encounter.Selecting[1]].CalculateDamage((280 - abs(X))/700);
						}
					}else{
						X += vel;
						if ((keyboard_check_pressed(settings.confirm[0]) or keyboard_check_pressed(settings.confirm[1]))){
							if (X <= 140 and X >= -140){
								//Sound here maybe
								secondBar = true;
								X2 = X;
								if (X == 0){
									color = c_yellow;
								}
							}else{
								audio_play_sound(snd_slice, 0, false);
								Attacked = true;
								color = c_red;
								damage = Enemies[obj_Encounter.Selecting[1]].CalculateDamage((280 - abs(X))/350);
							}
						}
						if (X > 280 or X < -280){
							Enemies[obj_Encounter.Selecting[1]].Hurt("Miss");
							State = "EnemyDialogue";
						}
					}
				}else{
					timer++;
					if (secondBar){
						timer2++;
						if (abs(X - X2) > 91){
							X2 += vel;
						}
					}
					if (timer == 30){
						Enemies[obj_Encounter.Selecting[1]].Hurt(damage);
					}
					if (timer >= 75){
						State = "EnemyDialogue";
					}
				}
			}
			Draw = function(){
				draw_sprite(spr_juanito, 0, obj_Box.x, obj_Box.y - round(obj_Box.height)/2 - 5);
				var anim = 0;
				if (secondBar){
					anim = timer2;
				}else{
					anim = timer;
				}
				draw_sprite_ext(spr_indicator, floor(anim/2.4)%2, obj_Box.x + X, obj_Box.y - round(obj_Box.height)/2 - 5, 1, 1, 0, color, 1);
				if (secondBar){
					if (X == X2){
						draw_sprite_ext(spr_indicator, floor(timer/2.4)%2, obj_Box.x + X2, obj_Box.y - round(obj_Box.height)/2 - 5, 1 + timer/30, 1 + timer/30, 0, color2, max(1 - timer/20, 0));
					}else{
						draw_sprite_ext(spr_indicator, floor(timer/2.4)%2, obj_Box.x + X2, obj_Box.y - round(obj_Box.height)/2 - 5, 1, 1, 0, color2, (abs(X - X2) > 91) ? max(1 - timer/15, 0) : 1);
					}
				}
				if (timer > 0 and timer < 30){
					draw_sprite(spr_slice, floor(timer/6), Enemies[obj_Encounter.Selecting[1]].x + Enemies[obj_Encounter.Selecting[1]].xS, Enemies[obj_Encounter.Selecting[1]].y + Enemies[obj_Encounter.Selecting[1]].yS);
				}
			}
		break;
		default:
			Initial = function(){
				X = -280;
				timer = 0;
				damage = 0;
				Attacked = false;
			}
			Update = function(){
				if (!Attacked){
					X += 14;
					if ((keyboard_check_pressed(settings.confirm[0]) or keyboard_check_pressed(settings.confirm[1]))){
						Attacked = true;
						audio_play_sound(snd_slice, 0, false);
						damage = Enemies[obj_Encounter.Selecting[1]].CalculateDamage((280 - abs(X))/280);
					}
					if (X > 280){
						Enemies[obj_Encounter.Selecting[1]].Hurt("Miss");
						State = "EnemyDialogue";
					}
				}else{
					timer++;
					if (timer == 30){
						Enemies[obj_Encounter.Selecting[1]].Hurt(damage);
					}
					if (timer >= 75){
						State = "EnemyDialogue";
					}
				}
			}
			Draw = function(){
				draw_sprite(spr_juanito, 0, obj_Box.x, obj_Box.y - round(obj_Box.height)/2 - 5);
				draw_sprite(spr_indicator, floor(timer/2.4)%2, obj_Box.x + X, obj_Box.y - round(obj_Box.height)/2 - 5);
				if (timer > 0 and timer < 30){
					draw_sprite(spr_slice, floor(timer/6), Enemies[obj_Encounter.Selecting[1]].x + Enemies[obj_Encounter.Selecting[1]].xS, Enemies[obj_Encounter.Selecting[1]].y + Enemies[obj_Encounter.Selecting[1]].yS);
				}
			}
		break;
	}
}