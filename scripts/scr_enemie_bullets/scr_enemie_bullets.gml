function Blaster(xpos, ypos, angle, appear, velrot, size, follow, wait, stay, type, shake, damage, invulnerability, depthh, fondo, sound=true){
	if (sound){
		audio_play_sound(snd_GBcharge, 0, false);
	}
	var instancia = instance_create_depth(-100, -100, 100, obj_bullet);
	with (instancia){
		image_xscale = 0;
		image_yscale = 1000;
		sprite_index = spr_Laser;
		WithBox = false;
		Depth = depthh;
		Fondo = fondo;
		Type = type;
		Damage = damage;
		Karma = 10;
		Invulnerability = invulnerability;
		Follow = follow;
		VelRot = velrot;
		Shake = shake;
		Vel = 0;
		Persiste = false;
		CanDamage = false;
		GB = {x: xpos, y: ypos, Scale: {x: size, y: max(size, 1)}, Angle: angle, Frame: 0, Sound: sound};
		while (GB.Angle >= 360 or GB.Angle < 0) {
			if (GB.Angle < 0) {
				GB.Angle += 360;
			}else{
				GB.Angle -= 360;
			}
		}
		Timer = 0;
		Wait = wait;
		Stay = stay;
		Phase = appear[0];
		if (Phase == 0){
			Animation = {x: appear[1], y: appear[2], Angle: 180};
			while (Animation.Angle >= 360 or Animation.Angle < 0) {
				if (Animation.Angle < 0) {
					Animation.Angle += 360;
				}else{
					Animation.Angle -= 360;
				}
			}
		}else{
			x = xpos;
			y = ypos;
			image_angle = angle;
			x += 38*sin(degtorad(angle))*GB.Scale.y;
			y += 38*cos(degtorad(angle))*GB.Scale.y;
		}
		var aux = obj_PlayerH.Cyan.Dimension;
		if (Fondo){
			if (aux <= 0.5){
				depth = 400 + Depth;
			}else{
				depth = 100 + Depth;
			}
			if (Type == "Blue"){
				image_blend = make_color_rgb(8.25 + 24.75*aux, 48.75 + 146.25*aux, 63.75 + 191.25*aux);
			}else{
				image_blend = make_color_rgb(63.75 + 191.25*aux, 63.75 + 191.25*aux, 63.75 + 191.25*aux);
			}
		}else{
			if (aux <= 0.5){
				depth = 100 + Depth;
			}else{
				depth = 400 + Depth;
			}
			if (Type == "Blue"){
				image_blend = make_color_rgb(33 - 24.75*aux, 195 - 146.25*aux, 255 - 191.25*aux);
			}else{
				image_blend = make_color_rgb(255 - 191.25*aux, 255 - 191.25*aux, 255 - 191.25*aux);
			}
		}
		Update = function(){
			Timer++;
			switch (Phase){
				case 0:
					if (Follow == "Always" or Follow == "Before"){
						var aux = -radtodeg(arctan2(obj_PlayerH.y - GB.y, obj_PlayerH.x - GB.x)) + 90;
						Animation.Angle += (aux - GB.Angle);
						GB.Angle = aux;
						while (GB.Angle >= 360 or GB.Angle < 0) {
							if (GB.Angle < 0) {
								GB.Angle += 360;
							}else{
								GB.Angle -= 360;
							}
						}
						while (Animation.Angle >= 360 or Animation.Angle < 0) {
							if (Animation.Angle < 0) {
								Animation.Angle += 360;
							}else{
								Animation.Angle -= 360;
							}
						}
					}
					x = Animation.x + (GB.x - Animation.x)*sin(degtorad(90/18*Timer));
					y = Animation.y + (GB.y - Animation.y)*sin(degtorad(90/18*Timer));
					if ((GB.Angle - Animation.Angle >= 0 and GB.Angle - Animation.Angle <= 180) or (GB.Angle - Animation.Angle >= -360 and GB.Angle - Animation.Angle <= -180)) {
						image_angle = Animation.Angle + (GB.Angle - Animation.Angle + 360)%360*sin(degtorad(90/18*Timer));
					}else{
						image_angle = Animation.Angle + (GB.Angle - Animation.Angle - 360)%360*sin(degtorad(90/18*Timer));
					}
					if (Timer >= 18){
						Phase++;
						Timer = 0;
					}
				break;
				case 1:
					x = GB.x;
					y = GB.y;
					if (Timer < Wait - 5 and (Follow == "Always" or Follow == "Before")){
						GB.Angle = -radtodeg(arctan2(obj_PlayerH.y - GB.y, obj_PlayerH.x - GB.x)) + 90;
					}
					image_angle = GB.Angle;
					if (Timer == Wait - 5){
						GB.Frame = 1;
					}else{ if (Timer == Wait - 3){
						GB.Frame = 2;
					}else{ if (Timer == Wait - 1){
						GB.Frame = 3;
					}else{ if (Timer >= Wait){
						if (GB.Sound){
							audio_play_sound(snd_GBshoot, 0, false);
						}
						obj_Encounter.Shake = Shake;
						GB.Frame = 3;
						Phase++;
						Wait = 0;
						Timer = 0;
					}}}}
				break;
				case 2:
					CanDamage = true;
					Stay--;
					GB.Frame = 5 - Timer%2;
					if (VelRot != 0 or Follow == "Always" or Follow == "After"){
						if (Follow == "Always" or Follow == "After"){
							var aux = -radtodeg(arctan2(obj_PlayerH.y - GB.y, obj_PlayerH.x - GB.x)) + 90;
							while (aux >= 360 or aux < 0) {
								if (aux < 0) {
									aux += 360;
								}else{
									aux -= 360;
								}
							}
							if ((aux - GB.Angle > 0 and aux - GB.Angle < 180) or (aux - GB.Angle > -360 and aux - GB.Angle < -180)) {
								GB.Angle += VelRot;
							}else{
								GB.Angle -= VelRot;
							}
							while (GB.Angle >= 360 or GB.Angle < 0) {
								if (GB.Angle < 0) {
									GB.Angle += 360;
								}else{
									GB.Angle -= 360;
								}
							}
						}else{
							GB.Angle += VelRot;
						}
						image_angle = GB.Angle;
					}else{
						GB.x -= Vel*sin(degtorad(image_angle));
						GB.y -= Vel*cos(degtorad(image_angle));
						Vel *= 1.25;
						if (GB.x < -100 or GB.x > 740 or GB.y < -100 or GB.y > 580){
							Vel = 0;
						}else{ if (Vel < 5){
							Vel = 5;
						}}
					}
					x = GB.x;
					y = GB.y;
					if (image_xscale < 27.9*GB.Scale.x and Wait == 0){
						image_xscale = min(image_xscale + 12.4*GB.Scale.x, 27.9*GB.Scale.x);
					}else{
						Wait += 100;
						image_xscale = 27.9*GB.Scale.x + 3.1*GB.Scale.x*sin(degtorad(Wait));
					}
					if (Stay <= 0 and Wait > 0){
						Phase++;
						Vel = max(Vel, 5);
					}
				break;
				case 3:
					CanDamage = false;
					GB.Frame = 5 - Timer%2;
					GB.x -= Vel*sin(degtorad(image_angle));
					GB.y -= Vel*cos(degtorad(image_angle));
					Vel *= 1.25;
					if (GB.x < -100 or GB.x > 740 or GB.y < -100 or GB.y > 580){
						Vel = 0;
					}
					x = GB.x;
					y = GB.y;
					if (image_xscale > 0){
						image_xscale -= 1.55*GB.Scale.x;
						image_alpha = max(image_xscale, 0)/31;
					}else{ if (x > 740 or x < -100 or y > 580 or y < -100){
						Phase++;
					}}
				break;
			}
			x += 38*sin(degtorad(image_angle))*GB.Scale.y;
			y += 38*cos(degtorad(image_angle))*GB.Scale.y;
		}
		Draw = function(){
			draw_sprite_ext(spr_Laser, 0, x + GB.Scale.y*sin(degtorad(image_angle)), y + GB.Scale.y*cos(degtorad(image_angle)), image_xscale - image_xscale/31*14, 10*GB.Scale.y, image_angle, image_blend, image_alpha);
			draw_sprite_ext(spr_Laser, 0, x + 11*GB.Scale.y*sin(degtorad(image_angle)), y + 11*GB.Scale.y*cos(degtorad(image_angle)), image_xscale - image_xscale/31*7, 10*GB.Scale.y, image_angle, image_blend, image_alpha);
			draw_sprite_ext(spr_Laser, 0, x + 21*GB.Scale.y*sin(degtorad(image_angle)), y + 21*GB.Scale.y*cos(degtorad(image_angle)), image_xscale, 1000 - 20*GB.Scale.y, image_angle, image_blend, image_alpha);
			draw_sprite_ext(spr_Blaster, GB.Frame, x - 38*GB.Scale.y*sin(degtorad(image_angle)), y - 38*GB.Scale.y*cos(degtorad(image_angle)), GB.Scale.x, GB.Scale.y, image_angle, image_blend, 1);
		}
		Delete = function(){
			return (Phase >= 4);
		}
	}
	return instancia;
}

