/// @description Bullet handling

if (other.CanDamage and other.AllowToDamage and image_alpha == 1 and Player.Invulnerable <= 0){
	if (((Cyan.Dimension < 0.67 and !other.Fondo) or (Cyan.Dimension > 0.33 and other.Fondo)) and ((other.Type == "Blue" and (xprevious != x or yprevious != y)) or (other.Type == "Orange" and xprevious == x and yprevious == y) or (other.Type != "Blue" and other.Type != "Orange"))){
		Player.HP = max(min(Player.HP - other.Damage, Player.maxHP), (State != "Defending"));
		if (variable_instance_exists(other, "Head")){
			if (other.Type == "Green"){
				other.Borrar = true;
			}
			if (is_struct(other.Head)){
				other.Head.Top.AllowToDamage = false;
				other.Head.Bottom.AllowToDamage = false;
			}else{
				other.Head.AllowToDamage = false;
			}
			Player.KR = min(max(Player.KR + other.Karma, 0), Player.HP - 1, 40);
			other.Karma = min(other.Karma, 1);
		}else{ if (variable_instance_exists(other, "Body")){
			if (other.Type == "Green"){
				other.Body.Borrar = true;
			}
			other.Body.AllowToDamage = false;
			if (is_struct(other.Body.Head)){
				other.Body.Head.Top.AllowToDamage = false;
				other.Body.Head.Bottom.AllowToDamage = false;
			}else{
				other.Body.Head.AllowToDamage = false;
			}
			Player.KR = min(max(Player.KR + other.Body.Karma, 0), Player.HP - 1, 40);
			other.Body.Karma = min(other.Body.Karma, 1);
		}else{
			Player.KR = min(Player.KR + other.Karma, Player.HP - 1, 40);
			other.Karma = min(other.Karma, 1);
		}}
		if (!Audio and other.Damage >= 0){
			audio_play_sound(snd_hurt, 0, false);
			Audio = true;
			IgnoreDamage++;
			GotHit = true;
		}
		if (!Heal and other.Damage < 0){
			audio_play_sound(snd_heal, 0, false);
			Heal = true;
		}
		var totalINV = Player.armor.INV + Player.weapon.INV;
		Player.Invulnerable = other.Invulnerability + ((IgnoreDamage%5 == 0 and totalINV == 6) or (IgnoreDamage%4 == 0 and totalINV == 9) or (IgnoreDamage%3 == 0 and totalINV == 15));
	}
}