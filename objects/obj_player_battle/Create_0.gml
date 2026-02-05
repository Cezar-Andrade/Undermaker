/// @description Variable declaration

x = 320
y = 240
movement_speed = 2
mode = -1
invulnerability_frames = 0
trail = false
layer_trail = layer_create(depth + 1, "Soul Trail")
trail_sprites = []

gravity_data = {direction: GRAVITY_SOUL.DOWN, box_bound: true, slam: false, movement: {direction: 0, speed: 0, direction_change: {time: 4, speed: movement_speed}}, jump: {movement_offset: 0, speed: 0, duration: 38, max_height: 80}, orange_mode: false}

set_mode = function(_mode, _args_struct=undefined){
	mode = _mode
	switch (mode){
		case SOUL_MODE.NORMAL:{
			image_blend = c_red
			image_angle = 0
		break}
		case SOUL_MODE.GRAVITY:{
			with (gravity_data){
				direction = GRAVITY_SOUL.DOWN
				orange_mode = false
				jump.speed = 0
				jump.movement_offset = 0
			
				if (is_undefined(_args_struct)){
					other.image_blend = make_color_rgb(0,60,255)
				}else{
					if (variable_struct_exists(_args_struct, "box_bound") and !_args_struct.box_bound){
						box_bound = false
					}
					
					if (variable_struct_exists(_args_struct, "orange") and !_args_struct.orange){
						other.image_blend = make_color_rgb(0,60,255)
					}else{
						other.image_blend = make_color_rgb(255,127,0)
				
						orange_mode = true
						movement_direction = 0
					}
				}
			}
		break}
	}
}

set_mode(SOUL_MODE.NORMAL)