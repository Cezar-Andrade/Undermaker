function enemy_attack(nombre) constructor{
	timer = 0;
	AttackDone = false;
	switch (nombre){
		case "Attack Undefined": { //All platforms showcase
			obj_Box.BoxSize.x = 360;
			obj_Box.BoxSize.y = 217;
			obj_PlayerH.Mode = "Blue";
			Zoom = [layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart)];
			layer_sprite_speed(Zoom[0], 0);
			layer_sprite_blend(Zoom[0], make_color_rgb(0, 60, 255));
			Update = function() {
				timer++;
				if (timer%60 == 1){
					var aux = 15*abs(cos(degtorad(90/60*(timer - 1))));
					Platform(-40, 342, 80, 0, 3, 0, [680, 342, -40, 342], [""], [aux, 30, 0, 0]);
					Platform(680, 299, 80, 0, -3, 0, [680, 299, -40, 299], ["Trampoline", 0], [aux, 30, 0, 0]);
					Platform(-40, 256, 80, 0, 3, 0, [680, 256, -40, 256], ["Conveyor", 0, 2*dcos(180/60*(timer - 1))], [aux, 30, 0, 0]);
					Platform(680, 213, 80, 0, -3, 0, [680, 213, -40, 213], ["Sticky", 0], [aux, 30, 0, 0]);
				}
				if (timer > 450){
					AttackDone = true;
				}
				for (var i=0;i<array_length(Zoom);i++){
					if (!is_undefined(Zoom[i])){
						layer_sprite_xscale(Zoom[i], layer_sprite_get_xscale(Zoom[i]) + 0.1);
						layer_sprite_yscale(Zoom[i], layer_sprite_get_yscale(Zoom[i]) + 0.1);
						layer_sprite_alpha(Zoom[i], layer_sprite_get_alpha(Zoom[i]) - 0.05);
						if (layer_sprite_get_alpha(Zoom[i]) <= 0){
							layer_sprite_destroy(Zoom[i]);
							Zoom[i] = undefined;
						}
					}
				}
			}
			Draw = function() {
			}
		break;}
		case "Attack Undefin": { //First Cyan attack
			obj_Box.BoxSize.x = 360;
			obj_PlayerH.Mode = "Cyan";
			audio_play_sound(snd_bell, 0, false);
			Zoom = [layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart)];
			layer_sprite_speed(Zoom[0], 0);
			layer_sprite_blend(Zoom[0], make_color_rgb(0, 255, 255));
			Update = function(){
				timer++;
				if (timer%30 == 0){
					Bone(145, 320, 118, 0, 0, 3, 0, [505, 320, 145, 320], "", 1, 0, 0, true, false);
					Bone(505, 320, 118, 0, 0, -3, 0, [505, 320, 145, 320], "", 1, 0, 0, true, true);
					/*if (timer%60 == 30){
						for (var i=0;i<8;i++){
							Bone(135 - 10*i, 320, 118, 2, 3, "", 1, 0, 0, true, false);
						}
					}else{
						for (var i=0;i<8;i++){
							Bone(515 + 10*i, 320, 118, 0, 3, "", 1, 0, 0, true, true);
						}
					}*/
				}
				if (timer%140 == 70){
					FloorBones(0, 64, 15, 15, 10, "", 1, 0, 1, true);
					FloorBones(2, 64, 15, 15, 10, "", 1, 0, 1, true);
				}else{ if (timer%140 == 0){
					FloorBones(0, 64, 15, 15, 10, "", 1, 0, 1, false);
					FloorBones(2, 64, 15, 15, 10, "", 1, 0, 1, false);
				}}
				if (timer > 300){
					AttackDone = true;
				}
				for (var i=0;i<array_length(Zoom);i++){
					if (!is_undefined(Zoom[i])){
						layer_sprite_xscale(Zoom[i], layer_sprite_get_xscale(Zoom[i]) + 0.1);
						layer_sprite_yscale(Zoom[i], layer_sprite_get_yscale(Zoom[i]) + 0.1);
						layer_sprite_alpha(Zoom[i], layer_sprite_get_alpha(Zoom[i]) - 0.05);
						if (layer_sprite_get_alpha(Zoom[i]) <= 0){
							layer_sprite_destroy(Zoom[i]);
							Zoom[i] = undefined;
						}
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack ?-9": {
			obj_Box.BoxSize.x = 200;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 307, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			PrevY = 160;
			CoolDown = [2,2,2];
			Direccion = irandom(1);
			Update = function(){
				timer++;
				if (timer == 1){
					Enemies[0].SlamDir = "Up";
					Enemies[0].Slamtimer = 0;
				}else{ if (timer == 6){
					obj_Box.BoxSize.y = 350;
					obj_PlayerH.gravity_data.Dir = "Up";
					obj_PlayerH.gravity_data.Jump = -200;
					FloorBones(2, 40, 20, 15, 10, "", 1, 0, 0, false).image_alpha = 0;
				}else{ if (timer == 16){
					Enemies[0].Sans.HeadID = 16;
					Enemies[0].movetoside = 0;
					Enemies[0].sidetomove = -1;
				}else{ if (timer == 35){
					Enemies[0].SlamDir = "Down";
					Enemies[0].Slamtimer = 0;
				}else{ if (timer == 40){
					obj_PlayerH.gravity_data.Dir = "Down";
					obj_PlayerH.gravity_data.Jump = -200;
					FloorBones(0, 40, 20, 15, 10, "", 1, 0, 0, false);
				}else{ if (timer == 70){
					var dirs = ["Left", "Right"];
					Enemies[0].SlamDir = dirs[Direccion];
					Enemies[0].Slamtimer = 0;
				}else{ if (timer == 75){
					var dirs = ["Left", "Right"];
					obj_PlayerH.gravity_data.Dir = dirs[Direccion];
					obj_PlayerH.gravity_data.Jump = -200;
					FloorBones(3 - 2*Direccion, 40, 20, infinity, 10, "", 1, 0, 0, false);
					Platform(270 + 100*Direccion, 340, 80, 3 - 2*Direccion, 0, -1, [680, 0, -40, 480], [""], [30, infinity, 0, 0]).image_alpha = 0;
				}else{ if (timer > 80){
					if (!obj_PlayerH.gravity_data.OnPlatform){
						obj_PlayerH.Diff = -1 + 2*Direccion;
						obj_PlayerH.x += -1 + 2*Direccion;
					}
					if (timer%20 == 1){
						var Y = 0;
						do{
							Y = clamp(irandom_range(320, 100), PrevY - 120, PrevY + 120);
						}until (PrevY != Y and (Y > PrevY + 60 or Y < PrevY - 60));
						PrevY = Y;
						var types = ["", "", "", "Conveyor", "Conveyor", "Trampoline"];
						CoolDown[0]--;
						CoolDown[1]--;
						CoolDown[2]--;
						var touse = -1;
						do{
							touse = types[irandom(5)];
						}until (touse == "" or (touse == "Conveyor" and CoolDown[0] <= 0) or (touse == "Trampoline" and CoolDown[1] <= 0));
						if (touse == "Conveyor"){
							CoolDown[0] = 2;
						}
						if (touse == "Trampoline"){
							CoolDown[1] = 3;
						}
						var aux = 0;
						if (irandom(4) == 3 and CoolDown[2] <= 0){
							aux = 15;
							CoolDown[2] = 2;
						}
						Platform(460 - 280*Direccion, Y, 60, 3 - 2*Direccion, (2.5 - irandom(7)/20)*(-1 + 2*Direccion), irandom_range(-2,2)/4, [460, 0, 180, 480], [touse, 0, 2 - 4*irandom(1)], [aux, 30, 0, 0]).image_alpha = 0;
					}
					if (timer%40 == 0){
						var dir = 1 - 2*irandom(1);
						Bone(irandom_range(275 - 40*Direccion, 405 - 40*Direccion), 210 + 200*dir, 12, irandom(360), 6, 0, -(irandom_range(35,50)/10)*dir, [640, -10, 0, 410], "", 1, 0, 0, true, false);
					}
				}}}}}}}}
				if (timer > 85){
					with (obj_Platform){
						if (x >= 200 and x <= 440){
							image_alpha = min(image_alpha + 0.1, 1);
						}else{
							image_alpha = max(image_alpha - 0.1, 0);
						}
					}
				}
				if (timer >= 450){
					Enemies[0].Sans.HeadID = 0;
					Enemies[0].SlamDir = "Reset";
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack ?-5": {
			Enemies[0].y = 195;
			obj_Box.BoxSize.y = 155;
			Zoom = ds_list_create();
			Aleatorio = irandom(1);
			if (Aleatorio == 1){
				timer = -10;
			}else{ if (obj_PlayerH.Mode != "Red"){
				obj_PlayerH.Mode = "Red";
				audio_play_sound(snd_bell, 0, false);
				ds_list_add(Zoom, layer_sprite_create(layer_get_id("Bullet"), obj_PlayerH.x, obj_PlayerH.y, spr_heart));
				layer_sprite_speed(Zoom[|ds_list_size(Zoom) - 1], 0);
				layer_sprite_blend(Zoom[|ds_list_size(Zoom) - 1], c_red);
			}}
			contador = 0;
			timer2 = 0;
			aux = -1;
			Update = function(){
				timer++;
				timer2++;
				if (Aleatorio == 0){
					if (timer == 15 and obj_PlayerH.Mode != "Red"){
						Enemies[0].SlamDir = "Reset";
						obj_PlayerH.Mode = "Red";
						audio_play_sound(snd_bell, 0, false);
						ds_list_add(Zoom, layer_sprite_create(layer_get_id("Bullet"), obj_PlayerH.x, obj_PlayerH.y, spr_heart));
						layer_sprite_speed(Zoom[|ds_list_size(Zoom) - 1], 0);
						layer_sprite_blend(Zoom[|ds_list_size(Zoom) - 1], make_color_rgb(0, 60, 255));
					}
					if (timer == 5){
						do{
							prevaux = aux;
							aux = irandom(3);
						}until(prevaux != aux);
						if (aux == 0){
							Blaster(440, 440, 180, [0, 320, 580], 2, 1, "", 10, 30, "", [5,5], 1, 0, 0, false);
							Blaster(200, 200, 90, [0, 320, -100], -2, 1, "", 10, 30, "", [5,5], 1, 0, 0, false);
						}else{ if (aux == 1){
							Blaster(440, 440, 270, [0, 320, 580], -2, 1, "", 10, 30, "", [5,5], 1, 0, 0, false);
							Blaster(200, 200, 0, [0, 320, -100], 2, 1, "", 10, 30, "", [5,5], 1, 0, 0, false);
						}else{ if (aux == 2){
							Blaster(440, 200, 270, [0, 320, -100], 2, 1, "", 10, 30, "", [5,5], 1, 0, 0, false);
							Blaster(200, 440, 180, [0, 320, 580], -2, 1, "", 10, 30, "", [5,5], 1, 0, 0, false);
						}else{
							Blaster(440, 200, 0, [0, 320, -100], -2, 1, "", 10, 30, "", [5,5], 1, 0, 0, false);
							Blaster(200, 440, 90, [0, 320, 580], 2, 1, "", 10, 30, "", [5,5], 1, 0, 0, false);
						}}}
					}else{ if (timer == 45){
						if (timer2 <= 330){
							PrevAleatorio = Aleatorio;
							Aleatorio = irandom(1);
							if (PrevAleatorio == Aleatorio){
								timer = 0;
								contador += 1
								if (contador >= 2){
									Aleatorio = 1;
									timer = -22;
									contador = 0;
								}
							}else{
								timer = -22;
								contador = 0;
							}
						}
					}}
				}else{
					if (timer == 1){
						aux = irandom(3);
						var aux2 = ["Down", "Right", "Up", "Left"];
						Enemies[0].SlamDir = aux2[aux];
						Enemies[0].Slamtimer = 0;
						if (obj_PlayerH.Mode != "Blue"){
							obj_PlayerH.gravity_data.Dir = "Down";
							obj_PlayerH.Mode = "Blue";
							audio_play_sound(snd_bell, 0, false);
							ds_list_add(Zoom, layer_sprite_create(layer_get_id("Bullet"), obj_PlayerH.x, obj_PlayerH.y, spr_heart));
							layer_sprite_speed(Zoom[|ds_list_size(Zoom) - 1], 0);
							layer_sprite_blend(Zoom[|ds_list_size(Zoom) - 1], make_color_rgb(0, 60, 255));
						}
					}
					if (timer == 5){
						var aux2 = ["Down", "Right", "Up", "Left"];
						obj_PlayerH.gravity_data.Dir = aux2[aux];
						obj_PlayerH.gravity_data.Jump = -200;
						FloorBones(aux, 40, 15, 5, 10, "", 1, 0, 0, false);
					}else{ if (timer == 10){
						if (timer2 <= 330){
							PrevAleatorio = Aleatorio;
							Aleatorio = irandom(1);
							if (PrevAleatorio == Aleatorio){
								timer = -18;
								contador += 1;
								if (contador >= 2){
									Aleatorio = 0;
									timer = 0;
									contador = 0;
								}
							}else{
								timer = 0;
								contador = 0;
							}
						}
					}}
				}
				tb = 0;
				for (var i=0;i<ds_list_size(Zoom);i++){
					layer_sprite_xscale(Zoom[|i - tb], layer_sprite_get_xscale(Zoom[|i - tb]) + 0.1);
					layer_sprite_yscale(Zoom[|i - tb], layer_sprite_get_yscale(Zoom[|i - tb]) + 0.1);
					layer_sprite_alpha(Zoom[|i - tb], layer_sprite_get_alpha(Zoom[|i - tb]) - 0.05);
					if (layer_sprite_get_alpha(Zoom[|i - tb]) <= 0){
						layer_sprite_destroy(Zoom[|i - tb]);
						ds_list_delete(Zoom,i - tb);
						tb++;
					}
				}
				if (timer2 >= 360){
					Enemies[0].SlamDir = "Reset";
					AttackDone = true;
					for (var i=0;i<ds_list_size(Zoom);i++){
						layer_sprite_destroy(Zoom[|i]);
					}
					ds_list_destroy(Zoom);
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack ?-2": {
			obj_Box.BoxSize.x = 360;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			Platform(-40, 350, 60, 0, 4, 0, [680, 0, -40, 480], [""], [0]);
			timer = -52;
			Prev = [-1, -1];
			Update = function(){
				timer++;
				if ((timer + 39)%40 == 0 and timer < 170){
					do{
						aux = irandom(1);
					}until (aux != Prev[0] or aux != Prev[1]);
					Prev[1] = Prev[0];
					Prev[0] = aux;
					if (aux == 0){
						Platform(-51, 350, 96, 0, 3, 0, [688, 0, -51, 480], ["Conveyor", 0, 3 - 6*irandom(1)], [0]);
					}else{
						Platform(-51, 350, 96, 0, 3, 0, [688, 0, -51, 480], ["Trampoline", 0], [0]);
					}
				}
				if (timer%40 == 0){
					if (timer >= 0 and timer < 250){
						Bone(135, 353, 54, 0, 0, 3, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
						Bone(123, 353, 54, 0, 0, 3, 0, [505, 0, 123, 480], "", 1, 0, 0, true, false);
					}
					Bone(505, 287, 54, 0, 0, -3, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
					Bone(517, 287, 54, 0, 0, -3, 0, [517, 0, 135, 480], "", 1, 0, 0, true, false);
				}
				if (timer%40 == 8 and timer < 210){
					for (var i=0;i<8;i++){
						Bone(135 - 12*i, 374, 10, 0, 0, 3, 0, [505, 0, 39, 480], "", 1, 0, 0, true, false);
					}
				}
				if (timer > 350){
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-20": { //Final attack
			prank = Bone(403, 320, 118, 0, 0, -1, 0, [515, 0, 125, 480], "Green", -92, 0, -1, true, false, -40);
			counter = 0;
			timer2 = 0;
			Update = function(){
				if (!instance_exists(prank)){
					Enemies[0].Sans.HeadID = 5;
					timer++;
					if (timer%2 == 1){
						if (counter < 14){
							Bone(403 + 2*(timer - timer2 - 1)/4, 320, 118, 0, 0, -7, 0, [515, 0, 125, 480], "", max((timer - 1)/2 - 60, 1), 0, 0, true, false);
						}else{
							timer2 += 28;
							counter -= 14
						}
						counter++;
					}
					if (timer == 300){
						Player.HP = 0;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-19": {
			obj_Box.BoxSize.x = 156;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			Plat = Platform(320, 370, 146, 0, 0, 0, [640, 0, 0, 480], ["Sticky", 0], [0]);
			aux = [irandom(20), irandom(20), irandom(1), irandom(1), irandom(40)];
			if (aux[2] == 0){
				for (var i=515 - 3*aux[0];i>125;i-=60){
					Bone(i, 288, 20, 90, 0, -3, 0, [515, 0, 125, 480], "", 1, 0, 0, true, false);
				}
			}else{
				for (var i=125 + 3*aux[0];i<515;i+=60){
					Bone(i, 288, 20, 90, 0, 3, 0, [515, 0, 125, 480], "", 1, 0, 0, true, false);
				}
			}
			Update = function(){
				timer++;
				if (timer%20 == (20 - aux[0])%20){
					Bone(515 - 390*aux[2], 288, 20, 90, 0, -3 + 6*aux[2], 0, [515, 0, 125, 480], "", 1, 0, 0, true, false);
				}
				if (timer%20 == (20 - aux[0])%20){
					Bone(125 + 390*aux[2], 342, 20, 90, 0, 3 - 6*aux[2], 0, [515, 0, 125, 480], "", 1, 0, 0, true, false);
				}
				if (timer%40 == (40 - aux[4])%40){
					Bone(125 + 390*aux[3], 315, 20, 90, 0, 4.5 - 9*aux[3], 0, [515, 0, 125, 480], "", 1, 0, 0, true, false);
				}
				if (Plat.y <= 323){
					Plat.vspeed += 0.075;
				}else{
					Plat.vspeed -= 0.075;
				}
				if (timer > 330){
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-18": {
			obj_Box.BoxSize.x = 200;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			Direccion = irandom(1);
			var plat = 0;
			for (var i=97;i<=717;i+=62){
				if (i == 717){
					plat = Platform(320, i + 10, 190, 2, 0, 0, [640, -390, 0, 800], [""], [0]);
				}else{ if (i == 655){
					plat = Platform(320, i + 10, 150, 2, 0, 0, [640, -390, 0, 800], ["Sticky",0], [0]);
				}else{ if (i == 97){
					plat = Platform(320, i + 4, 150, 2, 0, 0, [640, -390, 0, 800], [""], [0]);
				}else{
					plat = Platform(255, i, 50, 2, 0, 0, [640, -390, 0, 800], ["Conveyor", 0, 3], [0]);
					plat.image_alpha = 0;
					plat = Platform(385, i, 50, 2, 0, 0, [640, -390, 0, 800], ["Conveyor", 0, -3], [0]);
				}}}
				plat.image_alpha = 0;
			}
			Update = function(){
				timer++;
				if (timer%30 == 15 and timer > 40 and timer <= 360){
					Bone(270 + 100*Direccion, 20, 90, 90, 0, 0, 4, [640, -10, 0, 510], "", 1, 0, 0, true, false);
					Direccion = 1 - Direccion;
				}
				if (timer == 1){
					obj_Box.BoxSize.y = 350;
					audio_play_sound(snd_pierce,0,false);
					Enemies[0].SlamDir = "Up";
					Enemies[0].Slamtimer = 0;
				}else{ if (timer == 6){
					obj_PlayerH.gravity_data.Dir = "Up";
					obj_PlayerH.gravity_data.Jump = -200;
				}else{ if (timer == 11){
					Floor = FloorBones(2, 30, 15, 455, 10, "", 1, 0, 1, false);
				}else{ if (timer == 12){
					Enemies[0].Sans.HeadID = 16;
					Enemies[0].movetoside = 0;
					Enemies[0].sidetomove = -1;
				}else{ if (timer >= 62 and timer < 360){
					if (timer == 62){
						with (obj_Platform){
							vspeed = -2;
						}
					}
					if (!obj_PlayerH.gravity_data.OnPlatform){
						obj_PlayerH.Diff = -2;
						obj_PlayerH.y -= 2;
					}
				}else{ if (timer == 360){
					Enemies[0].Sans.HeadID = 17;
					with (obj_Platform){
						vspeed = 0;
					}
					Bone(210, 70, 70, 0, 0, 1, 0, [640, -10, 0, 510], "", 1, 0, 0, true, false);
					Bone(430, 70, 70, 0, 0, -1, 0, [640, -10, 0, 510], "", 1, 0, 0, true, false);
				}}}}}}
				with (obj_Platform){
					if (other.timer > 20){
						if (y <= 35){
							image_alpha = max(image_alpha - 0.1, 0);
						}else{ if (y <= 405){
							image_alpha = min(image_alpha + 0.1, 1);
						}}
					}
				}
				if (timer >= 455){
					Enemies[0].Sans.HeadID = 0;
					Enemies[0].SlamDir = "Reset";
					Enemies[0].movetocenter = 0;
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-17": {
			Enemies[0].y = 195;
			obj_Box.BoxSize.x = 360;
			obj_Box.BoxSize.y = 155;
			Platform(320, 350, 60, 0, 0, 0.5, [320, 350, 320, 410], [""], [20, 30, 0, 0]);
			Plat = Platform(470, 350, 60, 0, -2, 0, [470, 350, 170, 350], ["Trampoline", 0], [0]);
			Floor = [FloorBones(0, 20, 0, 300, 0, "", 1, 0, 0, false), FloorBones(2, 20, 0, 300, 0, "", 1, 0, 0, false)];
			Floor[0].Wait = 0;
			Floor[0].Phase = 2;
			Floor[0].image_yscale = 20;
			Floor[1].Wait = 0;
			Floor[1].Phase = 2;
			Floor[1].image_yscale = 20;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			aux = irandom(30);
			for (var i=515 - 2*aux;i>125;i-=64){
				Bone(i, 284, 20, 90, 0, -2, 0, [515, 284, 125, 284], "", 1, 0, 0, true, false);
			}
			Update = function(){
				timer++;
				if (timer > 1 and (Plat.x <= 170 or Plat.x >= 470)){
					Plat.hspeed = -Plat.hspeed;
				}
				if (timer%31 == (31 - aux)%31){
					Bone(515, 284, 20, 90, 0, -2, 0, [515, 284, 125, 284], "", 1, 0, 0, true, false);
				}
				Floor[0].Pos.x = 320 - (2*timer)%12;
				Floor[1].Pos.x = 320 + (2*timer)%12;
				if (timer > 300){
					AttackDone = true;
				}
				with (obj_Platform){
					if (y >= 395){
						image_alpha = max(image_alpha - 0.1, 0);
					}
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-16": {
			obj_Box.BoxSize.x = 360;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			timer2 = -15;
			timer3 = -1;
			Slam = 0;
			aux = ["Down","Up"];
			Aleatorio = irandom(3);
			Direccion = 0;
			contar = 0;
			Update = function(){
				timer++;
				if (timer3 < 25){
					timer2++;
				}
				if (timer3 >= 0){
					timer3++;
				}
				if (timer2 >= 0){
					Pos = 10 + 20*Aleatorio;
					if (timer > 30){
						if (Slam == 0){
							Slam = (irandom(1) == 0 or contar >= 2) ? Aleatorio : 0;
							if (Slam > 0){
								contar = 0;
								Direccion = 1 - Direccion;
								timer3 = 0;
							}else{
								contar += 1;
							}
						}
					}
					do{
						PrevAleatorio = Aleatorio;
						if (Aleatorio == 0){
							timer2 = -15;
							Aleatorio = irandom(3);
							timer2 -= 4*Aleatorio;
						}else{ if (Aleatorio == 1){
							timer2 = -23;
							Aleatorio = irandom(3);
							timer2 -= -4 + 4*Aleatorio;
						}else{ if (Aleatorio == 2){
							timer2 = -31;
							Aleatorio = irandom(3);
							timer2 -= -8 + 4*Aleatorio;
						}else{
							timer2 = -37;
							Aleatorio = irandom(3);
							timer2 -= -12 + 4*Aleatorio;
						}}}
					}until(PrevAleatorio != Aleatorio);
					Pos = (Direccion == 1) ? 100 - Pos : Pos;
					Bone(135, 306 - Pos, 100, 0, 0, 6, 0, [505, 0, 0, 480], "", 1, 0, 0, true, false);
					Bone(135, 439 - Pos, 100, 0, 0, 6, 0, [505, 0, 0, 480], "", 1, 0, 0, true, false);
					Bone(505, 306 - Pos, 100, 0, 0, -6, 0, [640, 0, 135, 480], "", 1, 0, 0, true, false);
					Bone(505, 439 - Pos, 100, 0, 0, -6, 0, [640, 0, 135, 480], "", 1, 0, 0, true, false);
				}
				if (timer3 == 20){
					Enemies[0].SlamDir = aux[Direccion];
					Enemies[0].Slamtimer = 0;
				}else if (timer3 == 25){
					obj_PlayerH.gravity_data.Dir = aux[Direccion];
					obj_PlayerH.gravity_data.Jump = -200;
					FloorBones(2*Direccion, 30, 20, 1 + 4*Slam, 10, "", 1, 0, 1, false);
					with (obj_bullet){
						if (variable_instance_exists(self, "Vel") and is_struct(Vel)){
							Backup = Vel.x;
							if (sign(320 - x) == sign(Backup)){
								Vel.x = -6*sign(Backup);
							}
						}
					}
				}else if (timer3 > 25 and timer3 < 38 + 4*Slam){
					with (obj_bullet){
						if (variable_instance_exists(self, "Vel") and is_struct(Vel) and (sign(320 - x) == sign(Backup))){
							Vel.x = (-6*dcos(180*(other.timer3 - 25)/(13 + 4*other.Slam)))*sign(Backup);
						}
					}
				}else if (timer3 == 38 + 4*Slam){
					with (obj_bullet){
						if (variable_instance_exists(self, "Vel") and is_struct(Vel) and (sign(320 - x) == sign(Backup))){
							Vel.x = Backup;
						}
					}
					Enemies[0].SlamDir = "Reset";
					timer3 = -1;
					Slam = 0;
				}
				if (timer >= 300){
					Enemies[0].SlamDir = "Reset";
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-15": {
			obj_Box.BoxSize.x = 200;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			Direccion = irandom(1);
			var types = [[""],[""],["Trampoline", 0]];
			var fragil = [[0],[15,30,0,0]];
			Platform(320, 330, 80, 0, 0, 0, [640, -infinity, 0, 800], [""], [0]).image_alpha = 0;
			for (var i=0;i<10;i++){
				var mult = 1 - 2*((Direccion + floor(i/2))%2);
				Platform(320 + 55*mult, 270 - 70*i + 40*floor(i/2), 60, 0, 0, 0, [640, -390, 0, 800], types[(i + 2)%3], fragil[(floor(i/4) + floor((i + 1)/4))%2]).image_alpha = 0;
			}
			Platform(320, -270, 80, 0, 0, 0, [640, -infinity, 0, 800], [""], [0]).image_alpha = 0;
			Update = function(){
				timer++;
				if (timer == 1){
					Enemies[0].SlamDir = "Down";
					Enemies[0].Slamtimer = 0;
				}else{ if (timer == 6){
					obj_PlayerH.gravity_data.Dir = "Down";
					obj_PlayerH.gravity_data.Jump = -200;
					Floor = [FloorBones(0, 30, 20, 500, 10, "", 1, 0, 0, false), FloorBones(0, 30, 20, 500, 10, "", 1, 0, 0, false)];
					Floor[0].Pos.x = -16;
					Floor[1].Sound = 0;
					Floor[1].Pos.x = 656;
					var aux = instance_create_layer(0,0,"Bullet",obj_bullet);
					with (aux){
						Persiste = false;
						Type = "";
						Fondo = false;
						Depth = 1;
						Timer = 0;
						WithBox = true;
						Update = function(){	
							Timer += 1;
						}
						Draw = function(){
							draw_line_width_color(315,104,315,384,2,c_red,c_red);
							draw_line_width_color(323,104,323,384,2,c_red,c_red);
							draw_line_width_color(314,104,324,104,2,c_red,c_red);
						}
						Delete = function(){
							return (Timer >= 20);
						}
					}
				}else{ if (timer == 15){
					Enemies[0].SlamDir = "Up";
					Enemies[0].Slamtimer = 0;
				}else{ if (timer == 20){
					obj_Box.BoxSize.y = 350;
					Down = Bone(320, 608, 314, 0, 0, 0, 0, [640, -infinity, 0, infinity], "", 1, 0, 0, true, false);
					Up = Bone(320, -108, 314, 0, 0, 0, 0, [640, -infinity, 0, infinity], "", 1, 0, 0, true, false);
				}else{ if (timer == 26){
					Down.Vel.y = -30;
				}else{ if (timer == 36){
					Down.Vel.y = -14;
				}else{ if (timer == 37){
					Down.Vel.y = 0;
					Enemies[0].Sans.HeadID = 1;
					Enemies[0].movetoside = 0;
					Enemies[0].sidetomove = 1;
				}else{ if (timer > 37){
					Floor[0].Max = 30 + 30/360*max(timer - 60, 0);
					Floor[1].Max = Floor[0].Max;
					Down.Vel.y = 20/7*pi*dsin(360*(timer - 37)/70);
					Up.Vel.y = 20/7*pi*dsin(360*(timer - 37)/70);
					if (timer == 60){
						with (obj_Platform){
							vspeed = 1.5;
						}
					}
					if (timer >= 60 and !obj_PlayerH.gravity_data.OnPlatform){
						obj_PlayerH.Diff = 1.5;
						obj_PlayerH.y += 1.5;
					}
				}}}}}}}}
				if (timer > 20){
					with (obj_Platform){
						if (y >= 20 and y < 405){
							image_alpha = min(image_alpha + 0.1, 1);
						}else{
							image_alpha = max(image_alpha - 0.1, 0);
						}
					}
				}
				if (timer >= 450){
					Enemies[0].Sans.HeadID = 0;
					Enemies[0].SlamDir = "Reset";
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-14": {
			obj_Box.BoxSize.y = 156;
			obj_PlayerH.y = 307;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Red"){
				obj_PlayerH.Mode = "Red";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 307, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, c_red);
			}
			Direccion = irandom(1);
			timer = -15;
			Update = function(){
				timer++;
				if (timer%3 == 0 and timer >= 0 and timer <= 270){
					var rot = 6*timer*(1 - 2*Direccion);
					Blaster(320 - 170*dsin(rot), 307 - 170*dcos(rot),  rot, [0, 320 - 500*dsin(rot), 307 - 500*dcos(rot)], 0, 0.5 + 0.5*timer/270, "", 25, 5, "", [0,0], 1, 1, 0, false);
				}
				if (timer >= 345){
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-13": {
			black = layer_sprite_create(layer_get_id("Top"), 0, 0, spr_black);
			layer_sprite_xscale(black, 214);
			layer_sprite_yscale(black, 240);
			layer_sprite_alpha(black, 0);
			Zoom = undefined;
			duration = -15 + 10*(Enemies[0].Progress > 21);
			type = -1;
			counter = -1;
			order = [];
			var consumed = 0;
			var aleatorio = 0;
			var prevAleatorio = -1;
			while (consumed < 330){
				var length = array_length(order);
				do{
					aleatorio = irandom(5);
				}until (aleatorio != prevAleatorio or (aleatorio >= 2 and aleatorio <= 3 and (length < 2 or (length >= 2 and order[length - 1] != order[length - 2]))));
				prevAleatorio = aleatorio;
				if (aleatorio <= 1 and 330 - consumed >= 50){
					consumed += 60;
				}else if (aleatorio > 1 and aleatorio <= 3 and 330 - consumed >= 30){
					consumed += 30;
				}else if (aleatorio > 3 and aleatorio <= 5 and 330 - consumed >= 90){
					consumed += 90;
				}else{
					continue;
				}
				array_push(order, aleatorio);
			}
			array_push(order, 6);
			Update = function(){
				timer--;
				if (timer == -1){
					audio_pause_sound(obj_Encounter.musica);
					audio_play_sound(snd_st, 0, false);
					layer_sprite_alpha(black, 1);
					audio_stop_sound(snd_GBshoot);
					with (obj_Platform){
						instance_destroy();
					}
					with (obj_bullet){
						instance_destroy();
					}
				}else if (timer == duration){
					audio_resume_sound(obj_Encounter.musica);
					audio_play_sound(snd_st, 0, false);
					layer_sprite_alpha(black, 0);
					counter++;
					type = order[counter];
					if (type == 0){
						obj_Box.BoxSize.x = 360;
						obj_Box.BoxSize.y = 110;
						obj_Box.width = 360;
						obj_Box.height = 110;
						Enemies[0].x = 320 + irandom_range(-260, 260);
						Enemies[0].y = 240;
						obj_PlayerH.x = 320;
						obj_PlayerH.y = 330;
						var PrevPos = -1;
						var Pos = -1;
						for (var i=0;i<3;i++){
							if (PrevPos == -1){
								PrevPos = 40;
							}else{
								do{
									PrevPos = min(max(PrevPos + 18*(1 - 2*irandom(1)), 4), 76);
								}until(Pos != PrevPos);
							}
							Pos = PrevPos;
							Bone(285 - 120*i, 305 - PrevPos, 100, 0, 0, 8, 0, [505, 0, -75, 480], "", 1, 0, 0, true, false);
							Bone(285 - 120*i, 436 - PrevPos, 100, 0, 0, 8, 0, [505, 0, -75, 480], "", 1, 0, 0, true, false);
							Bone(355 + 120*i, 305 - PrevPos, 100, 0, 0, -8, 0, [715, 0, 135, 480], "", 1, 0, 0, true, false);
							Bone(355 + 120*i, 436 - PrevPos, 100, 0, 0, -8, 0, [715, 0, 135, 480], "", 1, 0, 0, true, false);
						}
						do{
							PrevPos = min(max(PrevPos + 18*(1 - 2*irandom(1)), 4), 76);
						}until(Pos != PrevPos);
						if (irandom(1) == 0){
							Bone(-75, 305 - PrevPos, 100, 0, 0, 8, 0, [505, 0, -75, 480], "", 1, 0, 0, true, false);
							Bone(-75, 436 - PrevPos, 100, 0, 0, 8, 0, [505, 0, -75, 480], "", 1, 0, 0, true, false);
							Bone(715, 330, 98, 0, 0, -8, 0, [715, 0, 135, 480], "", 1, 0, 0, true, false);
						}else{
							Bone(-75, 330, 98, 0, 0, 8, 0, [505, 0, -75, 480], "", 1, 0, 0, true, false);
							Bone(715, 305 - PrevPos, 100, 0, 0, -8, 0, [715, 0, 135, 480], "", 1, 0, 0, true, false);
							Bone(715, 436 - PrevPos, 100, 0, 0, -8, 0, [715, 0, 135, 480], "", 1, 0, 0, true, false);
						}
						timer = 52;
					}else if (type == 1){
						obj_Box.BoxSize.x = 130;
						obj_Box.BoxSize.y = 130;
						obj_Box.width = 130;
						obj_Box.height = 130;
						Enemies[0].x = 320 + irandom_range(-260, 260);
						Enemies[0].y = 220;
						obj_PlayerH.x = 320;
						obj_PlayerH.y = 320;
						var Direccion = irandom(1);
						if (irandom(1) == 0){
							for (var i=0;i<2;i++){
								Bone(320 + (84 + 80*i)*(1 - 2*Direccion), 360, 70, 0, 0, -4*(1 - 2*Direccion), 0, [4030, -2240, -2370, 3900], "", 1, 0, 0, true, false);
								Bone(320 - (84 + 80*i)*(1 - 2*Direccion), 282, 70, 0, 0, 4*(1 - 2*Direccion), 0, [4030, -2240, -2370, 3900], "", 1, 0, 0, true, false);
							}
							for (var i=2;i<4;i++){
								Bone(280, 320 - (84 + 80*i)*(1 - 2*Direccion), 70, 90, 0, 0, 4*(1 - 2*Direccion), [4030, -2240, -2370, 3900], "", 1, 0, 0, true, false);
								Bone(360, 320 + (84 + 80*i)*(1 - 2*Direccion), 70, 90, 0, 0, -4*(1 - 2*Direccion), [4030, -2240, -2370, 3900], "", 1, 0, 0, true, false);
							}
						}else{
							for (var i=2;i<4;i++){
								Bone(320 + (84 + 80*i)*(1 - 2*Direccion), 360, 70, 0, 0, -4*(1 - 2*Direccion), 0, [4030, -2240, -2370, 3900], "", 1, 0, 0, true, false);
								Bone(320 - (84 + 80*i)*(1 - 2*Direccion), 282, 70, 0, 0, 4*(1 - 2*Direccion), 0, [4030, -2240, -2370, 3900], "", 1, 0, 0, true, false);
							}
							for (var i=0;i<2;i++){
								Bone(280, 320 - (84 + 80*i)*(1 - 2*Direccion), 70, 90, 0, 0, 4*(1 - 2*Direccion), [4030, -2240, -2370, 3900], "", 1, 0, 0, true, false);
								Bone(360, 320 + (84 + 80*i)*(1 - 2*Direccion), 70, 90, 0, 0, -4*(1 - 2*Direccion), [4030, -2240, -2370, 3900], "", 1, 0, 0, true, false);
							}
						}
						timer = 65;
					}else if (type == 2){
						obj_Box.BoxSize.x = 130;
						obj_Box.BoxSize.y = 130;
						obj_Box.width = 130;
						obj_Box.height = 130;
						Enemies[0].x = 320 + irandom_range(-260, 260);
						Enemies[0].y = 220;
						obj_PlayerH.x = 320;
						obj_PlayerH.y = 320;
						var aleatorio = irandom(3);
						if (aleatorio == 0){
							Blaster(275, 180, 0, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false);
							Blaster(365, 460, 180, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
							Blaster(180, 320, 90, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
						}else if (aleatorio == 1){
							Blaster(460, 275, -90, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false);
							Blaster(180, 365, 90, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
							Blaster(320, 460, 180, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
						}else if (aleatorio == 2){
							if (irandom(1) == 0){
								Blaster(430, 210, -45, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false);
								Blaster(210, 210, 45, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
								Blaster(320, 460, 180, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
							}else{
								Blaster(430, 430, -135, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false);
								Blaster(210, 430, 135, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
								Blaster(320, 180, 0, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
							}
						}else{
							if (irandom(1) == 0){
								Blaster(430, 210, -45, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false);
								Blaster(430, 430, -135, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
								Blaster(180, 320, 90, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
							}else{
								Blaster(210, 210, 45, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false);
								Blaster(210, 430, 135, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
								Blaster(460, 320, -90, [1], 0, 1, "", 25, 30, "", [5,5], 1, 1, -2, false, false);
							}
						}
						timer = 35;
					}else if (type == 3){
						obj_Box.BoxSize.x = 155;
						obj_Box.BoxSize.y = 155;
						obj_Box.width = 155;
						obj_Box.height = 155;
						Enemies[0].x = 320 + irandom_range(-260, 260);
						Enemies[0].y = 190;
						var Direccion = irandom(3);
						var aux = ["Down", "Right", "Up", "Left"];
						obj_PlayerH.x = 320 + 69*dsin(90*Direccion);
						obj_PlayerH.y = 307 + 69*dcos(90*Direccion);
						obj_PlayerH.image_angle = 90*Direccion;
						obj_PlayerH.gravity_data.Dir = aux[Direccion];
						obj_PlayerH.gravity_data.Jump = 0;
						if (irandom(1) == 0){
							FloorBones(Direccion, 40, 15, 40, 10, "", 1, 0, 1, false);
						}else{
							FloorBones((Direccion + 2)%4, 115, 10, 40, 20, "", 1, 0, 1, false);
						}
						timer = 25;
					}else if (type == 4){
						obj_Box.BoxSize.x = 360;
						obj_Box.BoxSize.y = 130;
						obj_Box.width = 360;
						obj_Box.height = 130;
						Enemies[0].x = 320 + irandom_range(-260, 260);
						Enemies[0].y = 220;
						obj_PlayerH.x = 320;
						obj_PlayerH.y = 300;
						obj_PlayerH.image_angle = 0;
						obj_PlayerH.gravity_data.Dir = "Down";
						obj_PlayerH.gravity_data.Jump = 0;
						Platform(320, 350, 60, 0, 0, 0, [680, 0, -40, 480], [""], [15, 30, 0, 0]);
						Platform(250, 300, 60, 0, 0, 0, [680, 0, -40, 480], [""], [15, 30, 0, 0]);
						Platform(390, 300, 60, 0, 0, 0, [680, 0, -40, 480], [""], [15, 30, 0, 0]);
						with (FloorBones(0, 20, 0, 360, 0, "", 1, 0, 0, false)){
							Wait = 0;
							Phase = 2;
							image_yscale = 20;
						}
						var aleatorio = 0;
						var prevAleatorio = -1;
						for (var i=0;i<6;i++){
							do{
								aleatorio = irandom(3);
							}until (aleatorio != prevAleatorio and aleatorio div 2 != prevAleatorio div 2);
							prevAleatorio = aleatorio;
							if (aleatorio == 0){
								Bone(160 - 120*i, 330, 32, 0, 0, 7, 0, [5050, 0, -750, 480], "", 1, 0, 0, true, false);
							}else if (aleatorio == 1){
								Bone(480 + 120*i, 330, 32, 0, 0, -7, 0, [5050, 0, -750, 480], "", 1, 0, 0, true, false);
							}else if (aleatorio == 2){
								Bone(160 - 120*i, 278, 32, 0, 0, 7, 0, [5050, 0, -750, 480], "", 1, 0, 0, true, false);
							}else{
								Bone(480 + 120*i, 278, 32, 0, 0, -7, 0, [5050, 0, -750, 480], "", 1, 0, 0, true, false);
							}
						}
						timer = 90;
					}else if (type == 5){
						obj_Box.BoxSize.x = 360;
						obj_Box.BoxSize.y = 110;
						obj_Box.width = 360;
						obj_Box.height = 110;
						Enemies[0].x = 320 + irandom_range(-260, 260);
						Enemies[0].y = 240;
						obj_PlayerH.x = 320;
						obj_PlayerH.y = 330;
						obj_PlayerH.image_angle = 0;
						obj_PlayerH.gravity_data.Dir = "Down";
						obj_PlayerH.gravity_data.Jump = 0;
						with (FloorBones(0, 20, 0, 360, 0, "", 1, 0, 0, false)){
							Wait = 0;
							Phase = 2;
							image_yscale = 20;
							with (Head){
								Update();
							}
						}
						var Direction = irandom(1);
						with (FloorBones(3 - 2*Direction, 50, 0, 360, 0, "", 1, 0, 0, false)){
							Wait = 0;
							Phase = 2;
							image_yscale = 50;
							with (Head){
								Update();
							}
						}
						Platform(181, 350, 82, 0, 0, 0, [690, 0, -50, 480], ["Conveyor", 0, -4 + 8*Direction], [0]);
						Platform(253, 350, 62, 0, 0, 0, [690, 0, -50, 480], ["Conveyor", 0, -4 + 8*Direction], [15, 30, 0, 0]);
						Platform(320, 350, 72, 0, 0, 0, [690, 0, -50, 480], ["Conveyor", 0, -4 + 8*Direction], [0]);
						Platform(387, 350, 62, 0, 0, 0, [690, 0, -50, 480], ["Conveyor", 0, -4 + 8*Direction], [15, 30, 0, 0]);
						Platform(459, 350, 82, 0, 0, 0, [690, 0, -50, 480], ["Conveyor", 0, -4 + 8*Direction], [0]);
						var aleatorio = 0;
						var prevAleatorio = -1;
						for (var i=0;i<6;i++){
							do{
								aleatorio = 1 + irandom(3);
							}until (prevAleatorio != aleatorio)
							prevAleatorio = aleatorio;
							if (aleatorio <= 3){
								Bone(320 + (180 + 150*i)*(1 - 2*Direction), 329 + 5*aleatorio, 30 - 10*aleatorio, 0, 0, -8 + 16*Direction, 0, [5050, 0, -750, 480], "", 1, 0, 0, true, false);
							}
							Bone(320 + (180 + 150*i)*(1 - 2*Direction), 281 + 5*aleatorio + ((aleatorio == 4) ? 2 : 0), 10*aleatorio + ((aleatorio == 4) ? 4 : 0), 0, 0, -8 + 16*Direction, 0, [5050, 0, -750, 480], "", 1, 0, 0, true, false);
						}
						timer = 90;
					}else if (type == 6){
						obj_Box.BoxSize.x = 565;
						obj_Box.BoxSize.y = 130;
						obj_Box.width = 565;
						obj_Box.height = 130;
						Enemies[0].x = 320;
						Enemies[0].y = 220;
						obj_PlayerH.image_alpha = 0;
						if (!is_undefined(Zoom)){
							layer_sprite_destroy(Zoom);
						}
						layer_sprite_destroy(black);
						AttackDone = true;
					}
					if (type < 6){
						if (obj_PlayerH.Mode != "Red" and (type <= 2)){
							obj_PlayerH.Mode = "Red";
							audio_play_sound(snd_bell, 0, false);
							if (!is_undefined(Zoom)){
								layer_sprite_destroy(Zoom);
							}
							Zoom = layer_sprite_create(layer_get_id("Bullet"), obj_PlayerH.x, obj_PlayerH.y, spr_heart);
							layer_sprite_speed(Zoom, 0);
							layer_sprite_blend(Zoom, c_red);
						}else if (obj_PlayerH.Mode != "Blue" and (type >= 3)){
							obj_PlayerH.Mode = "Blue";
							audio_play_sound(snd_bell, 0, false);
							if (!is_undefined(Zoom)){
								layer_sprite_destroy(Zoom);
							}
							Zoom = layer_sprite_create(layer_get_id("Bullet"), obj_PlayerH.x, obj_PlayerH.y, spr_heart);
							layer_sprite_speed(Zoom, 0);
							layer_sprite_angle(Zoom, obj_PlayerH.image_angle);
							layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
						}
					}
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "DunkedOn": {
			obj_PlayerH.Dunked = true;
			events.dunkedon = 1;
			prank = Bone(403, 320, 118, 0, 0, -1, 0, [515, 0, 125, 480], "Green", -92, 0, -1, true, false, -40);
			counter = 0;
			timer2 = 0;
			Update = function(){
				if (!instance_exists(prank)){
					Enemies[0].Sans.HeadID = 5;
					timer++;
					if (timer%2 == 1){
						if (counter < 14){
							Bone(403 + 2*(timer - timer2 - 1)/4, 320, 118, 0, 0, -7, 0, [515, 0, 125, 480], "", max((timer - 1)/2 - 60, 1), 0, 0, true, false);
						}else{
							timer2 += 28;
							counter -= 14
						}
						counter++;
					}
					if (timer == 300){
						Player.HP = 0;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-12": {
			obj_Box.BoxSize.x = 360;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			timer2 = -15;
			timer3 = 74;
			Slam = 0;
			aux = ["Left","Right"];
			Aleatorio = irandom(3);
			PrevAleatorio = -1;
			Direccion = irandom(1);
			contar = 0;
			PrevAle = 2;
			Update = function(){
				timer++;
				timer2++;
				if (timer3 <= 73){
					timer3++;
				}
				if (timer2 >= 0){
					Pos = 10 + 20*Aleatorio;
					if (Slam == 0){
						Slam = (irandom(1) == 0 or contar >= 1) ? 1 : 0;
						if (Slam > 0){
							contar = 0;
							Aleatorio = 2;
							PrevAle = 2;
							PrevAleatorio = 2;
							timer3 = -27;
						}else{
							contar += 1;
						}
					}
					if (timer3 > 73){
						do{
							if (Aleatorio == 0){
								timer2 = -19;
							}else{ if (Aleatorio == 1){
								timer2 = -19;
							}else{ if (Aleatorio == 2){
								timer2 = -23;
							}else{
								timer2 = -25;
							}}}
							Aleatorio = 0;
							timer2 -= 4*max(Aleatorio, 2);
						}until(PrevAleatorio != Aleatorio);
						PrevAleatorio = Aleatorio;
					}else{
						if (timer3 == -27){
							Pos = 50;
						}
						timer2 = -19;
						do{
							Aleatorio = max(min(irandom(4), min(PrevAle + 2, 4)), max(PrevAle - 2, 0));
						}until (PrevAleatorio != Aleatorio);
						if (timer3 == -8){
							do{
								Aleatorio = max(min(irandom_range(1, 3), min(PrevAle + 2, 3)), max(PrevAle - 2, 1));
							}until (PrevAleatorio != Aleatorio);
						}else{ if (timer3 == 11){
							Aleatorio = min(max(Aleatorio, 1), 3);
							timer2 -= 51;
						}}
						PrevAle = Aleatorio;
					}
					if (timer3 == 74 or timer3 == -27 or Direccion == 1){
						Bone(135, 306 - Pos, 100, 0, 0, 6, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
						Bone(135, 439 - Pos, 100, 0, 0, 6, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
					}
					if (timer3 == 74 or timer3 == -27 or Direccion == 0){
						Bone(505, 306 - Pos, 100, 0, 0, -6, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
						Bone(505, 439 - Pos, 100, 0, 0, -6, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
					}
				}
				if (Slam == 1){
					if (timer3 == 1){
						Enemies[0].SlamDir = aux[Direccion];
						Enemies[0].Slamtimer = 0;
					}else{ if (timer3 == 6){
						obj_PlayerH.gravity_data.Dir = aux[Direccion];
						obj_PlayerH.gravity_data.Jump = -200;
					}else{ if (timer3 > 6 and timer3 <= 60){
						with (obj_bullet){
							if (variable_instance_exists(self, "Vel") and is_struct(Vel)){
								if (other.Direccion == 0){
									Vel.x = max(Vel.x - 0.4, -9);
								}else{
									Vel.x = min(Vel.x + 0.4, 9);
								}
							}
						}
					}else{ if (timer3 == 61){
						Enemies[0].SlamDir = aux[1 - Direccion];
						Enemies[0].Slamtimer = 0;
					}else{ if (timer3 == 67){
						obj_PlayerH.gravity_data.Dir = "Down";
						obj_PlayerH.gravity_data.Jump = 0;
						obj_PlayerH.gravity_data.Push.val = 14*(1 - 2*Direccion);
						obj_PlayerH.gravity_data.Push.count = 0;
					}else{ if (timer3 == 73){
						Enemies[0].SlamDir = "Reset";
						Direccion = 1 - Direccion;
						Slam = 0;
					}}}}}}
				}
				if (timer >= 360){
					Enemies[0].SlamDir = "Reset";
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-11": {
			obj_Box.BoxSize.y = 155;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			Prev = [-1, -1];
			Slam = -1;
			Update = function(){
				timer++;
				Enemies[0].y = 220 - obj_Box.height + 130;
				if (timer%35 == 6){
					var aux2 = ["Down", "Right", "Up", "Left"];
					do{
						aux2[4] = irandom(3);
					}until (aux2[4] != Slam);
					Slam = aux2[4];
					Enemies[0].SlamDir = aux2[Slam];
					Enemies[0].Slamtimer = 0;
				}else{ if (timer%35 == 10){
					obj_PlayerH.gravity_data.Dir = Enemies[0].SlamDir;
					obj_PlayerH.gravity_data.Jump = -200;
					var aux2 = -1;
					do{
						aux2 = irandom(1);
					}until (aux2 != Prev[0] or aux2 != Prev[1]);
					Prev[1] = Prev[0];
					Prev[0] = aux2;
					if (aux2 == 0){
						FloorBones(Slam, 40, 20, 7, 10, "", 1, 0, 1, false);
					}else{
						FloorBones((Slam + 2)%4, 115, 20, 4, 20, "", 1, 0, 1, false);
					}
				}}
				if (timer >= 355){
					Enemies[0].SlamDir = "Reset";
					obj_PlayerH.gravity_data.Dir = "Down";
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){	
			}
		break;}
		case "Attack 1-10": {
			obj_Box.BoxSize.x = 360;
			obj_Box.BoxSize.y = 200;
			obj_PlayerH.x = 320;
			obj_PlayerH.y = 307;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 307, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			GBDir = irandom(1);
			for (var i=0;i<3;i++){
				for (var j=375;j>=195;j-=60){
					Platform(210 + 110*i, j, 70, 0, 0, 1.25*(1 - 2*(i%2)), [640, 145, 0, 425], [""], [0]);
				}
			}
			Floor = [FloorBones(0, 20, 0, 360, 0, "", 1, 0, 0, false), undefined];
			with (Floor[0]){
				Wait = 0;
				Phase = 2;
				image_yscale = 20;
				with (Head){
					Update();
				}
			}
			Prevrand = [-1, -1];
			Update = function(){
				timer++;
				Enemies[0].y = 220 - obj_Box.height + 130;
				if (timer == 2){
					Floor[1] = FloorBones(2, 20, 0, 360, 0, "", 1, 0, 0, false);
					with (Floor[1]){
						Wait = 0;
						Phase = 2;
						image_yscale = 20;
						with (Head){
							Update();
						}
					}
				}
				if (timer%48 == 24){
					var weird = [[["Conveyor", 0, 3 - 6*irandom(1)],[0]], [[""],[15,30,0,0]]];
					var rand = -1;
					do{
						rand = irandom(2);
					}until (Prevrand != rand);
					Prevrand = rand;
					for (var i=0;i<3;i++){
						if (i == Prevrand){
							var aux2 = irandom(1);
							Platform(210 + 110*i, 285 - 115*(1 - 2*(i%2)), 70, 0, 0, 1.25*(1 - 2*(i%2)), [640, 145, 0, 425], weird[aux2][0], weird[aux2][1]).image_alpha = 0;
						}else{
							Platform(210 + 110*i, 285 - 115*(1 - 2*(i%2)), 70, 0, 0, 1.25*(1 - 2*(i%2)), [640, 145, 0, 425], [""], [0]).image_alpha = 0;
						}
					}
				}
				if (timer%30 == 10){
					Blaster(320 + 240*(1 - 2*GBDir), 235 + 20*irandom(5), 270 - 180*GBDir, [0, -100, -100], 0, 0.5, "", 15, 10, "", [0,0], 1, 0, -2, false);
					GBDir = 1 - GBDir;
				}
				Floor[0].Pos.x = 320 - (2*timer)%12;
				if (timer >= 2){
					Floor[1].Pos.x = 320 + (2*timer)%12;
				}
				if (timer >= 360){
					AttackDone = true;
				}
				with (obj_Platform){
					if (y > 285){
						if (y > 385 and vspeed > 0){
							image_alpha = max(image_alpha - 0.1, 0);
						}else{
							image_alpha = min(image_alpha + 0.1, 1);
						}
					}else{ if (y < 285){
						if (y < 185 and vspeed < 0){
							image_alpha = max(image_alpha - 0.1, 0);
						}else{
							image_alpha = min(image_alpha + 0.1, 1);
						}
					}}
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-9": {
			obj_Box.BoxSize.x = 300;
			obj_Box.BoxSize.y = 267;
			Dir = irandom(1);
			obj_PlayerH.x = 360 - 80*Dir;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), obj_PlayerH.x, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			GBVar = irandom(1);
			with (FloorBones(0, 20, 0, 360, 0, "", 1, 0, 0, false)){
				Wait = 0;
				Phase = 2;
				image_yscale = 20;
				with (Head){
					Update();
				}
			}
			Enemies[0].Sans.HeadID = 1;
			Enemies[0].movetoside = 0;
			Enemies[0].sidetomove = 1;
			for (var i=0;i<4;i++){
				Platform(320, 350 - 60*i, 120, 0, 0, 0, [690, 0, -50, 480], ["Conveyor", 0, -3 + 6*Dir], [0]);
				Dir = 1 - Dir;
			}
			Update = function(){
				timer++;
				if (timer%150 == 105){
					if (GBVar == 0){
						Blaster(320, 60, 0, [0, 320, -100], 0, 1, "", 45, 15, "", [5,5], 1, 0, -2, false);
					}else{
						Blaster(250, 60, 0, [0, 320, -100], 0, 1, "", 45, 15, "", [5,5], 1, 0, -2, false);
						Blaster(390, 60, 0, [0, 320, -100], 0, 1, "", 45, 15, "", [5,5], 1, 0, -2, false);
					}
					GBVar = 1 - GBVar;
				}
				if (timer%30 == 10){
					var rand = [-1, -1];
					do{
						rand = [irandom(3), irandom(3)];
					}until (rand[0] != rand[1]);
					for (var i=0;i<2;i++){
						Bone(165 + 310*((Dir + rand[i])%2), 324 - 60*rand[i], 40, 0, 0, 3 - 6*((Dir + rand[i])%2), 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}
				}
				if (timer >= 360){
					Enemies[0].Sans.HeadID = 0;
					Enemies[0].movetocenter = 0;
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-8": {
			obj_Box.BoxSize.x = 360;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			Platform(690, 350, 100, 0, -3, 0, [690, 0, -50, 480], ["Conveyor", 0, 2], [0]);
			Update = function(){
				timer++;
				if (timer == 10){
					Platform(-40, 310, 60, 0, 2, 0, [690, 0, -50, 480], [""], [0]);
				}else{ if (timer == 140){
					Bone(505, 345, 80, 0, 0, -6, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}else{ if (timer == 122){
					Platform(702, 280, 124, 0, -5, 0, [702, 0, -62, 480], ["Conveyor", 0, 2], [15, 30, 0, 0]);
				}else{ if (timer == 163){
					Platform(-42, 360, 82, 0, 3, 0, [690, 0, -42, 480], [""], [0]);
				}else{ if (timer == 230){
					Platform(-40, 306, 60, 0, 4, 0, [690, 0, -40, 480], ["Conveyor", 0, -4], [0]);
				}else{ if (timer == 250){
					Platform(-40, 350, 60, 0, 3, 0, [690, 0, -40, 480], ["Conveyor", 0, 2], [0]);
				}else{ if (timer == 312 or timer == 316){
					Bone(135 - 2*(timer - 312)/4, 290, 70, 0, 0, 3, 0, [505, 0, 133, 480], "", 1, 0, 0, true, false);
				}}}}}}}
				if (timer%4 == 0){
					if (timer > 220 and timer <= 236){
						Bone(137 - 2*timer/4, 353, 64, 0, 0, 3, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{ if (timer > 176 and timer <= 200){
						Bone(137 - 2*timer/4, 380, 10, 0, 0, 3, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{
						Bone(137 - 2*timer/4, 375, 20, 0, 0, 3, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}}
				}
				if (timer%2 == 0){
					if ((timer > 72 and timer <= 90) or (timer > 238 and timer <= 254)){
						Bone(381 + 4*timer/2, 290, 70, 0, 0, -5, 0, [1000, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{ if (timer > 140 and timer <= 170){
						Bone(381 + 4*timer/2, 295, 80, 0, 0, -5, 0, [1000, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{ if (timer > 254 and timer <= 260){
						Bone(381 + 4*timer/2, 303, 96, 0, 0, -5, 0, [1000, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{ if (timer > 90 and timer <= 250 and not (timer > 122 and timer <= 140)){
						Bone(381 + 4*timer/2, 265, 20, 0, 0, -5, 0, [1000, 0, 0, 480], "", 1, 0, 0, true, false);
					}}}}
				}
				if (timer >= 420){
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-7": {
			obj_Box.BoxSize.x = 360;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 307, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			timer2 = 0;
			summon = 30;
			Prev = -1;
			range = 3;
			Speed = 0;
			Update = function(){
				timer++;
				timer2++;
				summon = 30 - 2/29*timer;
				if (timer2 >= summon and timer > 40){
					var rand = -1;
					do{
						rand = min(max(irandom(8), range - 2), range + 2);
					}until (rand != Prev);
					Prev = rand;
					range = Prev;
					Bone(135, 381 - 5*rand, 8 + 10*rand, 0, 0, 0, 0, [505, 0, 135, 480], "", 1, 0, 1, true, false);
					Bone(135, 298 - 5*rand, 86 - 10*rand, 0, 0, 0, 0, [505, 0, 135, 480], "", 1, 0, 1, true, false);
					timer2 = 0;
				}
				if (timer == 1){
					Enemies[0].SlamDir = "Right";
					Enemies[0].Slamtimer = 0;
					Enemies[0].Sans.Ojo = true;
				}else{ if (timer == 6){
					FloorBones(1, 30, 20, 330, 10, "", 1, 0, 0, false);
					obj_PlayerH.gravity_data.Dir = "Right";
					obj_PlayerH.gravity_data.Jump = -200;
				}else{ if (timer == 40){
					obj_PlayerH.Mode = "Red";
					audio_play_sound(snd_bell,0,false);
					if (!is_undefined(Zoom)){
						layer_sprite_destroy(Zoom);
					}
					Zoom = layer_sprite_create(layer_get_id("Bullet"), obj_PlayerH.x, obj_PlayerH.y, spr_heart);
					layer_sprite_speed(Zoom, 0);
					layer_sprite_blend(Zoom, c_red);
				}}}
				if (timer >= 40){
					Speed = 2 + timer/100;
					obj_PlayerH.x += min(Speed, max((500 - obj_PlayerH.x)/10, 0));
				}
				with (obj_bullet){
					if (variable_instance_exists(self, "Vel") and is_struct(Vel)){
						Vel.x = 2*other.Speed;
					}
				}
				if (timer >= 360){
					Enemies[0].SlamDir = "Reset";
					Enemies[0].Sans.Ojo = false;
					Enemies[0].Sans.HeadID = 0;
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_x(Zoom, layer_sprite_get_x(Zoom) + Speed);
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-6": {
			obj_Box.BoxSize.x = 168;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Red"){
				obj_PlayerH.Mode = "Red";
				audio_play_sound(snd_bell, 0, false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, c_red);
			}
			Bones = ds_list_create();
			for (i = 243;i <= 399;i += 12){
				ds_list_add(Bones, Bone(i, 457, 130, 0, 0, 0, 0, [640, 0, 0, 480], "", 1, 0, 1, true, false));
				Bones[|(i - 243)/12].Move = 0;
			}
			BoneTimer = -1;
			Aleatorio = -1;
			PrevAleatorio = -1;
			Direccion = 0;
			Update = function(){
				timer++;
				if (BoneTimer >= 0){
					BoneTimer += 1;
				}
				if (BoneTimer == 20){
					audio_play_sound(snd_pierce, 0, false);
				}
				if (timer%20 == 15){
					do{
						Aleatorio = irandom_range(clamp(floor((obj_PlayerH.x + (((keyboard_check(settings.left[0]) or keyboard_check(settings.left[1])) and !(keyboard_check(settings.right[0]) or keyboard_check(settings.right[1]))) ? -10*irandom_range(4, 8) : (((keyboard_check(settings.right[0]) or keyboard_check(settings.right[1])) and !(keyboard_check(settings.left[0]) or keyboard_check(settings.left[1]))) ? 10*irandom_range(4, 8) : 0)) - 272)/24), 0, 4), clamp(floor((obj_PlayerH.x + (((keyboard_check(settings.left[0]) or keyboard_check(settings.left[1])) and !(keyboard_check(settings.right[0]) or keyboard_check(settings.right[1]))) ? -10*irandom_range(4, 8) : (((keyboard_check(settings.right[0]) or keyboard_check(settings.right[1])) and !(keyboard_check(settings.left[0]) or keyboard_check(settings.left[1]))) ? 10*irandom_range(4, 8) : 0)) - 224)/24), 1, 5));
					}until(PrevAleatorio != Aleatorio);
					PrevAleatorio = Aleatorio;
					Direccion = irandom(1);
					audio_play_sound(snd_encounter, 0, false);
					var aux = instance_create_layer(0,0,"Bullet",obj_bullet);
					aux.Aleatorio = Aleatorio;
					aux.Direccion = Direccion;
					with (aux){
						Persiste = false;
						Type = "";
						Fondo = false;
						Depth = 1;
						Timer = 0;
						WithBox = true;
						Update = function(){	
							Timer += 1;
						}
						Draw = function(){
							draw_line_width_color(236 + 24*Aleatorio,254,236 + 24*Aleatorio,384,2,c_red,c_red);
							draw_line_width_color(282 + 24*Aleatorio,254,282 + 24*Aleatorio,384,2,c_red,c_red);
							draw_line_width_color(235 + 24*Aleatorio,255 + 128*Direccion,283 + 24*Aleatorio,255 + 128*Direccion,2,c_red,c_red);
						}
						Delete = function(){
							return (Timer >= 20);
						}
					}
					if (BoneTimer == -1){
						BoneTimer = 0;
					}
				}
				if (BoneTimer == 19){
					for (i = 0;i < ds_list_size(Bones);i++){
						if (i >= 2*Aleatorio and i < 4 + 2*Aleatorio){
							Bones[|i].Move = 1 - 2*Direccion;
						}else{
							Bones[|i].Move = 0;
						}
						Bones[|i].Karma = 6;
					}
				}
				for (var i=0;i<ds_list_size(Bones);i++){
					if (BoneTimer > 20 and Bones[|i].Move != 0){
						Bones[|i].y = 320 + (137 - 131/5*min(BoneTimer - 20,5) + 131/5*max(BoneTimer - 30, 0))*Bones[|i].Move;
						Bones[|i].Head.Top.y = Bones[|i].y - Bones[|i].image_yscale;
						Bones[|i].Head.Bottom.y = Bones[|i].y + Bones[|i].image_yscale;
					}
				}
				if (BoneTimer >= 35){
					BoneTimer = 15;
				}
				if (timer >= 360){
					AttackDone = true;
					ds_list_destroy(Bones);
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-5": {
			obj_Box.BoxSize.x = 360;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell,0,false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			Platform(80, 320, 60, 0, 1, 0, [680, 0, -40, 480], [""], [15, 25, 0, 0]).image_alpha = 0;
			Platform(675, 280, 60, 0, -4, 0, [680, 0, -40, 480], [""], [0]);
			Platform(675, 356, 60, 0, -2, 0, [680, 0, -40, 480], [""], [0]);
			timer = -10;
			Update = function(){
				timer++;
				if (timer%3 == 0){
					if (timer > 5 and timer <= 21){
						Bone(505 + 2*timer/3, 376, 20, 0, 0, -4, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{ if ((timer > 21 and timer <= 30) or (timer > 66 and timer <= 81)){
						Bone(505 + 2*timer/3, 341, 90, 0, 0, -4, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{ if ((timer > 30 and timer <= 66) or (timer > 267 and timer <= 294)){
						Bone(505 + 2*timer/3, 360, 52, 0, 0, -4, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{ if (timer == 114){
						Bone(505 + 2*timer/3, 366, 42, 0, 0, -4, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{ if (timer == 297 or timer == 300){
						Bone(505 + 2*timer/3, 340, 90, 0, 0, -4, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}else{ if ((timer > 66 and timer <= 210) or (timer > 260 and timer <= 267)){
						Bone(505 + 2*timer/3, 379, 14, 0, 0, -4, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}}}}}}
				}
				if (timer%4 == 0 and timer > 107 and timer <= 116){
					Bone(505 + 2*(timer - 108)/4, 283, 56, 0, 0, -3, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
				}else{ if (timer == 140 or timer == 180){
					for (var i=0;i<3;i++){
						Bone(135 - 14*i, 265, 20, 0, 0, 2.5, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}
				}else{ if (timer == 99){
					Platform(-33, 280, 60, 0, 2.5, 0, [680, 0, -40, 480], [""], [15, 60, 0, 0])
				}else{ if (timer == 200){
					for (var i=0;i<2;i++){
						Bone(135 - 14*i, 340, 90, 0, 0, 4.5, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}
				}else{ if (timer == 230){
					for (var i=0;i<12;i++){
						Bone(505 + 14*i, 290 - 15*min(max(i - 1, 0), 1), 70 - 30*min(max(i - 1, 0), 1), 0, 0, -2, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
					}
				}else{ if (timer == 280){
					Bone(505, 371, 28, 0, 0, -6, 0, [740, 0, 0, 480], "", 1, 0, 0, true, false);
				}}}}}}
				with (obj_Platform){
					if (image_alpha < 1){
						image_alpha += 0.1;
					}
				}
				if (timer >= 420){
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-4": {
			obj_Box.BoxSize.x = 360;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Blue"){
				obj_PlayerH.Mode = "Blue";
				audio_play_sound(snd_bell, 0, false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, make_color_rgb(0, 60, 255));
			}
			timer = -10;
			Platform(-40, 345, 60, 0, 4.5, 0, [680, 0, -40, 480], [""], [0]);
			Update = function(){
				timer++;
				if (timer == 22){
					Platform(-40, 300, 60, 0, 4, 0, [680, 0, -40, 480], [""], [15, 30, 0, 0]);
					Platform(-52, 345, 60, 0, 4, 0, [680, 0, -52, 480], [""], [0]);
				}else{ if (timer == 56){
					Bone(135, 335, 90, 0, 0, 4, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}else{ if (timer == 60){
					Platform(-40, 325, 60, 0, 3.5, 0, [680, 0, -40, 480], [""], [0]);
				}else{ if (timer == 74){
					Bone(135, 283, 46, 0, 0, 4, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}else{ if (timer == 110){
					Bone(135, 340, 80, 0, 0, 6, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
					Bone(135, 265, 10, 0, 0, 6, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}else{ if (timer == 131){
					Platform(-75, 290, 60, 0, 4.5, 0, [695, 0, -75, 480], [""], [15, 30, 0, 0]);
					Platform(-55, 350, 90, 0, 4.5, 0, [680, 0, -55, 480], [""], [15, 30, 0, 0]);
				}else{ if (timer%3 == 0 and timer >= 141 and timer <= 165){
					Bone(135, 273, 26, 0, 0, 4.5, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}else{ if (timer == 168){
					Bone(135, 290, 60, 0, 0, 4.5, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}else{ if (timer == 185){
					Bone(135, 330, 100, 0, 0, 4.5, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}else{ if (timer == 220){
					Bone(135, 265, 10, 0, 0, 8, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}}}}}}}}}}
				if (timer%4 == 0 and timer > 0 and timer <= 200 and timer != 56){
					Bone(135, 380, 20, 0, 0, 4, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}
				if (timer > 300){
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-3": {
			Enemies[0].y = 195;
			obj_Box.BoxSize.y = 155;
			obj_PlayerH.y = 307.5;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Red"){
				obj_PlayerH.Mode = "Red";
				audio_play_sound(snd_bell, 0, false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, c_red);
			}
			Direccion = irandom(1);
			Update = function(){
				timer++;
				if (timer <= 300 and timer%20 == 0){
					if (timer <= 150){
						Bone(320 + 84*(1 - 2*Direccion), 347, 70, 0, 0, -4*(1 - 2*Direccion), 0, [403, 224, 237, 390], "", 1, 0, 0, true, false);
						Bone(320 - 84*(1 - 2*Direccion), 267, 70, 0, 0, 4*(1 - 2*Direccion), 0, [403, 224, 237, 390], "", 1, 0, 0, true, false);
					}else{
						Bone(280, 307 - 84*(1 - 2*Direccion), 70, 90, 0, 0, 4*(1 - 2*Direccion), [403, 224, 237, 390], "", 1, 0, 0, true, false);
						Bone(360, 307 + 84*(1 - 2*Direccion), 70, 90, 0, 0, -4*(1 - 2*Direccion), [403, 224, 237, 390], "", 1, 0, 0, true, false);
					}
				}
				if (timer > 345){
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-2": {
			obj_Box.BoxSize.x = 360;
			aux = 0;
			start = irandom(1);
			Random = irandom(1);
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Red"){
				obj_PlayerH.Mode = "Red";
				audio_play_sound(snd_bell, 0, false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, c_red);
			}
			Update = function(){
				timer++;
				if (timer%48 == 24*start and timer <= 330){
					aux = min(max(20*irandom_range(-2,2), aux - 40), aux + 40);
					Bone(135, 255 + aux, 100, 0, 0, 4, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
					Bone(135, 390 + aux, 100, 0, 0, 4, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}
				if (timer%48 == 24 - 24*start and timer <= 330){
					aux = min(max(20*irandom_range(-2,2), aux - 40), aux + 40);
					Bone(505, 255 + aux, 100, 0, 0, -4, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
					Bone(505, 390 + aux, 100, 0, 0, -4, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}
				if (timer%54 == 24 and timer <= 330){
					if (Random == 0){
						Bone(505, 320, 120, 0, 0, -6, 0, [505, 0, 135, 480], "Blue", 1, 0, 1, true, false);
						Bone(135, 320, 120, 0, 0, 6, 0, [505, 0, 135, 480], "Orange", 1, 0, 1, true, false);
					}else{
						Bone(505, 320, 120, 0, 0, -6, 0, [505, 0, 135, 480], "Orange", 1, 0, 1, true, false);
						Bone(135, 320, 120, 0, 0, 6, 0, [505, 0, 135, 480], "Blue", 1, 0, 1, true, false);
					}
				}
				if (timer > 360){
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-1": {
			obj_Box.BoxSize.x = 360;
			PrevPos = -1;
			Pos = -1;
			Zoom = undefined;
			if (obj_PlayerH.Mode != "Red"){
				obj_PlayerH.Mode = "Red";
				audio_play_sound(snd_bell, 0, false);
				Zoom = layer_sprite_create(layer_get_id("Bullet"), 320, 320, spr_heart);
				layer_sprite_speed(Zoom, 0);
				layer_sprite_blend(Zoom, c_red);
			}
			Update = function(){
				timer++;
				if (timer%15 == 10 and timer <= 265){
					if (PrevPos == -1){
						PrevPos = 50;
					}else{
						do{
							PrevPos = min(max(PrevPos + 20*(1 - 2*irandom(1)), 10), 90);
						}until(Pos != PrevPos);
					}
					Pos = PrevPos;
					Bone(135, 307 - PrevPos, 100, 0, 0, 8, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
					Bone(135, 438 - PrevPos, 100, 0, 0, 8, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
					Bone(505, 307 - PrevPos, 100, 0, 0, -8, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
					Bone(505, 438 - PrevPos, 100, 0, 0, -8, 0, [505, 0, 135, 480], "", 1, 0, 0, true, false);
				}
				if (timer > 300){
					AttackDone = true;
				}
				if (!is_undefined(Zoom)){
					layer_sprite_xscale(Zoom, layer_sprite_get_xscale(Zoom) + 0.1);
					layer_sprite_yscale(Zoom, layer_sprite_get_yscale(Zoom) + 0.1);
					layer_sprite_alpha(Zoom, layer_sprite_get_alpha(Zoom) - 0.05);
					if (layer_sprite_get_alpha(Zoom) <= 0){
						layer_sprite_destroy(Zoom);
						Zoom = undefined;
					}
				}
			}
			Draw = function(){
			}
		break;}
		case "Attack 1-0": {
			timer = 14;
			if (Enemies[0].Sans.TorsoID != 12){
				Enemies[0].SlamType = 0;
			}else{
				Enemies[0].SlamType = 1;
			}
			TextEngine = new startTextEngine(false);
			CurrentDialog = TextEngine.create(420, 75, ["[noZ]"], "[font:" + string(int64(fn_sans)) + "][voice:" + string(int64(snd_pipsans)) + "][waitall:1.5][color:0,0,0]");
			if (!events.firstattacksurvived){
				DialogSequence = lanGetText("Phase 1-0A");
			}else{
				DialogSequence = lanGetText("Phase 1-0B");
			}
			fase = 0;
			aux = 0;
			obj_PlayerH.Mode = "Red";
			audio_play_sound(snd_bell, 0, false);
			Zoom = [layer_sprite_create(layer_get_id("Bullet"), 320, 385 - 155/2, spr_heart)];
			layer_sprite_speed(Zoom[0], 0);
			layer_sprite_blend(Zoom[0], c_red);
			Update = function(){
				timer++;
				if (timer >= 15 and timer <= 45){
					Bone(315 - round(155/2), 360 - 12.5*sin(degtorad(360/30*(timer - 15))), 50 + 25*sin(degtorad(360/30*(timer - 15))), 0, 0, 12, 0, [325 + round(155/2), 347, 315 - round(155/2), 373], "", 1, 0, 0, true, false);
					Bone(315 - round(155/2), 255 - 12.5*sin(degtorad(360/30*(timer - 15))), 50 - 25*sin(degtorad(360/30*(timer - 15))), 0, 0, 12, 0, [325 + round(155/2), 242, 315 - round(155/2), 268], "", 1, 0, 0, true, false);
				}else{ if (timer == 52){
					audio_play_sound(snd_bell, 0, false);
					Enemies[0].Sans.Ojo = true;
					Enemies[0].SlamDir = "Down";
					Enemies[0].Slamtimer = 0;
					obj_PlayerH.Mode = "Blue";
					Zoom[1] = layer_sprite_create(layer_get_id("Bullet"), obj_PlayerH.x, obj_PlayerH.y, spr_heart);
					layer_sprite_speed(Zoom[1], 0);
					layer_sprite_blend(Zoom[1], make_color_rgb(0,60,255));
				}else{ if (timer == 57){
					obj_PlayerH.gravity_data.Jump = -200;
					FloorBones(0, 50, 15, 15, 10, "", 1, 0, 1, false);
				}else{ if (timer == 72){
					Enemies[0].SlamDir = "Up";
					Enemies[0].Slamtimer = 4;
				}else{ if (timer == 88){
					Enemies[0].Sans.Ojo = false;
					Enemies[0].Sans.HeadID = 5;
					Enemies[0].SlamDir = "Reset";
				}else{ if (timer >= 90 and timer <= 120){
					Bone(372.5 - 12.5*sin(degtorad(360/30*(timer - 90))), 225, 50 + 25*sin(degtorad(360/30*(timer - 90))), 90, 0, 0, 12, [385, 225, 360, 390], "", 1, 0, 0, true, false);
					Bone(267.5 - 12.5*sin(degtorad(360/30*(timer - 90))), 225, 50 - 25*sin(degtorad(360/30*(timer - 90))), 90, 0, 0, 12, [280, 225, 255, 390], "", 1, 0, 0, true, false);
				}else{ if (timer == 127){
					Enemies[0].Sans.Ojo = true;
					Enemies[0].SlamDir = "Up";
					Enemies[0].Slamtimer = 0;
				}else{ if (timer == 132){
					obj_PlayerH.gravity_data.Dir = "Up";
					obj_PlayerH.gravity_data.Jump = -200;
					FloorBones(2, 50, 15, 15, 10, "", 1, 0, 1, false);
				}else{ if (timer == 157){
					Enemies[0].SlamDir = "Down";
					Enemies[0].Slamtimer = 4;
				}else{ if (timer == 162){
					obj_PlayerH.gravity_data.Dir = "Down";
					obj_PlayerH.gravity_data.Jump = -200;
					FloorBones(0, 50, 15, 15, 10, "", 1, 0, 1, false);
				}else{ if (timer == 187){
					Enemies[0].SlamDir = "Left";
					Enemies[0].Slamtimer = 4;
				}else{ if (timer == 192){
					obj_PlayerH.gravity_data.Dir = "Left";
					obj_PlayerH.gravity_data.Jump = -200;
					GB = Blaster(40, 100, 0, [0, -100, -100], 0, 2, "", 10, 20, "", [5, 5], 1, 0, -1, false);
				}else{ if (timer > 192 and timer <= 198){
					obj_PlayerH.x -= 205/6;
					obj_Box.BoxSize.x = 156 + 205/6*(timer - 192);
					obj_Box.width = obj_Box.BoxSize.x;
					obj_Box.x = 320 - 102.5/6*(timer - 192);
				}else{ if (timer == 225){
					Enemies[0].SlamDir = "Right";
					Enemies[0].Slamtimer = 0;
				}else{ if (timer > 230 and timer <= 387){
					if (timer >= 265 and timer <= 334 and timer%3 == 1){
						for (var i=0;i<5 + floor(timer/334);i++){
							Bone(646 + 24*i, 360 + 12.5*sin(degtorad(360/60*(5*(timer - 265)/3 + i))), 50 - 25*sin(degtorad(360/60*(5*(timer - 265)/3 + i))), 0, 0, -40, 0, [5000, -5, -5, 480], "", 1, 0, 0, true, false);
							Bone(646 + 24*i, 255 + 12.5*sin(degtorad(360/60*(5*(timer - 265)/3 + i))), 50 + 25*sin(degtorad(360/60*(5*(timer - 265)/3 + i))), 0, 0, -40, 0, [5000, -5, -5, 480], "", 1, 0, 0, true, false);
						}
					}else{ if (timer >= 336 and timer <= 363 and timer%3 == 0){
						for (var i=0;i<5 + floor(timer/363);i++){
							Bone(660 + 24*i, 385 - 31/50*(5*(timer - 336)/3 + i), 62/50*(5*(timer - 336)/3 + i), 0, 0, -40, 0, [6000, -5, -5, 480], "", 1, 0, 0, true, false);
							Bone(660 + 24*i, 230 + 31/50*(5*(timer - 336)/3 + i), 62/50*(5*(timer - 336)/3 + i), 0, 0, -40, 0, [6000, -5, -5, 480], "", 1, 0, 0, true, false);
						}
					}else{ if (timer == 380){
						Blaster(560, 307.5, 270, [0, 740, -100], 0, 2, "", 20, 15, "", [5, 5], 1, 0, -1, false);
					}}}
					if (instance_exists(GB)){
						GB.GB.x -= 40;
					}
					obj_PlayerH.gravity_data.Dir = "Right";
					obj_PlayerH.gravity_data.Jump = -200;
					obj_PlayerH.x = min(obj_PlayerH.x, 200);
					obj_Box.BoxSize.x = 361 + 279/7*min(timer - 230, 7) - 242/6*max(timer - 381, 0);
					obj_Box.BoxSize.y = 155 - 35/60*min(timer - 230, 60);
					obj_Box.width = obj_Box.BoxSize.x;
					obj_Box.x = 217.5 + 139.5/7*min(timer - 230, 7) - min(40*max(timer - 230, 0), 37) - 121/6*max(timer - 381, 0);
					obj_Box.y = 390 - 17.5/60*max(min(timer - 231, 60), 0);
					var aux = 40*(timer - 220.5) - 200/157*(timer - 230);
					Enemies[0].x = 700 - aux%760;
					switch (floor(aux/760)){
						case 1:
							Enemies[0].Sans.Ojo = false;
							Enemies[0].SlamDir = "None";
							Enemies[0].Sans.HeadID = 3;
							Enemies[0].Sans.TorsoID = 0;
						break;
						case 2:
							Enemies[0].Sans.HeadID = 5;
							Enemies[0].Sans.TorsoID = 16;
						break;
						case 3:
							Enemies[0].Sans.HeadID = 4;
							Enemies[0].Sans.TorsoID = 12;
						break;
						case 4:
							Enemies[0].Sans.HeadID = 16;
							Enemies[0].Sans.TorsoID = 0;
						break;
						case 5:
							Enemies[0].Sans.HeadID = 2;
							Enemies[0].Sans.TorsoID = 16;
						break;
						case 6:
							Enemies[0].Sans.Ojo = true;
							Enemies[0].Sans.TorsoID = 12;
						break;
						case 7:
							Enemies[0].Sans.Ojo = false;
							Enemies[0].Sans.HeadID = 15;
							Enemies[0].Sans.TorsoID = 0;
						break;
						case 8:
							Enemies[0].Sans.HeadID = 0;
							Enemies[0].SlamType = 0;
							Enemies[0].SlamDir = "Right";
							Enemies[0].Sans.Ojo = true;
						break;
					}
					bt_FIGHT.x = 555 - 40*min(timer - 230, 31) + 2520*min(max(timer - 290, 0), 1) - 40*max(timer - 355, 0);
					bt_ACT.x = 400 - 40*min(timer - 230, 31) + 2520*min(max(timer - 290, 0), 1) - 40*max(timer - 355, 0);
					bt_ITEM.x = 240 - 40*min(timer - 230, 31) + 2520*min(max(timer - 290, 0), 1) - 40*max(timer - 355, 0);
					bt_MERCY.x = 87 - 40*min(timer - 230, 31) + 2520*min(max(timer - 290, 0), 1) - 40*max(timer - 355, 0);
				}else{ if (timer == 390){
					FloorBones(1, 50, 15, 15, 10, "", 1, 0, 1, false);
				}else{ if (timer == 404){
					Enemies[0].SlamDir = "Left";
					Enemies[0].Slamtimer = 5;
				}else{ if (timer > 406 and timer <= 412){
					obj_Box.BoxSize.y = 120 + 35/5*min(timer - 406, 5);
					obj_Box.y = 372.5 + 17.5/5*max(timer - 407, 0);
				}else{ if (timer > 417 and timer <= 425){
					if (timer == 418){
						Enemies[0].Sans.Ojo = false;
						Enemies[0].Sans.HeadID = 5;
						Enemies[0].SlamDir = "Reset";
					}
					obj_Box.BoxSize.x = 155;
					obj_Box.x = 199 + min(20*(timer - 418), 121);
				}else{ if (timer >= 475 and (fase == 0 or ds_list_empty(TextEngine.AllTextData) or (TextEngine.AllTextData[|0].data.aux_Ntext == string_length(TextEngine.AllTextData[|0].text[0]) and (keyboard_check_pressed(settings.confirm[0]) or keyboard_check_pressed(settings.confirm[1]))))){
					if (fase >= array_length(DialogSequence)){
						Enemies[0].Sans.HeadID = 0;
						Enemies[0].Sans.TorsoID = 0;
						AttackDone = true;
					}else{
						CurrentDialog.editActText([DialogSequence[fase]]);
					}
					fase++;
				}}}}}}}}}}}}}}}}}}}}
				if (AttackDone){
					ds_list_destroy(CurrentDialog.data.posVar);
					ds_list_destroy(TextEngine.AllTextData);
					CurrentDialog = undefined;
					TextEngine = undefined;
					events.firstattacksurvived = true;
				}else{
					TextEngine.Update();
				}
				for (var i=0;i<array_length(Zoom);i++){
					if (!is_undefined(Zoom[i])){
						layer_sprite_xscale(Zoom[i], layer_sprite_get_xscale(Zoom[i]) + 0.1);
						layer_sprite_yscale(Zoom[i], layer_sprite_get_yscale(Zoom[i]) + 0.1);
						layer_sprite_alpha(Zoom[i], layer_sprite_get_alpha(Zoom[i]) - 0.05);
						if (layer_sprite_get_alpha(Zoom[i]) <= 0){
							layer_sprite_destroy(Zoom[i]);
							Zoom[i] = undefined;
						}
					}
				}
			}
			Draw = function(){
				if (fase != 0 and fase != 3 and !is_undefined(TextEngine)){
					draw_sprite(spr_dialogBubble, 0, 420, 75);
					TextEngine.Draw();
				}
			}
		break;}
		case "Intro Phase 1": {
			obj_Box.y = 1000;
			obj_PlayerH.Mode = "None";
			obj_PlayerH.y = 1000;
			obj_Box.BoxSize.y = 155;
			Enemies[0].Sans.HeadID = 4;
			Enemies[0].Sans.TorsoID = 12;
			Layer = layer_create(0);
			Negro = layer_sprite_create(Layer, 0, 0, spr_white);
			layer_sprite_xscale(Negro, 320);
			layer_sprite_yscale(Negro, 240);
			layer_sprite_blend(Negro, c_black);
			layer_sprite_alpha(Negro, 0);
			TextEngine = new startTextEngine(false);
			CurrentDialog = TextEngine.create(420, 100, [""], "[noZ][font:" + string(int64(fn_sans)) + "][voice:" + string(int64(snd_pipsans)) + "][waitall:1.5][color:0,0,0]");
			DialogSequence = lanGetText("BtIntro " + string(min(events.sansmeet, 3)));
			fase = -1;
			timer = 0;
			Zoom = [];
			Update = function(){
				if (fase == -1){
					timer++;
					if (timer == 45){
						timer = 0;
						fase++;
					}
				}else{ if (fase == 2 and ds_list_empty(TextEngine.AllTextData)){
					timer++;
					if (timer == 1){
						with (obj_Encounter){
							MusicSwap(NaN, 0);
						}
						layer_sprite_alpha(Negro, 1);
						audio_play_sound(snd_st, 0, false);
						obj_Box.y = 390;
						obj_PlayerH.x = 320;
						obj_PlayerH.y = 308;
						Enemies[0].y = 195;
						Enemies[0].Animation = "None";
					}else{ if (timer == 4){
						audio_play_sound(snd_st, 0, false);
						layer_sprite_destroy(Negro);
						layer_destroy(Layer);
						AttackDone = true;
					}}
				}else{ if (fase == 5){
					timer++;
					if (timer == 45){
						with (obj_Encounter){
							MusicSwap(mus_megalovania_intro, 250, false);
						}
					}else{ if (timer == 400){
						timer = 0;
						fase++;
					}}
				}else{ if (fase == 10){
					timer++;
					if (timer == 30){
						timer = 0;
						audio_play_sound(snd_st, 0, false);
						layer_sprite_destroy(Negro);
						layer_destroy(Layer);
						fase++;
					}
				}else{ if (fase == 12){
					timer++;
					if (timer >= 120){
						AttackDone = true;
					}
				}}}}}
				if (fase >= 0 and fase <= 11 and fase != 5 and fase != 10 and !ds_list_empty(TextEngine.AllTextData) and (fase == 0 or fase == 11 or fase == 6 or (TextEngine.AllTextData[|0].data.aux_Ntext == string_length(TextEngine.AllTextData[|0].text[0]) and (keyboard_check_pressed(settings.confirm[0]) or keyboard_check_pressed(settings.confirm[1]))))){
					if (fase == 4 or fase == 9){
						CurrentDialog.editActText([""]);
						Enemies[0].Sans.HeadID = 4 + floor(fase/10);
						Enemies[0].Sans.TorsoID = 12;
						if (fase == 9){
							layer_sprite_alpha(Negro, 1);
							audio_play_sound(snd_st, 0, false);
							obj_Box.y = 390;
							obj_PlayerH.x = 320;
							obj_PlayerH.y = 308;
							Enemies[0].y = 195;
							TextEngine.AllTextData[|0].y = 75;
						}
					}else{ if (array_length(DialogSequence) > fase - clamp(fase - 4, 0, 2) - max(fase - 9, 0)){
						CurrentDialog.editActText(DialogSequence[fase - clamp(fase - 4, 0, 2) - max(fase - 9, 0)]);
					}else{
						ds_list_destroy(TextEngine.AllTextData[|0].data.posVar);
						ds_list_delete(TextEngine.AllTextData,0);
					}}
					fase++;
				}
				if (AttackDone){
					Enemies[0].Animation = "Normal";
					Enemies[0].timer = 0;
					if (ds_exists(CurrentDialog.data.posVar, ds_type_list)){
						ds_list_destroy(CurrentDialog.data.posVar);
					}
					ds_list_destroy(TextEngine.AllTextData);
					CurrentDialog = -1;
					TextEngine = -1;
					obj_Encounter.CurrentAttacks = [new Attacks("Attack 1-0")];
				}else{
					TextEngine.Update();
				}
			}
			Draw = function(){
				if (fase > 0 and fase != 5){
					if (fase != 12){
						draw_sprite(spr_dialogBubble, 0, 420, -120 + Enemies[0].y);
					}else{
						draw_sprite(spr_dialogSmallBubble, 0, 420, -120 + Enemies[0].y);
					}
					TextEngine.Draw();
				}
			}
		break;}
		case "Temmie": {
			bt_FIGHT.y = 1000;
			bt_ACT.y = 1000;
			bt_ITEM.y = 1000;
			bt_MERCY.y = 1000;
			obj_PlayerH.x = 320;
			obj_PlayerH.y = 320;
			obj_Box.width = 155;
			TextEngine = new startTextEngine(false);
			CurrentDialog = TextEngine.create(418, 150, [""], "[voice:temmie][waitall:1.5][color:0,0,0]");
			if (events.temmie[0] == -1){
				events.temmie[0] = 0;
			}
			DialogSequence = lanGetText("Temmie " + string(events.temmie[0]));
			events.temmie[0]++;
			fase = -1;
			timer = 0;
			Update = function(){
				if (fase == -1){
					timer++;
					if (timer == 30){
						timer = 0;
						CurrentDialog.editActText(DialogSequence);
						fase++;
					}
				}else if (fase == 0 and ds_list_empty(TextEngine.AllTextData)){
					timer++;
					if (timer == 1){
						ds_list_destroy(CurrentDialog.data.posVar);
						ds_list_destroy(TextEngine.AllTextData);
						CurrentDialog = -1;
						TextEngine = -1;
						fase++;
						transition_black([0.02,0.02],0,Player.room,true);
					}
				}
				if (TextEngine != -1){
					TextEngine.Update();
				}
			}
			Draw = function(){
				if (fase == 0 and !ds_list_empty(TextEngine.AllTextData)){
					draw_sprite(spr_dialogBubble, 0, 420, -30 + Enemies[0].y);
					TextEngine.Draw();
				}
			}
		break;}
		default: { //Yeah this is just a Spare Attack
			Update = function(){
				timer++;
				if (timer > 30){
					AttackDone = true;
				}
			}
			Draw = function(){
				//Nothing
			}
		break;}
	}
}