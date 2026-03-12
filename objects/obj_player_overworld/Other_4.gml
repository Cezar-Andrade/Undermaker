/// @description Spawn point handling.

//When you change to other rooms, move the player to the spawn point reference, as long as it's defined, cutscenes may change room without this so the player remains on the spot or can be manipulated differently.
if (!is_undefined(spawn_point_reference)){
	with (spawn_point_reference){
		//Get angle of the spawn_point reference
		var _angle = image_angle
		if (_angle < 0){
			_angle = 359 - (abs(_angle) - 1)%360
		}else if (_angle >= 360){
			_angle %= 360
		}
		
		//Set the player's direction depending on the rotation and it's xscale.
		var _x_direction = sign(image_xscale)
		if (_angle <= 45 or _angle > 315){
			other.image_index = 8 - 4*_x_direction
		}else if (_angle <= 135){
			other.image_index = 4 + 4*_x_direction
		}else if (_angle <= 225){
			other.image_index = 8 + 4*_x_direction
		}else{
			other.image_index = 4 - 4*_x_direction
		}
		
		//From the center of the spawn_point reference position the player accordingly
		var _x_center = 10*image_xscale
		var _y_center = 10*image_yscale
		//There's two types of spawn_points, defined by the image_index of the sprite spawn_point.
		switch (image_index%2){
			case 0: //If it's the first type of spawn_point, it always spawns in the center of it, so nothing more has to be done
				other.x = x + _x_center*dcos(image_angle) + _y_center*dsin(image_angle)
				other.y = y + _y_center*dcos(image_angle) - _x_center*dsin(image_angle)
			break
			//Otherwise it can be one that spawns along a line, so we calculate the relative position based on data we get from the object that did the transition of the room.
			//If unespecified, it spawns in the center of it.
			case 1:
				//Get some data from the player
				var _sprite_index = other.sprite_index
				var _image_yscale = other.image_yscale
				var _image_xscale = other.image_xscale
				var _y_offset = sprite_get_yoffset(_sprite_index)
				var _x_offset = sprite_get_xoffset(_sprite_index)
				
				//Calculate offsets based on the size of the collision
				var _top_offset = (_y_offset - sprite_get_bbox_top(_sprite_index))*_image_yscale
				var _bottom_offset = (sprite_get_bbox_bottom(_sprite_index) + 1 - _y_offset)*_image_yscale
				var _left_offset = (_x_offset - sprite_get_bbox_left(_sprite_index))*_image_xscale
				var _right_offset = (sprite_get_bbox_right(_sprite_index) + 1 - _x_offset)*_image_xscale
				
				//Get the proper offsets from each side
				var _vertical_min = ((dcos(image_angle) > 0) ? _bottom_offset : _top_offset)*abs(dcos(image_angle))
				var _horizontal_min = ((dsin(image_angle) > 0) ? _right_offset : _left_offset)*abs(dsin(image_angle))
				var _vertical_max = ((dcos(image_angle) > 0) ? _top_offset : _bottom_offset)*abs(dcos(image_angle))
				var _horizontal_max = ((dsin(image_angle) > 0) ? _left_offset : _right_offset)*abs(dsin(image_angle))
				
				//Calculate the general offset and positionate the player accordingly
				var _offset = clamp(other.spawn_point_offset, -abs(_y_center) + _vertical_min + _horizontal_min, abs(_y_center) - _vertical_max - _horizontal_max)
				other.x = x + _x_center*dcos(image_angle) + _y_center*dsin(image_angle) - _offset*abs(dsin(image_angle))
				other.y = y + _y_center*dcos(image_angle) - _x_center*dsin(image_angle) - _offset*abs(dcos(image_angle))
			break
		}
	}
	
	//Reset the variables for the spawn_point for future spawn point behaviors
	spawn_point_reference = undefined
	spawn_point_offset = 0
}