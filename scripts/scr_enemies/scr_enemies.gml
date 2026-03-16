enum ENEMY{
	MAD_DUMMY_SPRITED,
	MAD_DUMMY_DRAWN,
	MONSTER_1,
	MONSTER_2
}

enum ACT_COMMAND{
	CHECK,
	ANNOY,
	FLUSTER,
	DISTRACT
}

function calculate_enemy_damage_amount(_enemy){
	return ceil(_enemy.atk/5 - get_player_total_def()) //You can make your separate calculations based on many other data from the enemy
}

function Enemy(_monster, _x_pos, _y_pos) constructor{
	{ //Variable definition
	x = _x_pos
	y = _y_pos
	bubble_x = 0
	bubble_y = 0
	bubble_width = 1
	player_attack_x = 0
	player_attack_y = 0
	damage_ui_x = 0
	damage_ui_y = 0
	bubble_sprite = spr_bubble_normal
	bubble_tail_sprite = spr_bubble_normal_tail
	bubble_tail_mask_sprite = undefined
	
	//These sprites will be set in the x and y position of the monster when you either spare or kill the enemy
	sprite_spared = 0 //This is the sprite for when the monster is spared
	sprite_killed = 0 //This is the sprite that will turn to dust when the monster is killed
	sprite_spared_index = 0 //This is the index to use of said sprite when spared
	sprite_killed_index = 0
	sprite_xscale = 2
	sprite_yscale = 2
	dust_y_pixels_amount_per_frame = 1
	
	next_dialog = undefined
	next_attack = undefined
	next_menu_attack = undefined
	
	turn_starts = undefined
	spare = undefined
	flee = undefined
	item_used = undefined
	dialog_starts = undefined
	attack_starts = undefined
	turn_ends = undefined
	step = undefined
	draw = undefined
	destroy = undefined
	forgiven = undefined
	killed = undefined
	
	give_gold_on_kill = 1 //Usually gold rewarded on kill is more than when spared.
	give_gold_on_spared = 0
	give_exp = 1 //Obviously only on kill.
	
	can_spare = false
	can_flee = false
	show_hp = true
	hp = 1
	max_hp = 1
	atk = 1
	def = 1
	spared = false
	hp_bar_color = c_lime
	hp_bar_width = 100
	hp_bar_width_attacked = 100
	name = _monster
	act_commands = [ACT_COMMAND.CHECK]
	selectionable = true
	}
	
	switch (name){
		case ENEMY.MAD_DUMMY_SPRITED:{
			sprite_spared = spr_mad_dummy_death
			sprite_killed = sprite_spared
			y -= 40
			atk = 15 //Every 5 atk = 1 damage
			bubble_x = 50
			bubble_y = -100
			bubble_width = 100
			player_attack_x = 0
			player_attack_y = -50
			hp_bar_width_attacked = 200
			
			name = get_enemie_name("mad_dummy")
			hp = 100
			max_hp = 100
			head_index = 0
			layer_inst = layer_create(400)
			timer = 0
			can_spare = true
			
			sprites = {
				torso: layer_sprite_create(layer_inst, x + 26, y - 36, spr_mad_dummy_torso),
				base: layer_sprite_create(layer_inst, x, y, spr_mad_dummy_base),
				belly: layer_sprite_create(layer_inst, x, y - 10, spr_mad_dummy_belly),
				head: layer_sprite_create(layer_inst, x + 16, y - 46, spr_mad_dummy_head)
			}
			
			var _auxiliar = [sprites.head, sprites.torso, sprites.belly, sprites.base]
			for (var _i=0; _i<array_length(_auxiliar); _i++){
				layer_sprite_xscale(_auxiliar[_i], 2)
				layer_sprite_yscale(_auxiliar[_i], 2)
			}
			
			calculate_damage = function(_accuracy){
				return 100*_accuracy
			}
			
			hurt = function(_damage){ //FIGHT
				if (typeof(_damage) != "string"){
					audio_play_sound(snd_enemie_hurt, 100, false)
				
					hp -= round(_damage)
					
					return round(_damage)
				}
			}
			
			act = function(_command){ //ACT
				var _dialogues = get_enemie_dialogues("mad_dummy_sprited").act_dialogues
				switch (_command){
					case ACT_COMMAND.CHECK:{
						return _dialogues.check
					}
				}
			}
			
			item_used = function(_item_index){ //ITEM
				//Nothing
			}
			
			dialog_starts = function(){
				next_dialog = get_enemie_dialogues("mad_dummy_sprited").dialogues.dialog
			}
			
			attack_starts = function(){
				next_attack = choose(ENEMY_ATTACK.MAD_DUMMY_1, ENEMY_ATTACK.MAD_DUMMY_2)
			}
			
			turn_ends = function(){
				next_dialog = get_enemie_dialogues("mad_dummy_sprited").dialogues.end_turn
			}
			
			step = function(){
				timer += 10
				y += dcos(timer)/3
				var _angle = 12*dsin(timer)
				
				if (timer >= 360){
					timer = 0
				}
				
				layer_sprite_angle(sprites.head, 1.1*_angle)
				layer_sprite_angle(sprites.torso, _angle)
				layer_sprite_angle(sprites.belly, _angle)
				layer_sprite_angle(sprites.base, -2*_angle)
				
				layer_sprite_y(sprites.head, y - 46)
				layer_sprite_y(sprites.torso, y - 36)
				layer_sprite_y(sprites.belly, y - 10)
				layer_sprite_y(sprites.base, y)
				
				layer_sprite_index(sprites.head, head_index)
			}
			
			destroy = function(){
				var _auxiliar = [sprites.head, sprites.torso, sprites.belly, sprites.base]
				for (var _i=0; _i<array_length(_auxiliar); _i++){
					layer_sprite_destroy(_auxiliar[_i]) //Game Maker automatically deletes them when you change to another room, but still you should do clean up I guess and not rely on Game Maker much.
				}
				if (layer_exists(layer_inst)){
					layer_destroy(layer_inst)
				}
			}
		break}
		case ENEMY.MAD_DUMMY_DRAWN:{
			sprite_spared = spr_mad_dummy_death
			sprite_killed = sprite_spared
			y -= 40
			bubble_x = 50
			bubble_y = -100
			bubble_width = 100
			player_attack_x = 0
			player_attack_y = -50
			bubble_sprite = spr_bubble_normal
			bubble_tail_sprite = spr_bubble_normal_tail
			
			hp_bar_color = c_aqua
			hp = 74
			max_hp = 100
			name = get_enemie_name("mad_dummy")
			head_index = 0
			layer_inst = layer_create(100)
			timer = 0
			can_spare = true
			
			calculate_damage = function(_accuracy){
				return 50*_accuracy
			}
			
			hurt = function(_damage){ //FIGHT
				if (typeof(_damage) != "string"){
					hp -= round(_damage)
					
					return round(_damage)
				}
			}
			
			act = function(_command){ //ACT
				var _dialogues = get_enemie_dialogues("mad_dummy_drawn").act_dialogues
				switch (_command){
					case ACT_COMMAND.CHECK:{
						return _dialogues.check
					}
				}
			}
			
			flee = function(){ //FLEE
				next_dialog = get_enemie_dialogues("mad_dummy_drawn").dialogues.flee
			}
			
			attack_starts = function(){
				next_attack = choose(ENEMY_ATTACK.MAD_DUMMY_1, ENEMY_ATTACK.MAD_DUMMY_2)
			}
			
			step = function(){
				timer += 6
				y += dcos(timer)/3
				
				if (timer >= 360){
					timer = 0
				}
			}
			
			draw = function(){
				var _angle = 7*dsin(timer)
				
				draw_sprite_ext(spr_mad_dummy_torso, head_index, x + 26, y - 36, 2, 2, _angle, c_white, 1)
				draw_sprite_ext(spr_mad_dummy_base, 0, x, y, 2, 2, -2*_angle, c_white, 1)
				draw_sprite_ext(spr_mad_dummy_belly, 0, x, y - 10, 2, 2, _angle, c_white, 1)
				draw_sprite_ext(spr_mad_dummy_head, 0, x + 16, y - 46, 2, 2, 1.1*_angle, c_white, 1)
			}
		break}
		case ENEMY.MONSTER_1:{
			sprite_spared = spr_enemy_monster
			sprite_killed = sprite_spared
			sprite_xscale = 1
			sprite_yscale = 1
			atk = 15
			def = 10
			bubble_x = 100
			bubble_y = -200
			bubble_width = 100
			player_attack_x = 0
			player_attack_y = -100
			damage_ui_y = -100
			dust_y_pixels_amount_per_frame = 4
			bubble_sprite = spr_box_round
			bubble_tail_sprite = spr_box_normal_tiny_tail
			bubble_tail_mask_sprite = spr_box_round_mask
			
			hp = 100
			max_hp = 100
			name = get_enemie_name("monster")
			layer_inst = layer_create(300)
			timer = -1
			array_push(act_commands, ACT_COMMAND.ANNOY, ACT_COMMAND.FLUSTER)
			
			sprite = layer_sprite_create(layer_inst, x, y, spr_enemy_monster)
			
			calculate_damage = function(_accuracy){
				return (100 + 2*(get_player_total_atk() - def))*_accuracy //Custom formula
			}
			
			hurt = function(_damage){ //FIGHT
				if (typeof(_damage) != "string"){
					audio_play_sound(snd_enemie_hurt, 100, false)
					
					hp -= round(_damage)
					timer = 0
					
					return round(_damage)
				}
			}
			
			act = function(_command){ //ACT
				var _dialogues = get_enemie_dialogues("monster").act_dialogues
				switch (_command){
					case ACT_COMMAND.CHECK:{
						var _dialog = _dialogues.check
						_dialog[0] = string_replace(string_replace(_dialog[0], "[ATK]", string(atk)), "[DEF]", string(def))
						
						return _dialog
					}
					case ACT_COMMAND.ANNOY:{
						atk += 5
						def += 5
						
						return _dialogues.annoy
					}
					case ACT_COMMAND.FLUSTER:{
						atk -= 5
						def -= 5
						can_spare = true
						
						return _dialogues.fluster
					}
				}
			}
			
			item_used = function(_item_index){ //ITEM
				next_dialog = get_enemie_dialogues("monster").dialogues.item_used
			}
			
			dialog_starts = function(){
				if (is_undefined(next_dialog)){
					next_dialog = get_enemie_dialogues("monster").dialogues.dialog
				}
			}
			
			attack_starts = function(){
				next_attack = choose(ENEMY_ATTACK.PLATFORM_2, ENEMY_ATTACK.PLATFORM_3)
			}
			
			turn_ends = function(_box_dialog){
				var _dialog
				var _dialogues = get_enemie_dialogues("monster").box_dialogues
				
				switch (irandom(2)){
					case 0:{
						_dialog = _dialogues.random_1
					break}
					case 1:{
						_dialog = _dialogues.random_2
					break}
					case 2:{
						_dialog = _dialogues.random_3
					break}
				}
				
				return _dialog
			}
			
			step = function(){
				if (timer >= 0){
					timer++
					
					switch (timer){
						case 1:{
							layer_sprite_x(sprite, layer_sprite_get_x(sprite) - 20)
						break}
						case 21: case 61:{
							layer_sprite_x(sprite, layer_sprite_get_x(sprite) + 40)
						break}
						case 41: case 81:{
							layer_sprite_x(sprite, layer_sprite_get_x(sprite) - 40)
						break}
						case 101:{
							timer = -1
							layer_sprite_x(sprite, layer_sprite_get_x(sprite) + 20)
						break}
					}
				}
			}
			
			destroy = function(){
				layer_sprite_destroy(sprite) //Game Maker automatically deletes them when you change to another room, but still you should do clean up I guess and not rely on Game Maker much.
				if (layer_exists(layer_inst)){
					layer_destroy(layer_inst)
				}
			}
			
			spare = function(){
				if (can_spare){
					next_dialog = 0 //No dialog
				}
			}
		break}
		case ENEMY.MONSTER_2:{
			sprite_spared = spr_enemy_monster
			sprite_killed = sprite_spared
			sprite_xscale = 1
			sprite_yscale = 1
			atk = 25
			def = 15
			bubble_x = 100
			bubble_y = -200
			bubble_width = 100
			player_attack_x = 0
			player_attack_y = -100
			damage_ui_y = -100
			dust_y_pixels_amount_per_frame = 4
			bubble_sprite = spr_box_normal
			bubble_tail_sprite = spr_box_normal_tail
			bubble_tail_mask_sprite = spr_box_normal_mask
			
			hp = 10
			max_hp = 10
			name = get_enemie_name("angy_monster")
			layer_inst = layer_create(300)
			timer = -1
			dodge = -1
			distracted = false
			array_push(act_commands, ACT_COMMAND.DISTRACT)
			
			sprite = layer_sprite_create(layer_inst, x, y, spr_enemy_monster)
			layer_sprite_blend(sprite, c_red)
			
			calculate_damage = function(_accuracy){
				if (!distracted){
					dodge = 0
				}
				
				return 100*_accuracy/max(def - get_player_total_atk(), 1) //Custom formula
			}
			
			hurt = function(_damage){ //FIGHT
				if (typeof(_damage) != "string" and distracted){
					audio_play_sound(snd_enemie_hurt, 100, false)
					
					hp -= round(_damage)
					timer = 0
					distracted = false
					can_spare = false
					next_dialog = get_enemie_dialogues("angy_monster").dialogues.focused
					
					return round(_damage)
				}else{
					return get_battle_ui_damage_text("miss")
				}
			}
			
			act = function(_command){ //ACT
				var _dialogues = get_enemie_dialogues("angy_monster").act_dialogues
				switch (_command){
					case ACT_COMMAND.CHECK:{
						var _dialog = _dialogues.check
						_dialog[0] = string_replace(string_replace(_dialog[0], "[ATK]", string(atk)), "[DEF]", string(def))
						
						return _dialog
					}
					case ACT_COMMAND.DISTRACT:{
						distracted = true
						can_spare = true
						
						return _dialogues.distract
					}
				}
			}
			
			turn_starts = function(){
				next_menu_attack = choose(MENU_ATTACK.MENU_ATTACK, MENU_ATTACK.BUTTON_ATTACK, MENU_ATTACK.MENU_AND_BUTTON_ATTACK)
			}
			
			item_used = function(_item_index){ //ITEM
				if (!distracted){
					next_dialog = get_enemie_dialogues("angy_monster").dialogues.item_complain
				}
			}
			
			dialog_starts = function(){
				var _dialogues = get_enemie_dialogues("angy_monster").dialogues
				if (is_undefined(next_dialog)){
					if (distracted){
						next_dialog = _dialogues.distracted
					}else{
						next_dialog = _dialogues.anger
					}
				}
			}
			
			attack_starts = function(){
				if (!distracted){
					next_attack = choose(ENEMY_ATTACK.PLATFORM_2, ENEMY_ATTACK.PLATFORM_3)
				}
			}
			
			turn_ends = function(_box_dialog){
				var _dialog
				var _dialogues = get_enemie_dialogues("angy_monster").box_dialogues
				
				if (distracted){
					_dialog = _dialogues.distracted
				}else{
					switch (irandom(1)){
						case 0:{
							_dialog = _dialogues.random_1
						break}
						case 1:{
							_dialog = _dialogues.random_2
						break}
					}
				}
				
				return _dialog
			}
			
			step = function(){
				if (dodge >= 0){
					dodge++
					var _scale = 1 - 0.5*dsin(90*min(dodge/20, 1) + 90*clamp((dodge - 80)/20, 0, 1))
					
					layer_sprite_xscale(sprite, 0.5 + _scale/2)
					layer_sprite_yscale(sprite, 0.5 + _scale/2)
					layer_sprite_blend(sprite, make_color_hsv(0, 255, 255*_scale))
					
					if (dodge >= 100){
						dodge = -1
					}
				}else if (timer >= 0){
					timer++
					
					switch (timer){
						case 1:{
							layer_sprite_x(sprite, layer_sprite_get_x(sprite) - 20)
						break}
						case 21: case 61:{
							layer_sprite_x(sprite, layer_sprite_get_x(sprite) + 40)
						break}
						case 41: case 81:{
							layer_sprite_x(sprite, layer_sprite_get_x(sprite) - 40)
						break}
						case 101:{
							timer = -1
							layer_sprite_x(sprite, layer_sprite_get_x(sprite) + 20)
						break}
					}
				}
			}
			
			destroy = function(){
				layer_sprite_destroy(sprite) //Game Maker automatically deletes them when you change to another room, but still you should do clean up I guess and not rely on Game Maker much.
				if (layer_exists(layer_inst)){
					layer_destroy(layer_inst)
				}
			}
			
			spare = function(){
				if (can_spare){
					next_dialog = 0 //No dialog
				}
			}
		break}
	}
}