function Platform(xpos, ypos, length, direction, velX, velY, limits, type, fragil){
	var instancia = instance_create_depth(xpos, ypos, 99, obj_Platform);
	with (instancia){
		hspeed = velX;
		vspeed = velY;
		image_xscale = length/2;
		image_angle = 90*direction;
		Length = length;
		Limits = limits;
		Type = type;
		Fragile = fragil;
		if (Type[0] == "Conveyor"){
			image_blend = make_color_rgb(191, 76, 0);
		}else{ if (Type[0] == "Trampoline"){
			image_blend = make_color_rgb(0, 148, 255);
		}else{ if (Type[0] == "Sticky"){
			image_blend = make_color_rgb(127.5, 0, 191);
		}else{
			image_blend = make_color_rgb(0, 127.5, 0);
		}}}
		Delete = function(){
			return (x < Limits[2] or x > Limits[0] or y > Limits[3] or y < Limits[1]);
		}
	}
	return instancia;
}

function Bone(xpos, ypos, length, angle, velrot, velX, velY, limits, type, damage, invulnerability, depthh, box, fondo, kr=5){
	var instancia = instance_create_depth(xpos, ypos, 100, obj_bullet);
	with (instancia){
		sprite_index = spr_bonebody;
		image_angle = angle;
		image_yscale = length/2;
		Type = type;
		WithBox = box;
		Damage = damage;
		Invulnerability = invulnerability;
		Karma = kr;
		Fondo = fondo;
		Borrar = false;
		Persiste = false;
		Limits = limits;
		Depth = depthh;
		Vel = {x: velX, y: velY, rot: velrot};
		var aux = obj_PlayerH.Cyan.Dimension;
		if (Fondo){
			if (aux <= 0.5){
				depth = 400 + Depth;
			}else{
				depth = 100 + Depth;
			}
			if (Type == "Blue"){
				image_blend = make_color_rgb(8.25 + 24.75*aux, 48.75 + 146.25*aux, 63.75 + 191.25*aux);
			}else{ if (Type == "Orange"){
				image_blend = make_color_rgb(63.75 + 191.25*aux, 37.5 + 112.5*aux, 0);
			}else{ if (Type == "Green"){
				image_blend = make_color_rgb(17.75 + 53.25*aux, 63.75 + 191.25*aux, 0);
			}else{
				image_blend = make_color_rgb(63.75 + 191.25*aux, 63.75 + 191.25*aux, 63.75 + 191.25*aux);
			}}}
		}else{
			if (aux <= 0.5){
				depth = 100 + Depth;
			}else{
				depth = 400 + Depth;
			}
			if (Type == "Blue"){
				image_blend = make_color_rgb(33 - 24.75*aux, 195 - 146.25*aux, 255 - 191.25*aux);
			}else{ if (Type == "Orange"){
				image_blend = make_color_rgb(255 - 191.25*aux, 150 - 112.5*aux, 0);
			}else{ if (Type == "Green"){
				image_blend = make_color_rgb(17.75 + 53.25*aux, 63.75 + 191.25*aux, 0);
			}else{
				image_blend = make_color_rgb(255 - 191.25*aux, 255 - 191.25*aux, 255 - 191.25*aux);
			}}}
		}
		Head = {Top: instance_create_depth(xpos - length/2*sin(degtorad(angle)), ypos - length/2*cos(degtorad(angle)), depth, obj_bullet), Bottom: instance_create_depth(xpos + length/2*sin(degtorad(angle)), ypos + length/2*cos(degtorad(angle)), depth, obj_bullet)};
		Head.Top.Body = self;
		Head.Bottom.Body = self;
		with (Head.Top){
			sprite_index = spr_bonehead;
			image_blend = Body.image_angle;
			Type = Body.Type;
			WithBox = Body.WithBox;
			Damage = Body.Damage;
			Invulnerability = Body.Invulnerability;
			Fondo = Body.Fondo;
			Persiste = false;
			Depth = Body.Depth;
			Borrar = false;
			Update = function() {
				image_angle = Body.image_angle;
				x = Body.x - Body.image_yscale*sin(degtorad(image_angle));
				y = Body.y - Body.image_yscale*cos(degtorad(image_angle));
			}
			Draw = function(boolean) {
				draw_self();
			}
			Delete = function() {
				return Borrar;
			}
		}
		with (Head.Bottom){
			sprite_index = spr_bonehead;
			image_angle = Body.image_angle + 180;
			image_blend = Body.image_blend;
			Type = Body.Type;
			WithBox = Body.WithBox;
			Damage = Body.Damage;
			Invulnerability = Body.Invulnerability;
			Fondo = Body.Fondo;
			Persiste = false;
			Depth = Body.Depth;
			Borrar = false;
			Update = function() {
				image_angle = Body.image_angle + 180;
				x = Body.x - Body.image_yscale*sin(degtorad(image_angle));
				y = Body.y - Body.image_yscale*cos(degtorad(image_angle));
			}
			Draw = function(boolean) {
				draw_self();
			}
			Delete = function() {
				return Borrar;
			}
		}
		Update = function(){
			image_angle += Vel.rot;
			x += Vel.x;
			y += Vel.y;
		}
		Draw = function(boolean){
			draw_self();
		}
		Delete = function(){
			var aux = ((x < Limits[2] or x > Limits[0] or y > Limits[3] or y < Limits[1]) or Borrar);
			if (aux){
				Head.Top.Borrar = true;
				Head.Bottom.Borrar = true;
			}
			return aux;
		}
	}
	return instancia;
}

