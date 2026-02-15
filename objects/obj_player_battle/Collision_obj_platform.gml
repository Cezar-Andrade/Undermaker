/// @description Platform logic

if (mode == SOUL_MODE.GRAVITY and gravity_data.jump <= 0 and (other.fragile.duration_time <= 0 or other.fragile.state == 0) and image_angle == other.image_angle and other.image_alpha >= 0.5 and (!gravity_data.prev_platform.found or gravity_data.prev_platform.platform == other)){
	gravity_data.platform.x = 0
	gravity_data.platform.y = 0
	if (other.type == PLATFORM_TYPE.TRAMPOLINE){
		other.anim_timer = 1
		gravity_data.jump = gravity_data.max_jump
		gravity_data.ignore_first_frame = true
		gravity_data.cannot_stop_jump = true
	}else{
		gravity_data.jump = 0
		if (other.type == PLATFORM_TYPE.STICKY){
			gravity_data.cannot_jump = true
			if (other.anim_timer > 0){
				gravity_data.platform.x -= 2*dsin(180/10*other.anim_timer)*dsin(other.image_angle)
				gravity_data.platform.y -= 2*dsin(180/10*other.anim_timer)*dcos(other.image_angle)
			}
		}
		var ang = other.image_angle/90
		if (other.type == PLATFORM_TYPE.CONVEYOR){
			if (ang == 0 or ang == 2){
				gravity_data.conveyor_push.val = other.hspeed + other.conveyor_speed*(1 - ang) + 4*get_horizontal_button_force()
			}else{
				gravity_data.conveyor_push.val = other.vspeed + other.conveyor_speed*(2 - ang) + 4*get_vertical_button_force()
			}
		}else{
			if (ang == 0 or ang == 2){
				gravity_data.conveyor_push.val = other.hspeed + 4*get_horizontal_button_force()
			}else{
				gravity_data.conveyor_push.val = other.vspeed + 4*get_vertical_button_force()
			}
		}
		gravity_data.conveyor_push.count = 0
	}
	gravity_data.platform_vel.x = other.hspeed
	gravity_data.platform_vel.y = other.vspeed
	gravity_data.on_platform = true
	gravity_data.prev_platform.found = true
	gravity_data.prev_platform.platform = other
	if (other.image_angle%180 == 0){
		gravity_data.platform.x += x
		gravity_data.platform.y += other.y - 8*dcos(other.image_angle)
		if (other.type == PLATFORM_TYPE.CONVEYOR){
			gravity_data.platform_vel.x += other.conveyor_speed*dcos(other.image_angle)
		}
	}else{ if (other.image_angle%180 == 90){
		gravity_data.platform.x += other.x - 8*dsin(other.image_angle)
		gravity_data.platform.y += y
		if (other.type == PLATFORM_TYPE.CONVEYOR){
			gravity_data.platform_vel.y -= other.conveyor_speed*dsin(other.image_angle)
		}
	}}
	if (other.fragile.duration_time > 0 and other.fragile.timer <= 0){
		other.fragile.timer = 1
	}
}