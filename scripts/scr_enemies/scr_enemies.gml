enum ENEMY{
	MAD_DUMMY_SPRITED,
	MAD_DUMMY_DRAWN
}

enum ACT_COMMAND{
	CHECK
}

function enemy(_monster, _x_pos, _y_pos) constructor{
	x = _x_pos;
	y = _y_pos;
	bubble_x = 0;
	bubble_y = 0;
	bubble_width = 1;
	player_attack_x = 0;
	player_attack_y = 0;
	damage_ui_x = 0;
	damage_ui_y = 0;
	bubble_sprite = spr_bubble_normal;
	bubble_tail_sprite = spr_bubble_normal_tail;
	bubble_tail_mask_sprite = undefined;
	
	//These sprites will be set in the x and y position of the monster when you either spare or kill the enemy
	sprite_spared = 0; //This is the sprite for when the monster is spared
	sprite_killed = 0; //This is the sprite that will turn to dust when the monster is killed
	sprite_spared_index = 0; //This is the index to use of said sprite when spared
	sprite_killed_index = 0;
	sprite_xscale = 2;
	sprite_yscale = 2;
	
	next_dialog = undefined;
	next_attack = undefined;
	
	turn_starts = undefined;
	spare = undefined;
	flee = undefined;
	item_used = undefined;
	dialog_starts = undefined;
	attack_starts = undefined;
	turn_ends = undefined;
	update = undefined;
	draw = undefined;
	destroy = undefined;
	forgiven = undefined;
	killed = undefined;
	
	give_gold_on_kill = 1; //Usually gold rewarded on kill is more than when spared.
	give_gold_on_spared = 0;
	give_exp = 1; //Obviously only on kill.
	
	can_spare = false;
	show_hp = true;
	hp = 1;
	spared = false;
	hp_bar_color = c_lime;
	hp_bar_width = 100;
	hp_bar_width_attacked = 100;
	max_hp = 1;
	name = _monster;
	act_commands = [ACT_COMMAND.CHECK];
	selectionable = true;
	
	switch (name){
		case ENEMY.MAD_DUMMY_SPRITED: {
			sprite_spared = spr_mad_dummy_death;
			sprite_killed = sprite_spared;
			y -= 40;
			bubble_x = 50;
			bubble_y = -100;
			bubble_width = 100;
			player_attack_x = 0;
			player_attack_y = -50;
			hp_bar_width_attacked = 200;
			
			name = "Mad Dummy";
			hp = 100;
			max_hp = 100;
			head_index = 0;
			layer_inst = layer_create(400);
			timer = 0;
			can_spare = true;
			
			sprites = {
				torso: layer_sprite_create(layer_inst, x + 26, y - 36, spr_mad_dummy_torso),
				base: layer_sprite_create(layer_inst, x, y, spr_mad_dummy_base),
				belly: layer_sprite_create(layer_inst, x, y - 10, spr_mad_dummy_belly),
				head: layer_sprite_create(layer_inst, x + 16, y - 46, spr_mad_dummy_head)
			};
			
			var _auxiliar = [sprites.head, sprites.torso, sprites.belly, sprites.base];
			for (var _i=0; _i<array_length(_auxiliar); _i++){
				layer_sprite_xscale(_auxiliar[_i], 2);
				layer_sprite_yscale(_auxiliar[_i], 2);
			}
			
			calculate_damage = function(_accuracy){
				return 100*_accuracy;
			}
			
			turn_starts = function(){
				//Nothing
			}
			
			hurt = function(_damage){ //FIGHT
				if (typeof(_damage) != "string"){
					audio_play_sound(snd_enemie_hurt, 100, false);
				
					hp -= round(_damage);
					
					return round(_damage);
				}
			}
			
			act = function(_command){ //ACT
				switch (_command){
					case ACT_COMMAND.CHECK:
						return ["Mad Dummy - ? ATK inf DEF[w:20]\nThis dummy in particular is made out of layer sprites.","It doesn't use the draw function to be on screen."];
				}
			}
			
			spare = function(){ //SPARE
				//Nothing
			}
			
			flee = function(){ //FLEE
				
			}
			
			item_used = function(_item_index){ //ITEM
				
			}
			
			dialog_starts = function(){
				next_dialog = "I have a dialog.";
			}
			
			attack_starts = function(){
				next_attack = choose(ENEMY_ATTACK.MAD_DUMMY_1, ENEMY_ATTACK.MAD_DUMMY_2);
			}
			
			turn_ends = function(){
				next_dialog = "I have a dialog after the attack too!";
			}
			
			update = function(){
				timer += 10;
				y += dcos(timer)/3;
				var _angle = 12*dsin(timer);
				
				if (timer >= 360){
					timer = 0;
				}
				
				layer_sprite_angle(sprites.head, 1.1*_angle);
				layer_sprite_angle(sprites.torso, _angle);
				layer_sprite_angle(sprites.belly, _angle);
				layer_sprite_angle(sprites.base, -2*_angle);
				
				layer_sprite_y(sprites.head, y - 46);
				layer_sprite_y(sprites.torso, y - 36);
				layer_sprite_y(sprites.belly, y - 10);
				layer_sprite_y(sprites.base, y);
				
				layer_sprite_index(sprites.head, head_index);
			}
			
			draw = function(){
				//Nothing
			}
			
			destroy = function(){
				var _auxiliar = [sprites.head, sprites.torso, sprites.belly, sprites.base];
				for (var _i=0; _i<array_length(_auxiliar); _i++){
					layer_sprite_destroy(_auxiliar[_i]);
				}	
			}
			
			killed = function(){
				//Nothing
			}
			forgiven = killed;
		break;}
		case ENEMY.MAD_DUMMY_DRAWN: {
			sprite_spared = spr_mad_dummy_death;
			sprite_killed = sprite_spared;
			y -= 40;
			bubble_x = 50;
			bubble_y = -100;
			bubble_width = 100;
			player_attack_x = 0;
			player_attack_y = -50;
			bubble_sprite = spr_bubble_normal;
			bubble_tail_sprite = spr_bubble_normal_tail;
			
			hp_bar_color = c_aqua;
			hp = 74;
			max_hp = 100;
			name = "Mad Dummy";
			head_index = 0;
			layer_inst = layer_create(100);
			timer = 0;
			can_spare = true;
			
			calculate_damage = function(_accuracy){
				return 50*_accuracy;
			}
			
			turn_starts = function(){
				//Nothing
			}
			
			hurt = function(_damage){ //FIGHT
				if (typeof(_damage) != "string"){
					hp -= round(_damage);
					
					return round(_damage);
				}
			}
			
			act = function(_command){ //ACT
				switch (_command){
					case ACT_COMMAND.CHECK:
						return ["Mad Dummy - ? ATK 999 DEF[w:20]\nThis dummy in particular is made using draw function.","It contains a bit of a shield against attacks."];
				}
			}
			
			spare = function(){ //SPARE
				//Nothing
			}
			
			flee = function(){ //FLEE
				next_dialog = "Don't you dare try to flee on us again.";
			}
			
			item_used = function(_item_index){ //ITEM
				
			}
			
			dialog_starts = function(){
				
			}
			
			attack_starts = function(){
				next_attack = choose(ENEMY_ATTACK.MAD_DUMMY_1, ENEMY_ATTACK.MAD_DUMMY_2);
			}
			
			turn_ends = function(){
				
			}
			
			update = function(){
				timer += 6;
				y += dcos(timer)/3;
				
				if (timer >= 360){
					timer = 0;
				}
			}
			
			draw = function(){
				var _angle = 7*dsin(timer);
				
				draw_sprite_ext(spr_mad_dummy_torso, head_index, x + 26, y - 36, 2, 2, _angle, c_white, 1);
				draw_sprite_ext(spr_mad_dummy_base, 0, x, y, 2, 2, -2*_angle, c_white, 1);
				draw_sprite_ext(spr_mad_dummy_belly, 0, x, y - 10, 2, 2, _angle, c_white, 1);
				draw_sprite_ext(spr_mad_dummy_head, 0, x + 16, y - 46, 2, 2, 1.1*_angle, c_white, 1);
			}
			
			killed = function(){
				//Nothing
			}
			forgiven = killed;
		break;}
	}
}