function FloorBones(direction, height, wait, stay, increaseVel, type, damage, invulnerability, depthh, fondo){
	var instancia = instance_create_layer(0, -100, "BelowBullet", obj_bullet);
	with (instancia){
		sprite_index = spr_bunchbonesbody;
		image_angle = 90*direction;
		image_yscale = 0;
		Type = type;
		Depth = depthh;
		Damage = damage;
		Invulnerability = invulnerability;
		Fondo = fondo;
		Persiste = false;
		Phase = 0;
		Karma = 6;
		Sound = wait;
		Max = height;
		Wait = wait;
		Stay = stay;
		Vel = increaseVel;
		Pos = {x: 320, y: 240};
		if (image_angle%180 == 0){
			x = Pos.x;
			y = obj_Box.y - 5 - round(obj_Box.height)/2 + (round(obj_Box.height)/2 + 6)*cos(degtorad(image_angle));
		}else{
			x = obj_Box.x + (round(obj_Box.width)/2 + 6)*sin(degtorad(image_angle));
			y = Pos.y;
		}
		WithBox = true;
		var aux = obj_PlayerH.Cyan.Dimension;
		if (Fondo){
			if (aux <= 0.5){
				depth = 400 + Depth;
			}else{
				depth = 100 + Depth;
			}
			if (Type == "Blue"){
				image_blend = make_color_rgb(8.25 + 24.75*aux, 48.75 + 146.25*aux, 63.75 + 191.25*aux);
			}else{ if (Type == "Orange"){
				image_blend = make_color_rgb(63.75 + 191.25*aux, 37.5 + 112.5*aux, 0);
			}else{
				image_blend = make_color_rgb(63.75 + 191.25*aux, 63.75 + 191.25*aux, 63.75 + 191.25*aux);
			}}
		}else{
			if (aux <= 0.5){
				depth = 100 + Depth;
			}else{
				depth = 400 + Depth;
			}
			if (Type == "Blue"){
				image_blend = make_color_rgb(33 - 24.75*aux, 195 - 146.25*aux, 255 - 191.25*aux);
			}else{ if (Type == "Orange"){
				image_blend = make_color_rgb(255 - 191.25*aux, 150 - 112.5*aux, 0);
			}else{
				image_blend = make_color_rgb(255 - 191.25*aux, 255 - 191.25*aux, 255 - 191.25*aux);
			}}
		}
		Head = instance_create_depth(0, -100, depth, obj_bullet);
		Head.Body = self;
		with (Head){
			sprite_index = spr_bunchboneshead;
			image_angle = Body.image_angle;
			image_blend = Body.image_blend;
			image_alpha = Body.image_alpha;
			Persiste = false;
			Type = Body.Type;
			Depth = Body.Depth;
			Damage = Body.Damage;
			Invulnerability = Body.Invulnerability;
			Fondo = Body.Fondo;
			WithBox = true;
			GetLost = false;
			Update = function() {
				image_alpha = Body.image_alpha;
				x = Body.x - Body.image_yscale*sin(degtorad(Body.image_angle));
				y = Body.y - Body.image_yscale*cos(degtorad(Body.image_angle));
			}
			Draw = function(boolean) {
				draw_self();
			}
			Delete = function() {
				return GetLost;
			}
		}
		Update = function(){
			if (image_angle%180 == 0){
				x = Pos.x;
				y = obj_Box.y - 5 - round(obj_Box.height)/2 + (round(obj_Box.height)/2 + 6)*cos(degtorad(image_angle));
			}else{
				x = obj_Box.x + (round(obj_Box.width)/2 + 6)*sin(degtorad(image_angle));
				y = Pos.y;
			}
			switch (Phase){
				case 0:
					if (Wait == Sound){
						audio_play_sound(snd_encounter, 0, false);
					}
					Wait--;
					if (Wait <= 0){
						image_alpha = 1;
						audio_play_sound(snd_pierce, 0, false);
						Phase++;
					}
				break;
				case 1:
					image_yscale = min(image_yscale + Vel, Max);
					if (image_yscale >= Max){
						Phase++;
					}
				break;
				case 2:
					Stay--;
					image_yscale = Max;
					if (Stay <= 0){
						Phase++;
					}
				break;
				case 3:
					image_yscale = max(image_yscale - Vel, 0);
					if (image_yscale <= 0){
						Phase++;
					}
				break;
			}
		}
		Draw = function(boolean){
			if (Phase == 0){
				var aux = image_blend;
				if (Type != "Blue" and Type != "Orange"){
					aux = make_color_rgb((Fondo) ? 63.75 + 191.25*obj_PlayerH.Cyan.Dimension : 255 - 191.25*obj_PlayerH.Cyan.Dimension, 0, 0);
				}
				draw_line_width_color(obj_Box.x - 1 + max(Pos.x - obj_Box.x - 328, -round(obj_Box.width)/2 + 1)*cos(degtorad(image_angle)) + (round(obj_Box.width)/2 - Max + 1)*sin(degtorad(image_angle)), obj_Box.y - 6 - round(obj_Box.height)/2 + round(obj_Box.height)/2*cos(degtorad(image_angle)) + min(Pos.y - obj_Box.y + round(obj_Box.height)/2 + 328, round(obj_Box.height)/2 - 1)*sin(degtorad(image_angle)), obj_Box.x - 1 + max(Pos.x - obj_Box.x - 328, -round(obj_Box.width)/2 + 1)*cos(degtorad(image_angle)) + round(obj_Box.width)/2*sin(degtorad(image_angle)), obj_Box.y - 6 - round(obj_Box.height)/2 + (round(obj_Box.height)/2 - Max + 1)*cos(degtorad(image_angle)) + min(Pos.y - obj_Box.y + round(obj_Box.height)/2 + 328, round(obj_Box.height)/2 - 1)*sin(degtorad(image_angle)), 2, aux, aux);
				draw_line_width_color(obj_Box.x - 1 + min(Pos.x - obj_Box.x + 328, round(obj_Box.width)/2 - 1)*cos(degtorad(image_angle)) + (round(obj_Box.width)/2 - Max + 1)*sin(degtorad(image_angle)), obj_Box.y - 6 - round(obj_Box.height)/2 + round(obj_Box.height)/2*cos(degtorad(image_angle)) + max(Pos.y - obj_Box.y + round(obj_Box.height)/2 - 328, -round(obj_Box.height)/2 + 1)*sin(degtorad(image_angle)), obj_Box.x - 1 + min(Pos.x - obj_Box.x + 328, round(obj_Box.width)/2 - 1)*cos(degtorad(image_angle)) + round(obj_Box.width)/2*sin(degtorad(image_angle)), obj_Box.y - 6 - round(obj_Box.height)/2 + (round(obj_Box.height)/2 - Max + 1)*cos(degtorad(image_angle)) + max(Pos.y - obj_Box.y + round(obj_Box.height)/2 - 328, -round(obj_Box.height)/2 + 1)*sin(degtorad(image_angle)), 2, aux, aux);
				draw_line_width_color(obj_Box.x - 1 + max(Pos.x - obj_Box.x - 329, -round(obj_Box.width)/2)*cos(degtorad(image_angle)) + (round(obj_Box.width)/2 - Max + 1)*sin(degtorad(image_angle)), obj_Box.y - 6 - round(obj_Box.height)/2 + (round(obj_Box.height)/2 - Max + 1)*cos(degtorad(image_angle)) + min(Pos.y - obj_Box.y + round(obj_Box.height)/2 + 329, round(obj_Box.height)/2)*sin(degtorad(image_angle)), obj_Box.x - 1 + min(Pos.x - obj_Box.x + 329, round(obj_Box.width)/2)*cos(degtorad(image_angle)) + (round(obj_Box.width)/2 - Max + 1)*sin(degtorad(image_angle)), obj_Box.y - 6 - round(obj_Box.height)/2 + (round(obj_Box.height)/2 - Max + 1)*cos(degtorad(image_angle)) - min(Pos.y - obj_Box.y + round(obj_Box.height)/2 + 328, round(obj_Box.height)/2)*sin(degtorad(image_angle)), 2, aux, aux);
			}
			draw_self();
		}
		Delete = function(){
			if (Phase >= 4){
				Head.GetLost = true;
			}
			return (Phase >= 4);
		}
	}
	return instancia;
}