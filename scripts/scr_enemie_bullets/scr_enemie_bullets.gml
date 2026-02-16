enum BULLET_TYPE{
	WHITE,
	ORANGE,
	CYAN,
	GREEN
}

function spawn_platform(_x, _y, _direction=0, _length=60, _depth=0, _type=PLATFORM_TYPE.NORMAL, _fragile=0, _respawn_time=0, _respawn=true){
	var _platform = instance_create_depth(_x + obj_box.x, _y + obj_box.y - obj_box.height/2 - 5, _depth, obj_platform)
	with (_platform){
		type = _type
		image_angle = _direction
		length = _length
		
		fragile.respawn = _respawn
		fragile.duration_time = _fragile
		fragile.respawn_time = _respawn_time
	}
}

function spawn_bullet(_sprite, _x, _y, _direction, _depth=0, _damage=3, _type=BULLET_TYPE.WHITE){
	var _bullet = instance_create_depth(_x + obj_box.x, _y + obj_box.y - obj_box.height/2 - 5, _depth, obj_bullet)
	with (_bullet){
		sprite_index = _sprite
		damage = _damage
		direction = _direction
		
		timer = 0
		can_damage = false
		color_value = 64
		type = _type
		
		switch (type){
			case BULLET_TYPE.WHITE:{
				image_blend = c_dkgrey
			break}
			case BULLET_TYPE.CYAN:{
				image_blend = make_colour_rgb(64*33/255, 64*195/255, 64)
			break}
			case BULLET_TYPE.ORANGE:{
				image_blend = make_colour_rgb(64, 64*150/255, 0)
			break}
			case BULLET_TYPE.GREEN:{
				image_blend = make_colour_rgb(64*18/255, 64*64/255, 0)
			break}
		}
		
		update = function(){
			timer++
		
			if (timer == 60){
				depth = 0
			}else if (timer > 160){
				image_alpha -= 0.05
			}
					
			var _movement = 5*pi*dcos(1.5*min(timer, 120))/6
					
			if (!can_damage and _movement <= 0){
				can_damage = true
			}
					
			if (_movement < 1 and color_value < 255){
				color_value = min(color_value + 5, 255)
				var _number = color_value
				
				switch (type){
					case BULLET_TYPE.WHITE:{
						image_blend = make_colour_rgb(_number, _number, _number)
					break}
					case BULLET_TYPE.CYAN:{
						image_blend = make_colour_rgb(_number*33/255, _number*195/255, _number)
					break}
					case BULLET_TYPE.ORANGE:{
						image_blend = make_colour_rgb(_number, _number*150/255, 0)
					break}
					case BULLET_TYPE.GREEN:{
						image_blend = make_colour_rgb(_number*18/255, _number*64/255, 0)
					break}
				}
			}
					
			x += _movement*dcos(direction)
			y -= _movement*dsin(direction)
					
			if (image_alpha <= 0){
				instance_destroy()
			}
		}
	}
	
	array_push(obj_game.battle_bullets, _bullet)
	
	return _bullet
}