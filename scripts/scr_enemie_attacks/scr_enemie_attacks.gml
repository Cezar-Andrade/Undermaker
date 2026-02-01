enum ENEMY_ATTACK{
	SPARE,
	MAD_DUMMY_1,
	MAD_DUMMY_2
}

function enemy_attack(_attack_name, _position) constructor{
	timer = 0 //Every attack contains a timer for you to do stuff, if you don't need it ignore it, if you plan to design your attacks without a timer, might as well remove it, I do not recommend it tho.
	attack_done = false //A variable to read when the attack is flagged as finished and therefor must end the enemy attack state.
	
	switch (_attack_name){
		case ENEMY_ATTACK.MAD_DUMMY_1: {
			battle_box_resize(130, 130)
			timer -= 15*_position
			bullets = []
			
			update = function(){
				timer++
				
				if (timer%30 == 10 and timer <= 265){
					var _bullet = spawn_bullet(spr_circle_bullet, 0, 0, 300)
					_bullet.direction = irandom(359)
					_bullet.timer = 0
					_bullet.can_damage = false
					_bullet.image_blend = c_dkgrey
					_bullet.color_value = 64
					
					array_push(bullets, _bullet)
				}
				
				var _length = array_length(bullets)
				for (var _i=0; _i<_length; _i++){
					var _bullet = bullets[_i]
					
					_bullet.timer++
					
					if (_bullet.timer == 60){
						_bullet.depth = 0
					}else if (_bullet.timer > 160){
						_bullet.image_alpha -= 0.05
					}
					
					var _movement = 5*pi*dcos(1.5*min(_bullet.timer, 120))/6
					
					if (!_bullet.can_damage and _movement <= 0){
						_bullet.can_damage = true
					}
					
					if (_movement < 1 and _bullet.color_value < 255){
						_bullet.color_value = min(_bullet.color_value + 5, 255)
						var _number = _bullet.color_value
						
						_bullet.image_blend = make_colour_rgb(_number, _number, _number)
					}
					
					_bullet.x += _movement*dcos(_bullet.direction)
					_bullet.y -= _movement*dsin(_bullet.direction)
					
					if (_bullet.image_alpha <= 0){
						instance_destroy(_bullet)
						array_delete(bullets, _i, 1)
						_i--
						_length--
					}
				}
				
				if (timer > 300){
					attack_done = true
				}
			}
			
			draw = function(){
			}
			
			cleanup = function(){
				bullets = undefined //For garbage collector the array goes
			}
		break}
		case ENEMY_ATTACK.MAD_DUMMY_2: {
			battle_box_resize(130, 130)
			bullets = []
			timer -= 15*_position
			direction = 0
			
			update = function(){
				timer++
				
				if (timer%30 == 10 and timer <= 265){
					var _bullet = spawn_bullet(spr_circle_bullet, 0, -55 + irandom(110), 300)
					_bullet.direction = direction
					_bullet.timer = 0
					_bullet.can_damage = false
					_bullet.image_blend = c_dkgrey
					_bullet.color_value = 64
					direction = (direction + 180)%360
					
					array_push(bullets, _bullet)
				}
				
				var _length = array_length(bullets)
				for (var _i=0; _i<_length; _i++){
					var _bullet = bullets[_i]
					
					_bullet.timer++
					
					if (_bullet.timer == 60){
						_bullet.depth = 0
					}else if (_bullet.timer > 160){
						_bullet.image_alpha -= 0.05
					}
					
					var _movement = 5*pi*dcos(1.5*min(_bullet.timer, 120))/6
					
					if (!_bullet.can_damage and _movement <= 0){
						_bullet.can_damage = true
					}
					
					if (_movement < 1 and _bullet.color_value < 255){
						_bullet.color_value = min(_bullet.color_value + 5, 255)
						var _number = _bullet.color_value
						
						_bullet.image_blend = make_colour_rgb(_number, _number, _number)
					}
					
					_bullet.x += _movement*dcos(_bullet.direction)
					_bullet.y -= _movement*dsin(_bullet.direction)
					
					if (_bullet.image_alpha <= 0){
						instance_destroy(_bullet)
						array_delete(bullets, _i, 1)
						_i--
						_length--
					}
				}
				
				if (timer > 300){
					attack_done = true
				}
			}
			
			draw = function(){
			}
			
			cleanup = function(){
				bullets = undefined //For garbage collector the array goes
			}
		break}
		case ENEMY_ATTACK.SPARE: { //Yeah this is just a Spare Attack
			update = function(){
				timer++
				
				if (timer > 60){
					attack_done = true
				}
			}
			
			draw = function(){
				//Nothing
			}
		break}
	}
}