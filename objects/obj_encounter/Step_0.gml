if (keyboard_check_pressed(ord("L"))){
	Player.HP = 92;
}
if (musica2 != -1 and audio_sound_get_gain(musica2) == 1){
	audio_stop_sound(musica);
	musica = musica2;
	musica2 = -1;
}
if (musica != -1 and audio_sound_get_gain(musica) == 0){
	audio_stop_sound(musica);
	musica = -1;
}
if (DIE and not audio_is_playing(musica)){
	MusicSwap(mus_megalovania_the_end, 0);
}
if (Shake[0] > 0){
	Shake[0]--;
	camera_set_view_pos(view_get_camera(view_camera[0]), random_range(-Shake[1], Shake[1]), random_range(-Shake[1], Shake[1]));
}else{
	camera_set_view_pos(view_get_camera(view_camera[0]), 0, 0);
}
switch (State)
{
	case "EncounterStarting":
		EncounterStarts();
	break;
	case "ActionSelect":
		
	break;
	case "EnemySelect":
		if ((keyboard_check_pressed(settings.up[0]) or keyboard_check_pressed(settings.up[1]))){
			audio_play_sound(snd_pip, 0, false);
			Selecting[1]--;
			if (Selecting[1] <= -1){
				Selecting[1] += array_length(Enemies);
			}
		}
		if ((keyboard_check_pressed(settings.down[0]) or keyboard_check_pressed(settings.down[1]))){
			audio_play_sound(snd_pip, 0, false);
			Selecting[1]++;
			if (Selecting[1] >= array_length(Enemies)){
				Selecting[1] -= array_length(Enemies);
			}
		}
		if ((keyboard_check_pressed(settings.confirm[0]) or keyboard_check_pressed(settings.confirm[1]))){
			audio_play_sound(snd_pipcheck, 0, false);
			switch (BtOrder[Selecting[0]]){
				case "FIGHT":
					obj_PlayerH.image_alpha = 0;
					State = "Attacking";
					PlayerFight = new PlayerAttack(Player.weapon.name);
					PlayerFight.Initial();
				break;
				case "ACT":
					State = "ActMenu";
					var aux = "";
					for (var i=0;i<array_length(Enemies[Selecting[1]].ActComms);i++){
						aux += "   * " + Enemies[Selecting[1]].ActComms[i] + string_repeat(" ", max(11 - string_length(Enemies[Selecting[1]].ActComms[i]), 0));
						if ((i + 1)%2 == 0){
							aux += "\r";
						}
					}
					obj_Box.CurrentText.editActText(["[instant][novoice]" + aux]);
				break;
			}
		}
		if ((keyboard_check_pressed(settings.cancel[0]) or keyboard_check_pressed(settings.cancel[1]))){
			audio_play_sound(snd_pip, 0, false);
			obj_Box.CurrentText.editActText([obj_Box.Dialogs[obj_Box.Text]]);
			Selecting[1] = 0;
			State = "ActionSelect";
		}
	break;
	case "Attacking":
		PlayerFight.Update();
	break;
	case "ActMenu":
		var amountAct = array_length(Enemies[Selecting[1]].ActComms)
		if ((keyboard_check_pressed(settings.left[0]) or keyboard_check_pressed(settings.left[1]))){
			if (Selecting[2]%2 == 1){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] -= 1;
			}else{ if (Selecting[2]%2 == 0 and amountAct > Selecting[2] + 1){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] += 1;
			}}
		}
		if ((keyboard_check_pressed(settings.right[0]) or keyboard_check_pressed(settings.right[1]))){
			if (Selecting[2]%2 == 0 and amountAct > Selecting[2] + 1){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] += 1;
			}else{ if (Selecting[2]%2 == 1){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] -= 1;
			}}
		}
		if ((keyboard_check_pressed(settings.up[0]) or keyboard_check_pressed(settings.up[1]))){
			if (Selecting[2] > 1){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] -= 2;
			}else{
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] = amountAct + amountAct%2 + Selecting[2]*(1 - 2*(amountAct%2)) - 2;
			}
		}
		if ((keyboard_check_pressed(settings.down[0]) or keyboard_check_pressed(settings.down[1]))){
			if (amountAct <= Selecting[2] + 2){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] = Selecting[2]%2;
			}else{
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] += 2;
			}
		}
		if ((keyboard_check_pressed(settings.confirm[0]) or keyboard_check_pressed(settings.confirm[1]))){
			obj_PlayerH.image_alpha = 0;
			State = "DialogResult"
			audio_play_sound(snd_pipcheck, 0, false);
			obj_Box.CurrentText.editActText(Enemies[Selecting[1]].ACT(Enemies[Selecting[1]].ActComms[Selecting[2]]), "[font:" + string(fn_big_8bit) + "][voice:" + string(snd_ui) + "][xspace:16][yspace:32]");
		}
		if ((keyboard_check_pressed(settings.cancel[0]) or keyboard_check_pressed(settings.cancel[1]))){
			audio_play_sound(snd_pip, 0, false);
			var aux = "";
			for (var i=0;i<array_length(Enemies);i++){
				aux += "   * " + Enemies[i].Name;
				if (i + 1 < array_length(Enemies)){
					aux += "\r";
				}
			}
			obj_Box.CurrentText.editActText(["[instant][novoice]" + aux]);
			Selecting[2] = 0;
			State = "EnemySelect";
		}
	break;
	case "MercyMenu":
		if ((keyboard_check_pressed(settings.up[0]) or keyboard_check_pressed(settings.up[1]))){
			audio_play_sound(snd_pip, 0, false);
			Selecting[1]--;
			if (Selecting[1] <= -1){
				Selecting[1] += 1 + canFlee;
			}
		}
		if ((keyboard_check_pressed(settings.down[0]) or keyboard_check_pressed(settings.down[1]))){
			audio_play_sound(snd_pip, 0, false);
			Selecting[1]++;
			if (Selecting[1] >= 1 + canFlee){
				Selecting[1] -= 1 + canFlee;
			}
		}
		if ((keyboard_check_pressed(settings.confirm[0]) or keyboard_check_pressed(settings.confirm[1]))){
			audio_play_sound(snd_pipcheck, 0, false);
			switch (Selecting[1]){
				case 0:
					State = "EnemyDialogue";
					for (var i=0;i<array_length(Enemies);i++){
						Enemies[i].Spare();
					}
				break;
				case 1:
					State = "Flee";
					for (var i=0;i<array_length(Enemies);i++){
						Enemies[i].Flee();
					}
					FleeType.Initial();
				break;
			}
		}
		if ((keyboard_check_pressed(settings.cancel[0]) or keyboard_check_pressed(settings.cancel[1]))){
			audio_play_sound(snd_pip, 0, false);
			obj_Box.CurrentText.editActText([obj_Box.Dialogs[obj_Box.Text]]);
			Selecting[1] = 0;
			State = "ActionSelect";
		}
	break;
	case "ItemMenu":
		var amountItems = ds_list_size(Player.inventory);
		var PPage = Page;
		if ((keyboard_check_pressed(settings.left[0]) or keyboard_check_pressed(settings.left[1]))){
			if (Selecting[2]%2 == 1){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] -= 1;
			}else{ if (Selecting[2]%2 == 0 and Page == 2){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] += 1;
				Page += 3 - 2*Page;
			}}
		}
		if ((keyboard_check_pressed(settings.right[0]) or keyboard_check_pressed(settings.right[1]))){
			if (Selecting[2]%2 == 0 and amountItems > Selecting[2] + (Page - 1)*4 + 1){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] += 1;
			}else{ if (Selecting[2]%2 == 1 and amountItems > 4){
				audio_play_sound(snd_pip, 0, false);
				if (amountItems > 6 and Selecting[2] == 3){
					Selecting[2] = 2;
				}else{
					Selecting[2] = 0;
				}
				Page += 3 - 2*Page;
			}}
		}
		if ((keyboard_check_pressed(settings.up[0]) or keyboard_check_pressed(settings.up[1]))){
			if (Selecting[2] < 2 and amountItems > Selecting[2] + 2 + (Page - 1)*4){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] += 2;
			}else{ if(Selecting[2] > 1){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] -= 2;
			}}
		}
		if ((keyboard_check_pressed(settings.down[0]) or keyboard_check_pressed(settings.down[1]))){
			if (Selecting[2] < 2 and amountItems > Selecting[2] + 2 + (Page - 1)*4){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] += 2;
			}else{ if(Selecting[2] > 1){
				audio_play_sound(snd_pip, 0, false);
				Selecting[2] -= 2;
			}}
		}
		if (PPage != Page){
			var aux = "";
			for (var i=(Page - 1)*4;i<min(amountItems, Page*4);i++){
				aux += "   * " + Player.inventory[|i][0][1] + string_repeat(" ", max(11 - string_length(Player.inventory[|i][0][1]), 0));
				if ((i + 1)%2 == 0){
					aux += "\r";
				}
			}
			aux +=  string_repeat("\r", ceil((4 - min(amountItems - (Page - 1)*4, 4))/2)) + string_repeat(" ", 21) + "PAGE " + string(Page);
			obj_Box.CurrentText.editActText(["[instant][novoice]" + aux]);
		}
		if ((keyboard_check_pressed(settings.confirm[0]) or keyboard_check_pressed(settings.confirm[1])) and ds_list_size(Player.inventory) > 0){
			obj_PlayerH.image_alpha = 0;
			State = "DialogResult"
			obj_Box.CurrentText.editActText(ItemHandler("Use", Selecting[2] + (Page - 1)*4), "[font:" + string(fn_big_8bit) + "][voice:" + string(snd_ui) + "][xspace:16][yspace:32]");
		}
		if ((keyboard_check_pressed(settings.cancel[0]) or keyboard_check_pressed(settings.cancel[1]))){
			audio_play_sound(snd_pip, 0, false);
			obj_Box.CurrentText.editActText([obj_Box.Dialogs[obj_Box.Text]]);
			Selecting[2] = 0;
			State = "ActionSelect";
		}
	break;
	case "Flee":
		FleeType.Update();
	break;
	case "DialogResult":
		if (ds_list_size(obj_Box.FlavorText.AllTextData) <= 0) {
			State = "EnemyDialogue";
		}
	break;
	case "EnemyDialogue":
		obj_PlayerH.image_alpha = 1;
		var done = true;
		for (var i=0;i<array_length(Enemies);i++){
			if (ds_list_size(Enemies[i].Dialog.AllTextData) > 0){
				done = false;
			}
		}
		if (done == true){
			State = "Defending";
			if (CurrentMenuAttack != -1){
				CurrentMenuAttack.ForceEnd();
				CurrentMenuAttack = -1;
			}
			CurrentAttacks = [];
			for (var i=0;i<array_length(Enemies);i++){
				Enemies[i].DialogEnding();
				CurrentAttacks[i] = new Attacks(Enemies[i].NextAttack);
			}
		}
	break;
	case "Defending":
		var done = true;
		for (var i=0;i<array_length(CurrentAttacks);i++){
			if (CurrentAttacks[i].AttackDone == false){
				CurrentAttacks[i].Update();
				done = false;
			}
		}
		if (done == true){
			obj_PlayerH.image_alpha = 0;
			obj_PlayerH.image_angle = 0;
			obj_PlayerH.image_index = 0;
			with (obj_bullet){
				if (!Persiste){
					instance_destroy();
				}
			}
			with (obj_Platform){
				instance_destroy();
			}
			obj_PlayerH.Cyan = {Dimension: 0, Cooldown: 0, Tipo: 0, Timer: 0};
			obj_PlayerH.Blue = {Dir: "Down", Jump: 0, MaxJump: 40, CannotStopJump: false, CannotJump: false, OnPlatform: false, ignore_first_frame: false, Plat: {x: 0, y: 0, vel: {x: 0, y: 0}}, Push: {val: 0, count: 0}, PrevPlat: {found: false, plat: undefined}};
			obj_Box.BoxSize.x = 155;
			obj_Box.BoxSize.y = 130;
			State = "DefenseEnding";
		}
	break;
	case "DefenseEnding":
		if (obj_Box.width == 565 and obj_Box.height == 130 and obj_Box.x == 320 and obj_Box.y == 390){
			obj_PlayerH.image_alpha = 1;
			Selecting[1] = 0;
			Selecting[2] = 0;
			State = "ActionSelect";
			for (var i=0;i<array_length(Enemies);i++){
				Enemies[i].DefenseEnding();
			}
			if (CurrentMenuAttack != -1){
				CurrentMenuAttack.Initial();
			}
			if (ds_list_size(obj_Box.FlavorText.AllTextData) > 0){
				obj_Box.CurrentText.editActText([obj_Box.Dialogs[obj_Box.Text]]);
			}else{
				obj_Box.CurrentText = obj_Box.FlavorText.Create(obj_Box.x - 268, obj_Box.y - 118, [obj_Box.Dialogs[obj_Box.Text]], "[noZ][noskip][font:" + string(fn_big_8bit) + "][voice:" + string(snd_ui) + "][xspace:16][yspace:32]");
			}
		}
	break;
}
if (CurrentMenuAttack != -1){
	CurrentMenuAttack.Update();
	if (CurrentMenuAttack.Finished){
		CurrentMenuAttack = -1;
	}
}
switch (Player.KREffect)
{
	case "On":
		Stats.aux = 32;
	break;
	case "Off":
		Stats.aux = 0;
	break;
}
for (var i=0;i<array_length(Enemies);i++){
	Enemies[i].Update();
}
if (Player.HP <= 0){
	State = "GameOver";
	obj_PlayerH.timer = 0;
	obj_PlayerH.image_index = 0;
	for (var i=0;i<array_length(CurrentAttacks);i++){
		if (variable_instance_exists(self, "CurrentAttacks[" + string(i) + "].Zoom")){
			if (is_array(CurrentAttacks[i].Zoom)){
				for (var j=0;j<array_length(CurrentAttacks[i].Zoom);j++){
					if (!is_undefined(CurrentAttacks[i].Zoom[j])){
						layer_sprite_destroy(CurrentAttacks[i].Zoom[j]);
					}
				}
			}else{ if (!is_undefined(CurrentAttacks[i].Zoom)){
				layer_sprite_destroy(CurrentAttacks[i].Zoom);
			}}
		}
	}
	for (var i=0;i<array_length(Enemies);i++){
		Enemies[i].Destroy();
	}
	with (obj_bullet){
		instance_destroy();
	}
	with (obj_Platform){
		instance_destroy();
	}
	instance_destroy(bt_ACT);
	instance_destroy(bt_FIGHT);
	instance_destroy(bt_ITEM);
	instance_destroy(bt_MERCY);
	instance_destroy(inst_Box);
	instance_destroy();
}