/// @description Spawn point handling.

if (!is_undefined(spawn_point_reference)){
	with (spawn_point_reference){
		var _angle = image_angle%360;
		if (_angle < 0){
			_angle += 360;
		}
	
		var _x_direction = sign(image_xscale);
		if (_angle <= 45 or _angle > 315){
			other.image_index = 8 - 4*_x_direction;
		}else if (_angle <= 135){
			other.image_index = 4 + 4*_x_direction;
		}else if (_angle <= 225){
			other.image_index = 8 + 4*_x_direction;
		}else{
			other.image_index = 4 - 4*_x_direction;
		}
	
		var _x_center = 10*image_xscale;
		var _y_center = 10*image_yscale;
		switch (image_index%2){
			case 0:
				other.x = x + _x_center*dcos(image_angle) + _y_center*dsin(image_angle);
				other.y = y + _y_center*dcos(image_angle) - _x_center*dsin(image_angle);
			break;
			case 1:
				var _offset = clamp(other.spawn_point_offset, -abs(_y_center) - other.bbox_top + other.y, abs(_y_center) - other.bbox_bottom + other.y);
				other.x = x + _x_center*dcos(image_angle) + _y_center*dsin(image_angle) + _offset*abs(dsin(image_angle));
				other.y = y + _y_center*dcos(image_angle) + _offset*abs(dcos(image_angle)) - _x_center*dsin(image_angle);
			break;
		}
	}
}