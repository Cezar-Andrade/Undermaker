/// @description Platform logic

if (mode == "Blue" and gravity_data.jump <= 0 and (other.Fragile[0] <= 0 or other.Fragile[2] == 0) and image_angle == other.image_angle and other.image_alpha >= 0.5 and (!gravity_data.prev_platform.found or gravity_data.prev_platform.plat == other)){
	gravity_data.platform.x = 0
	gravity_data.platform.y = 0
	if (other.Type[0] == "Trampoline"){
		other.Type[1] = 1
		gravity_data.jump = gravity_data.max_jump
		gravity_data.ignore_first_frame = true
		gravity_data.cannot_stop_jump = true
	}else{
		gravity_data.jump = 0
		if (other.Type[0] == "Sticky"){
			gravity_data.cannot_jump = true
			if (other.Type[1] > 0){
				gravity_data.platform.x -= 2*sin(degtorad(180/10*other.Type[1]))*sin(degtorad(other.image_angle))
				gravity_data.platform.y -= 2*sin(degtorad(180/10*other.Type[1]))*cos(degtorad(other.image_angle))
			}
		}
		var ang = other.image_angle/90
		if (other.Type[0] == "Conveyor"){
			if (ang == 0 or ang == 2){
				gravity_data.push.val = other.hspeed + other.Type[2]*(1 - ang) + 4*((keyboard_check(settings.right[0]) or keyboard_check(settings.right[1])) - (keyboard_check(settings.left[0]) or keyboard_check(settings.left[1])))
			}else{
				gravity_data.push.val = other.vspeed + other.Type[2]*(2 - ang) + 4*((keyboard_check(settings.down[0]) or keyboard_check(settings.down[1])) - (keyboard_check(settings.up[0]) or keyboard_check(settings.up[1])))
			}
		}else{
			if (ang == 0 or ang == 2){
				gravity_data.push.val = other.hspeed + 4*((keyboard_check(settings.right[0]) or keyboard_check(settings.right[1])) - (keyboard_check(settings.left[0]) or keyboard_check(settings.left[1])))
			}else{
				gravity_data.push.val = other.vspeed + 4*((keyboard_check(settings.down[0]) or keyboard_check(settings.down[1])) - (keyboard_check(settings.up[0]) or keyboard_check(settings.up[1])))
			}
		}
		gravity_data.push.count = 0
	}
	gravity_data.platform.vel.x = other.hspeed
	gravity_data.platform.vel.y = other.vspeed
	gravity_data.on_platform = true
	gravity_data.prev_platform.found = true
	gravity_data.prev_platform.plat = other
	if (other.image_angle%180 == 0){
		gravity_data.platform.x += x
		gravity_data.platform.y += other.y - 8*dcos(other.image_angle)
		if (other.Type[0] == "Conveyor"){
			gravity_data.platform.vel.x += other.Type[2]*dcos(other.image_angle)
		}
	}else{ if (other.image_angle%180 == 90){
		gravity_data.platform.x += other.x - 8*dsin(other.image_angle)
		gravity_data.platform.y += y
		if (other.Type[0] == "Conveyor"){
			gravity_data.platform.vel.y -= other.Type[2]*dsin(other.image_angle)
		}
	}}
	if (other.Fragile[0] > 0 and other.Fragile[3] <= 0){
		other.Fragile[3] = 1
	}
}