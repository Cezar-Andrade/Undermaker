enum ENEMY{
	MAD_DUMMY_SPRITED,
	MAD_DUMMY_DRAWN
}

function enemy(_monster, _x_pos, _y_pos) constructor{
	x = _x_pos;
	y = _y_pos;
	
	next_dialog = ["[novoice][next]"];
	next_attack = undefined;
	
	can_spare = false;
	hp = 1;
	max_hp = 1;
	name = _monster;
	act_commands = ["Check"];
	selectionable = true;
	
	switch (name){
		case ENEMY.MAD_DUMMY_SPRITED: {
			x_bub = 200;
			y_bub = 100;
			x_atk = 0;
			y_atk = 150;
			bubble_sprite = spr_bubble_normal;
			bubble_tail_sprite = spr_bubble_normal_tail;
			
			name = "Mad Dummy";
			head_index = 0;
			layer_inst = layer_create(100);
			timer = 0;
			can_spare = true;
			
			sprites = {
				head: layer_sprite_create(layer_inst, x + 10, y + 40, spr_mad_dummy_head),
				torso: layer_sprite_create(layer_inst, x + 20, y + 30, spr_mad_dummy_torso),
				belly: layer_sprite_create(layer_inst, x, y, spr_mad_dummy_belly),
				base: layer_sprite_create(layer_inst, x, y, spr_mad_dummy_base)
			};
			
			var _auxiliar = [sprites.head, sprite.torso, sprites.belly, sprites.base];
			for (var _i=0; _i<array_length(_auxiliar); _i++){
				layer_sprite_xscale(_auxiliar[_i], 2);
				layer_sprite_yscale(_auxiliar[_i], 2);
			}
			
			calculate_damage = function(_accuracy){
				return 100*_accuracy;
			}
			
			hurt = function(_damage){ //FIGHT
				return "MISS";
			}
			
			act = function(){ //ACT
				
			}
			
			spare = function(){ //SPARE
				//Nothing
			}
			
			flee = function(){ //FLEE
				
			}
			
			item_used = function(_item_index){ //ITEM
				
			}
			
			dialog_start = function(){
				
			}
			
			attack_starts = function(){
				
			}
			
			player_turn_ends = function(){
				
			}
			
			update = function(){
				timer += 3;
				var _angle = 10*dsin(timer);
				
				if (timer >= 120){
					timer = 0;
				}
				
				layer_sprite_angle(sprites.head, _angle);
				layer_sprite_angle(sprites.head, _angle);
				layer_sprite_angle(sprites.head, _angle);
				layer_sprite_angle(sprites.head, _angle);
				
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
		break;}
		case ENEMY.MAD_DUMMY_DRAWN: {
			x_bub = 200;
			y_bub = 100;
			x_atk = 0;
			y_atk = 150;
			bubble_sprite = spr_bubble_normal;
			bubble_tail_sprite = spr_bubble_normal_tail;
			
			name = "Mad Dummy";
			head_index = 0;
			layer_inst = layer_create(100);
			timer = 0;
			can_spare = true;
			
			calculate_damage = function(_accuracy){
				return 100*_accuracy;
			}
			
			hurt = function(_damage){ //FIGHT
				return "MISS";
			}
			
			act = function(){ //ACT
				
			}
			
			spare = function(){ //SPARE
				//Nothing
			}
			
			flee = function(){ //FLEE
				
			}
			
			item_used = function(_item_index){ //ITEM
				
			}
			
			dialog_start = function(){
				
			}
			
			attack_starts = function(){
				
			}
			
			player_turn_ends = function(){
				
			}
			
			update = function(){
				timer += 3;
				
				if (timer >= 120){
					timer = 0;
				}
			}
			
			draw = function(){
				var _angle = 10*dsin(timer);
				
				draw_sprite_ext(spr_mad_dummy_head, head_index, x + 10, y + 40, 2, 2, _angle, c_white, 1);
				draw_sprite_ext(spr_mad_dummy_torso, head_index, x + 20, y + 30, 2, 2, _angle, c_white, 1);
				draw_sprite_ext(spr_mad_dummy_belly, head_index, x, y, 2, 2, _angle, c_white, 1);
				draw_sprite_ext(spr_mad_dummy_base, head_index, x, y, 2, 2, _angle, c_white, 1);
			}
			
			destroy = function(){
				//Nothing
			}
		break;}
	}
}