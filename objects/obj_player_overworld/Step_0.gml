/// @description Player movement

switch (obj_game.state){
	case GAME_STATE.PLAYER_MENU_CONTROL:
		////STILL TO DO
	break;
	case GAME_STATE.PLAYER_CONTROL:
		timer--;
		if (timer == 0){
			timer = 2;
			if (global.up_button > 0 or global.down_button > 0 or global.left_button > 0 or global.right_button > 0){
				animation_timer++;
			}else{
				animation_timer = 0;
				image_index -= image_index%4;
			}
	
			if (animation_timer == animation_speed){
				animation_timer = 0;
				image_index++;
				if (image_index%4 == 0){
					image_index -= 4;
				}
			}
	
			var _y_upper_collision = false;
	
			//Special case check for the frisk_dance trigger, cannot do it the normal way because of the collision id system.
			if (frisk_dance){
				with (obj_collision){
					if (collision_id == 0 and place_meeting(x, y + other.movement_speed*global.up_button, obj_player_overworld)){
						_y_upper_collision = true;
						break;
					}
				}
			}

			//The priority on up and right is intentional, you will have to edit this part of the code if you want that if both buttons are held, it doesn't move; this priority system is also benefitial for the frisk dance feature and moon walk.
			if (global.up_button > 0 and !_y_upper_collision){
				y -= movement_speed*global.up_button;
				while (image_index >= 12){
					image_index -= 4;
				}
				while (image_index < 8){
					image_index += 4;
				}
			}else if (global.down_button > 0){
				y += movement_speed*global.down_button;
				while (image_index >= 4){
					image_index -= 4;
				}
			}
			if (global.right_button > 0){
				x += movement_speed*global.right_button;
				while (image_index >= 8){
					image_index -= 4;
				}
				if (image_index < 4){
					image_index += 4;
				}
			}else if (global.left_button > 0){
				x -= movement_speed*global.left_button;
				while (image_index < 12){
					image_index += 4;
				}
				if (image_index >= 16){
					image_index -= 4;
				}
			}
	
			var _colliding_instances = [];
			with (obj_collision){
				if (collision_id == 0 and place_meeting(x, y, obj_player_overworld)){
					array_push(_colliding_instances, id);
				}
			}
			var _colliding_instances_count = array_length(_colliding_instances);
	
			if (_colliding_instances_count > 0){
				var _is_colliding = false;
		
				for (var _i=0; _i<_colliding_instances_count; _i++){
					var _collision = _colliding_instances[_i];
					if (place_meeting(xprevious, y, _collision)){
						_is_colliding = true;
						break;
					}
				}
		
				if (_is_colliding){
					_is_colliding = false;
			
					for (var _i=0; _i<_colliding_instances_count; _i++){
						var _collision = _colliding_instances[_i];
						if (place_meeting(x, yprevious, _collision)){
							_is_colliding = true;
							break;
						}
					}
		
					y = yprevious;
					if (_is_colliding){
						x = xprevious;
					}
				}else{
					x = xprevious;
				}
			}
	
			depth = -y;
		}
	break;
}