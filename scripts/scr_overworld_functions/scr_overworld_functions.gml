function handle_interaction_action(_direction, _movement_speed){
	var _x_offset = _movement_speed*dsin(_direction); //Calculate the offset of all obj_interaction instances.
	var _y_offset = _movement_speed*dcos(_direction);
	
	if (can_interact and !is_undefined(interaction) and place_meeting(x - _x_offset, y - _y_offset, obj_player_overworld)){
		var _is_interacting = true;
		
		//Check for the key to interact being pressed.
		switch (interaction_key){
			case "confirm":
				_is_interacting = global.confirm_button;
			break;
			case "cancel":
				_is_interacting = global.cancel_button;
			break;
			case "menu":
				_is_interacting = global.menu_button;
			break;
			default: //Checks the key you have.
				_is_interacting = keyboard_check_pressed(ord(interaction_key));
			break;
		}
		
		if (_is_interacting){
			obj_player_overworld.player_anim_stop(); //This resets the player animation automatically, but since it's ran before the interaction function, users can change that.
			interaction(_direction); //Trigger the interaction if the played pressed the right key to interact with.
		}
		
		return _is_interacting;
	}
	
	return false;
}

function handle_entity_collision(_id){
	var _direction = 0;
	
	var _collision_center_x = x + ((sprite_get_bbox_right(sprite_index) + 1 + sprite_get_bbox_left(sprite_index))/2 - sprite_get_xoffset(sprite_index))*image_xscale;
	var _collision_center_y = y + ((sprite_get_bbox_bottom(sprite_index) + 1 + sprite_get_bbox_top(sprite_index))/2 - sprite_get_yoffset(sprite_index))*image_yscale;
	var _collision_width = (sprite_get_bbox_right(sprite_index) + 1 - sprite_get_bbox_left(sprite_index))*abs(image_xscale);
	var _collision_height = (sprite_get_bbox_bottom(sprite_index) + 1 - sprite_get_bbox_top(sprite_index))*abs(image_yscale);
	
	var _id_width = (sprite_get_bbox_right(_id.sprite_index) + 1 - sprite_get_bbox_left(_id.sprite_index))*abs(_id.image_xscale);
	var _id_height = (sprite_get_bbox_bottom(_id.sprite_index) + 1 - sprite_get_bbox_top(_id.sprite_index))*abs(_id.image_yscale);
	var _id_center_x = _id.x + _id_width*sign(_id.image_xscale)/2 + (sprite_get_bbox_left(_id.sprite_index) - sprite_get_xoffset(_id.sprite_index))*_id.image_xscale;
	var _id_center_y = _id.y + _id_height*sign(_id.image_yscale)/2 + (sprite_get_bbox_top(_id.sprite_index) - sprite_get_yoffset(_id.sprite_index))*_id.image_yscale;
	
	if (round_collision_behavior){
		_direction = point_direction(_collision_center_x, _collision_center_y, _id_center_x, _id_center_y);
		_id.x += dcos(_direction);
		_id.y -= dsin(_direction);
	}else{
		var _left_collision = _collision_center_x - _collision_width/2;
		var _top_collision = _collision_center_y - _collision_height/2;
		
		if (_id.round_collision_behavior){
			if (_id_center_x >= _left_collision and _id_center_x <= _left_collision + _collision_width){
				if (_id_center_y <= _collision_center_y){ //Up pushing
					_direction = 90;
					_id.y--;
				}else{ //Down pushing
					_direction = 270;
					_id.y++;
				}
			}else if(_id_center_y >= _top_collision and _id_center_y <= _top_collision + _collision_height){
				if (_id_center_x <= _collision_center_x){ //Left pushing
					_direction = 180;
					_id.x--;
				}else{ //Right pushing
					//_direction = 0; //It is already 0.
					_id.x++;
				}
			}else{
				_direction = point_direction(_collision_center_x, _collision_center_y, _id_center_x, _id_center_y);
				_id.x += dcos(_direction);
				_id.y -= dsin(_direction);
			}
		}else{
			//Checking the closest direction to push out.
			//In theory, when 2 rectangles collide, the distance will yield always negative values, just in case goes positive the absolute is used.
			var _left_distance = abs(_id_center_x - _id_width/2 - _collision_center_x - _collision_width/2);
			var _right_distance = abs(_collision_center_x - _collision_width/2 - _id_center_x - _id_width/2);
			var _up_distance = abs(_id_center_y - _id_height/2 - _collision_center_y - _collision_height/2);
			var _down_distance = abs(_collision_center_y - _collision_height/2 - _id_center_y - _id_height/2);
			var _min_distance = min(_left_distance, _right_distance, _down_distance, _up_distance); //This one stores the closest distance to 0 so it compares with the distances.
			
			if (_left_distance == _min_distance){ //Right pushing
				//_direction = 0; //It is already 0.
				_id.x++;
			}else if (_right_distance == _min_distance){ //Left pushing
				_direction = 180;
				_id.x--;
			}else if (_down_distance == _min_distance){ //Down pushing
				_direction = 90;
				_id.y--;
			}else{ //Up pushing
				_direction = 270;
				_id.y++;
			}
		}
	}
	
	return _direction;
}

function handle_collision_object_and_interaction_collision(_id){
	var _angle = image_angle;
	
	if (_angle < 0){
		_angle = 359 - (abs(_angle) - 1)%360;
	}
	
	var _id_center_x = _id.xprevious + ((sprite_get_bbox_right(_id.sprite_index) + 1 + sprite_get_bbox_left(_id.sprite_index))/2 - sprite_get_xoffset(_id.sprite_index))*_id.image_xscale;
	var _id_center_y = _id.yprevious + ((sprite_get_bbox_bottom(_id.sprite_index) + 1 + sprite_get_bbox_top(_id.sprite_index))/2 - sprite_get_yoffset(_id.sprite_index))*_id.image_yscale;
	
	var _center_x = x + 10*image_xscale*dcos(_angle) + 10*image_yscale*dsin(_angle);
	var _center_y = y + 10*image_yscale*dcos(_angle) - 10*image_xscale*dsin(_angle);
	var _direction = 0;
	
	if (_angle%90 == 0){
		var _id_width = (sprite_get_bbox_right(_id.sprite_index) + 1 - sprite_get_bbox_left(_id.sprite_index))*abs(_id.image_xscale);
		var _id_height = (sprite_get_bbox_bottom(_id.sprite_index) + 1 - sprite_get_bbox_top(_id.sprite_index))*abs(_id.image_yscale);
		var _collision_width = abs(20*image_xscale*dcos(_angle) + 20*image_yscale*dsin(_angle));
		var _collision_height = abs(20*image_yscale*dcos(_angle) + 20*image_xscale*dsin(_angle));
		
		//Checking the closest direction to push out.
		//In theory, when 2 rectangles collide, the distance will yield always negative values, just in case goes positive the absolute is used.
		var _left_distance = abs(_id_center_x - _id_width/2 - _center_x - _collision_width/2);
		var _right_distance = abs(_center_x - _collision_width/2 - _id_center_x - _id_width/2);
		var _up_distance = abs(_id_center_y - _id_height/2 - _center_y - _collision_height/2);
		var _down_distance = abs(_center_y - _collision_height/2 - _id_center_y - _id_height/2);
		var _min_distance = min(_left_distance, _right_distance, _down_distance, _up_distance); //This one stores the closest distance to 0 so it compares with the distances.
		
		if (_left_distance == _min_distance){ //Right pushing
			//_direction = 0; //It is already 0.
			_id.x++;
		}else if (_right_distance == _min_distance){ //Left pushing
			_direction = 180;
			_id.x--;
		}else if (_down_distance == _min_distance){ //Down pushing
			_direction = 90;
			_id.y--;
		}else{ //Up pushing
			_direction = 270;
			_id.y++;
		}
	}else{
		_angle = _angle%180;
		var _cos = dcos(_angle);
		var _sin = dsin(_angle);
		var _point_x = _center_x;
		var _point_y = _center_y;
		var _point_orientation = 0;
		var _point_x2 = _center_x;
		var _point_y2 = _center_y;
		var _point_orientation2 = 0;
		var _points_collided = 0;
		var _image_xscale = abs(image_xscale);
		var _image_yscale = abs(image_yscale);
		
		if ((_id_center_y >= _center_y and ((_angle < 90 and _id_center_x < _center_x + 10*(_image_yscale*_sin - _image_xscale*_cos)) or (_angle > 90 and _id_center_x < _center_x - 10*(_image_xscale*_cos + _image_yscale*_sin)))) or (_id_center_y < _center_y and ((_angle < 90 and _id_center_x < _center_x + 10*(_image_xscale*_cos - _image_yscale*_sin)) or (_angle > 90 and _id_center_x < _center_x + 10*(_image_xscale*_cos + _image_yscale*_sin))))){
			_point_orientation = 180;
			
			if (_angle < 90){
				_point_x -= 10*(_image_xscale*_cos + _image_yscale*_sin);
				_point_y += 10*(_image_xscale*_sin - _image_yscale*_cos);
			}else{
				_point_x += 10*(_image_xscale*_cos - _image_yscale*_sin);
				_point_y -= 10*(_image_yscale*_cos + _image_xscale*_sin);
			}
		}else{
			//_point_orientation = 0; //It is already 0 XD.
			
			if (_angle < 90){
				_point_x += 10*(_image_xscale*_cos + _image_yscale*_sin);
				_point_y += 10*(_image_yscale*_cos - _image_xscale*_sin);
			}else{
				_point_x += 10*(_image_yscale*_sin - _image_xscale*_cos);
				_point_y += 10*(_image_yscale*_cos + _image_xscale*_sin);
			}
		}
		
		if ((_id_center_x >= _center_x and ((_angle < 90 and _id_center_y < _center_y + 10*(_image_yscale*_cos - _image_xscale*_sin)) or (_angle > 90 and _id_center_y < _center_y + 10*(_image_yscale*_cos + _image_xscale*_sin)))) or (_id_center_x < _center_x and ((_angle < 90 and _id_center_y < _center_y + 10*(_image_xscale*_sin - _image_yscale*_cos)) or (_angle > 90 and _id_center_y < _center_y - 10*(_image_yscale*_cos + _image_xscale*_sin))))){
			_point_orientation2 = 90;
			
			if (_angle < 90){
				_point_x2 += 10*(_image_xscale*_cos - _image_yscale*_sin);
				_point_y2 -= 10*(_image_yscale*_cos + _image_xscale*_sin);
			}else{
				_point_x2 += 10*(_image_xscale*_cos + _image_yscale*_sin);
				_point_y2 += 10*(_image_yscale*_cos - _image_xscale*_sin);
			}
		}else{
			_point_orientation2 = 270;
			
			if (_angle < 90){
				_point_x2 += 10*(_image_yscale*_sin - _image_xscale*_cos);
				_point_y2 += 10*(_image_yscale*_cos + _image_xscale*_sin);
			}else{
				_point_x2 -= 10*(_image_xscale*_cos + _image_yscale*_sin);
				_point_y2 += 10*(_image_xscale*_sin - _image_yscale*_cos);
			}
		}
		
		if (!_id.round_collision_behavior){
			if (collision_point(_point_x, _point_y, _id, true, true)){
				var _offset_x = _center_x - (xprevious + 10*image_xscale*dcos(previous_angle_of_this_instance) + 10*image_yscale*dsin(previous_angle_of_this_instance));
				var _distance = abs(_id.xprevious - _id.x) + abs(xprevious - x + _offset_x) + abs(_offset_x) + 1;
				_points_collided++;
				
				if (_point_orientation == 180 and !collision_point(_point_x + _distance, _point_y, _id, true, true)){ //Left pushing
					_direction = 180;
				}else if (_point_orientation == 0 and !collision_point(_point_x - _distance, _point_y, _id, true, true)){ //Right pushing
					//_direction = 0; //It is already 0.
					//Although in here nothing is done, it's essentially the same as if I placed the condition for the last case.
				}else{ //Invalidate the point pushing.
					_points_collided++;
				}
			}
			
			if (_points_collided <= 1 and collision_point(_point_x2, _point_y2, _id, true, true)){
				var _offset_y = _center_y - (yprevious + 10*image_yscale*dcos(previous_angle_of_this_instance) - 10*image_xscale*dsin(previous_angle_of_this_instance));
				var _distance = abs(_id.yprevious - _id.y) + abs(yprevious - y + _offset_y) + abs(_offset_y) + 1;
				_points_collided++;
				
				if (_point_orientation2 == 90 and !collision_point(_point_x2, _point_y2 + _distance, _id, true, true)){ //Up pushing
					_direction = 90;
				}else if (_point_orientation2 == 270 and !collision_point(_point_x2, _point_y2 - _distance, _id, true, true)){ //Down pushing
					_direction = 270;
				}else{ //Invalidate the point pushing.
					_points_collided++;
				}
			}
		}
		
		if (_id.round_collision_behavior or _points_collided != 1){
			if (_point_orientation == 0 and _point_orientation2 == 270){
				_direction = 270;
			}else{
				_direction = min(_point_orientation, _point_orientation2);
			}
			
			_direction += _angle%90;
		}
		
		_id.x += dcos(_direction);
		_id.y -= dsin(_direction);
	}
	
	return _direction;
}

function general_collision_handler(_id, _colliding_instances, _instance_directions, _collision_amount, _handle_collision_function){
	var _id_index = -1;
	
	for (var _i=0; _i < _collision_amount; _i++){
		if (_colliding_instances[_i] == id){
			_id_index = _i;
			
			break;
		}
	}
	
	if (place_meeting(x, y, _id)){
		if (_id_index >= 0){
			var _direction = _instance_directions[_id_index];
			
			_id.x += dcos(_direction);
			_id.y -= dsin(_direction);
			
			return _collision_amount;
		}
		
		var _direction = _handle_collision_function(_id);
		
		if (place_meeting(x, y, _id)){
			array_push(_colliding_instances, id);
			array_push(_instance_directions, _direction);
			_collision_amount++;
		}
	}else if (_id_index >= 0){
		array_delete(_colliding_instances, _id_index, 1);
		array_delete(_instance_directions, _id_index, 1);
		_collision_amount--;
	}
	
	return _collision_amount;
}

function general_entity_update(_pusher=undefined){
	var _colliding_instances = [];
	var _instance_directions = [];
	var _collision_amount = 0;
	var _length_ids = array_length(collision_ids);
	var _id = id;
	var _current_x = x;
	var _current_y = y;
	
	do{
		with (obj_collision){
			var _can_collide = false;
			
			for (var _i=0; _i < _length_ids; _i++){
				if (_id.collision_ids[_i] == collision_id){
					_can_collide = true;
			
					break;
				}
			}
			
			if (_can_collide){
				_collision_amount = general_collision_handler(_id, _colliding_instances, _instance_directions, _collision_amount, handle_collision_object_and_interaction_collision);
			}
		}
		
		with (obj_interaction){
			if (can_entities_collide){
				_collision_amount = general_collision_handler(_id, _colliding_instances, _instance_directions, _collision_amount, handle_collision_object_and_interaction_collision);
			}
		}
		
		if (!can_overlap){
			with (obj_entity){
				if (id != _id and id != _pusher and (!can_entities_push or !_id.can_push_entities) and !can_overlap){
					_collision_amount = general_collision_handler(_id, _colliding_instances, _instance_directions, _collision_amount, handle_entity_collision);
				}
			}
		}
		
		if (_current_x == x and _current_y == y){
			break;
		}else{
			_current_x = x;
			_current_y = y;
		}
	}until (_collision_amount == 0);
	
	if (can_push_entities){
		var _colliding_instances = [];
		var _instance_directions = [];
		var _collision_amount = 0;
		
		with (obj_entity){
			if (id != _id and id != _pusher and can_entities_push and !can_overlap and place_meeting(x, y, _id)){
				push_entity(_id);
				
				if (!_id.can_overlap and place_meeting(x, y, _id)){
					do{
						_collision_amount = general_collision_handler(_id, _colliding_instances, _instance_directions, _collision_amount, handle_entity_collision);
					}until (_collision_amount == 0);
				}
			}
		}
	}
}

function push_entity(_pusher){
	//Some information needed for the obj_entitys.
	var _pusher_collision_center_x = _pusher.x + ((sprite_get_bbox_right(_pusher.sprite_index) + 1 + sprite_get_bbox_left(_pusher.sprite_index))/2 - sprite_get_xoffset(_pusher.sprite_index))*_pusher.image_xscale;
	var _pusher_collision_center_y = _pusher.y + ((sprite_get_bbox_bottom(_pusher.sprite_index) + 1 + sprite_get_bbox_top(_pusher.sprite_index))/2 - sprite_get_yoffset(_pusher.sprite_index))*_pusher.image_yscale;
	var _pusher_collision_width = (sprite_get_bbox_right(_pusher.sprite_index) + 1 - sprite_get_bbox_left(_pusher.sprite_index))*abs(_pusher.image_xscale);
	var _pusher_collision_height = (sprite_get_bbox_bottom(_pusher.sprite_index) + 1 - sprite_get_bbox_top(_pusher.sprite_index))*abs(_pusher.image_yscale);
	
	//Get information about the collision of the obj_entity.
	var _collision_center_x = x + ((sprite_get_bbox_right(sprite_index) + 1 + sprite_get_bbox_left(sprite_index))/2 - sprite_get_xoffset(sprite_index))*image_xscale;
	var _collision_center_y = y + ((sprite_get_bbox_bottom(sprite_index) + 1 + sprite_get_bbox_top(sprite_index))/2 - sprite_get_yoffset(sprite_index))*image_yscale;
	var _collision_width = (sprite_get_bbox_right(sprite_index) + 1 - sprite_get_bbox_left(sprite_index))*abs(image_xscale);
	var _collision_height = (sprite_get_bbox_bottom(sprite_index) + 1 - sprite_get_bbox_top(sprite_index))*abs(image_yscale);
	
	if (round_collision_behavior){
		var _direction = point_direction(_pusher_collision_center_x, _pusher_collision_center_y, _collision_center_x, _collision_center_y);
		
		while (place_meeting(x, y, _pusher)){
			x += dcos(_direction);
			y -= dsin(_direction);
		}
	}else{
		var _pusher_moved_dist = max(abs(_pusher.xprevious - _pusher.x), abs(_pusher.yprevious - _pusher.y));
		var _pusher_left_collision = _pusher_collision_center_x - _pusher_collision_width/2;
		var _pusher_top_collision = _pusher_collision_center_y - _pusher_collision_height/2;
		
		if (_pusher.round_collision_behavior){
			if (_collision_center_x >= _pusher_left_collision and _collision_center_x <= _pusher_left_collision + _pusher_collision_width){
				if (!place_meeting(x, y + _pusher_moved_dist, _pusher)){ //Down pushing
					y += _pusher_collision_center_y + _pusher_collision_height/2 - _collision_center_y + _collision_height/2;
				}else{ //Up pushing
					y -= _collision_center_y + _collision_height/2 - _pusher_collision_center_y + _pusher_collision_height/2;
				}
			}else if(_collision_center_y >= _pusher_top_collision and _collision_center_y <= _pusher_top_collision + _pusher_collision_height){
				if (!place_meeting(x + _pusher_moved_dist, y, _pusher)){ //Right pushing
					x += _pusher_collision_center_x + _pusher_collision_width/2 - _collision_center_x + _collision_width/2;
				}else{ //Left pushing
					x -= _collision_center_x + _collision_width/2 - _pusher_collision_center_x + _pusher_collision_width/2;
				}
			}else{
				var _direction = point_direction(_pusher_collision_center_x, _pusher_collision_center_y, _collision_center_x, _collision_center_y);
				
				while (place_meeting(x, y, _pusher)){
					x += dcos(_direction);
					y -= dsin(_direction);
				}
			}
		}else{
			//These here are for determinating to which cardinal direction it should move.
			if (!place_meeting(x + _pusher_moved_dist, y, _pusher)){ //Right pushing
				x += _pusher_collision_center_x + _pusher_collision_width/2 - _collision_center_x + _collision_width/2;
			}else if (!place_meeting(x - _pusher_moved_dist, y, _pusher)){ //Left pushing
				x -= _collision_center_x + _collision_width/2 - _pusher_collision_center_x + _pusher_collision_width/2;
			}else if (!place_meeting(x, y + _pusher_moved_dist, _pusher)){ //Down pushing
				y += _pusher_collision_center_y + _pusher_collision_height/2 - _collision_center_y + _collision_height/2;
			}else{ //Up pushing
				y -= _collision_center_y + _collision_height/2 - _pusher_collision_center_y + _pusher_collision_height/2;
			}
		}
	}
	
	general_entity_update(_pusher); //Update the entity so it checks for collision in general of the entity, pass the _pusher id so it avoids taking into account the one that pushed it, as that one will do its own thing after this is done.
}

function start_choice_grid(){
	//TODO
}

function start_choice_plus(_x, _y, _start_centered=true){
	_x = real(_x);
	_y = real(_y);
	_start_centered = bool(_start_centered);
	
	var _found_option = -1;
	
	for (var _i = 0; _i < 4; _i++){
		if (!is_undefined(obj_game.options[_i])){
			if (_found_option == -1){
				_found_option = _i;
			}
			
			var _dialog_system = new DisplayDialog(0, 0, "[skip:false][progress_mode:none][asterisk:false]" + obj_game.options[_i][2], 640,, 2, 2);
			obj_game.options[_i][4] = _dialog_system; //Yes it literally loads a dialog displaying for each one, for the effects it contains.
			
			switch (_i){
				case 0:
					obj_game.options[0][0] -= _dialog_system.get_current_text_width() + 16;
					obj_game.options[0][1] -= _dialog_system.get_current_text_height()/2 - 8;
				break;
				case 1:
					obj_game.options[1][0] -= _dialog_system.get_current_text_width()/2 + 16;
					obj_game.options[1][1] += 8;
				break;
				case 2:
					obj_game.options[2][0] -= 16;
					obj_game.options[2][1] -= _dialog_system.get_current_text_height()/2 - 8;
				break;
				default: //3
					obj_game.options[3][0] -= _dialog_system.get_current_text_width()/2 + 16;
					obj_game.options[3][1] -= _dialog_system.get_current_text_height() - 8;
				break;
			}
			
			_dialog_system.move_to(_x + obj_game.options[_i][0] + 16, _y + obj_game.options[_i][1] - 14);
		}
	}
	
	if (_found_option >= 0){
		obj_game.state = GAME_STATE.DIALOG_CHOICE;
		obj_game.options_x = _x;
		obj_game.options_y = _y;
	
		if (_start_centered){
			obj_game.selection = -1;
		}else{
			obj_game.selection = _found_option; //The first one that finds is left, if not then, down, if not then, right, if not then, up; it's always secure it's one of those 4 cases.
			obj_game.options[_found_option][4].set_dialogues("[skip:false][progress_mode:none][asterisk:false][color_rgb:255,255,0]" + obj_game.options[_found_option][2]);
		}
	}
}

function create_choice_option(_direction, _distance, _text, _function){
	var _option_index = _direction;
	var _x = -_distance*dcos(90*_direction);
	var _y = _distance*dsin(90*_direction);
	
	if (_option_index >= 0){
		obj_game.options[_option_index] = [_x, _y, _text, _function];
	}
}

function start_box_menu(_index){
	if (obj_game.state == GAME_STATE.PLAYER_MENU_CONTROL){
		obj_game.player_menu_prev_state = PLAYER_MENU_STATE.CELL;
	}else{
		obj_game.player_menu_prev_state = -1;
	}
	
	obj_game.state = GAME_STATE.PLAYER_MENU_CONTROL;
	obj_game.player_menu_state = PLAYER_MENU_STATE.BOX;
	obj_game.player_box_index = _index;
	obj_game.player_box_cursor[1] = 0;
	
	if (array_length(global.player.inventory) > 0){
		obj_game.player_box_cursor[0] = 0;
	}else if (array_length(global.box.inventory[_index]) > 0){
		obj_game.player_box_cursor[0] = 1;
	}else{
		obj_game.player_box_cursor[0] = -1;
	}
}

function start_save_menu(_spawn_point_inst=undefined){
	if (obj_game.player_menu_prev_state == -2){
		obj_game.player_menu_prev_state = -1;
		
		return;
	}
	
	if (obj_game.state == GAME_STATE.PLAYER_MENU_CONTROL){
		obj_game.player_menu_prev_state = PLAYER_MENU_STATE.CELL;
	}else{
		obj_game.player_menu_prev_state = -1;
		
		global.player.hp = max(global.player.hp, global.player.max_hp);
		
		audio_play_sound(snd_player_heal, 100, false);
	}
	
	obj_game.player_save_spawn_point_inst = _spawn_point_inst;
	obj_game.state = GAME_STATE.PLAYER_MENU_CONTROL;
	obj_game.player_menu_state = PLAYER_MENU_STATE.SAVE;
	obj_game.player_save_cursor = 0;
}

function overworld_dialog(_dialogues, _top=true, _width=261, _height=56, _face_sprite=undefined, _face_subimages=undefined, _box=spr_box_normal, _tail=-1, _tail_mask=-1){
	with (obj_game){
		dialog.set_dialogues(_dialogues, _width, _height, _face_sprite, _face_subimages);
		dialog.set_scale(2, 2);
		dialog.set_container_sprite(_box);
		dialog.set_container_tail_sprite(_tail);
		dialog.set_container_tail_mask_sprite(_tail_mask);
		dialog.move_to(292 - _width, 320 - 310*_top);
	}
}

function change_room(_room_id, _spawn_point_instance, _room_change_fade_in_time=20, _room_change_wait_time=0, _room_change_fade_out_time=20, _end_room_func=undefined, _start_room_func=undefined, _after_transition_func=undefined){
	obj_game.state = GAME_STATE.ROOM_CHANGE;
	obj_game.goto_room = _room_id;
	obj_game.end_room_function = _end_room_func;
	obj_game.start_room_function = _start_room_func;
	obj_game.after_transition_function = _after_transition_func;
	obj_game.anim_timer = 0;
	obj_game.room_change_fade_in_time = max(ceil(_room_change_fade_in_time), 1); //Cannot allow decimals and negatives.
	obj_game.room_change_wait_time = max(obj_game.room_change_fade_in_time + ceil(_room_change_wait_time), 1);
	obj_game.room_change_fade_out_time = max(obj_game.room_change_wait_time + ceil(_room_change_fade_out_time), obj_game.room_change_fade_in_time + 1);
	
	obj_player_overworld.spawn_point_reference = _spawn_point_instance;
	obj_player_overworld.spawn_point_offset = obj_player_overworld.y - y - 10*image_yscale;
}

function get_room_name(_rm){
	var room_name = room_get_name(_rm);
	
	return global.UI_texts.rooms[$room_name];
}

function perform_game_save(_rm, _x, _y, _direction){
	var _file = file_text_open_write(working_directory + "/save0.save");
	var _items_amount = array_length(global.player.inventory);
	var _cell_amount = array_length(global.player.cell_options);
	var _box_count = array_length(global.box.inventory);
	var _save_struct_string = json_stringify(global.save_data);
	var _room_index_name = room_get_name(_rm);
	var _save_array = [
		_room_index_name,
		_x,
		_y,
		_direction,
		global.player.max_hp,
		global.player.hp,
		global.player.lv,
		global.player.gold,
		global.player.name,
		global.player.atk,
		global.player.def,
		global.player.exp,
		global.player.next_exp,
		global.player.weapon,
		global.player.armor,
		global.player.cell,
		_items_amount,
	];
	
	for (var _i = 0; _i < _items_amount; _i++){
		array_push(_save_array, global.player.inventory[_i]);
	}
	
	array_push(_save_array,
		global.player.inventory_size,
		_cell_amount
	);
	
	for (var _i = 0; _i < _cell_amount; _i++){
		array_push(_save_array, global.player.cell_options[_i]);
	}
	
	array_push(_save_array, _box_count);
	
	for (var _i = 0; _i < _box_count; _i++){
		var _box_amount = array_length(global.box.inventory[_i]);
		
		array_push(_save_array, _box_amount, global.box.inventory_size[_i]);
		
		for (var _j = 0; _j < _box_amount; _j++){
			array_push(_save_array, global.box.inventory[_i][_j]);
		}
	}
	
	array_push(_save_array,
		global.minutes,
		global.seconds,
		_save_struct_string
	);
	
	file_text_write_string(_file, json_stringify(_save_array));
	file_text_close(_file);
	
	global.last_save.player = {
		name: global.player.name,
		lv: global.player.lv
	}
	global.last_save.room_name = get_room_name(_rm);
	global.last_save.minutes = global.minutes;
	global.last_save.seconds = global.seconds;
}

function perform_game_load(){
	var _save_data = load_save_info();
	var _items_amount = _save_data[16];
	var _cell_amount = _save_data[18 + _items_amount] + _items_amount;
	var _box_count = _save_data[19 + _cell_amount];
	
	room_goto(asset_get_index(_save_data[0]));
	
	obj_game.start_room_function = function(){ //I need to avoid doing this, but I'm too lazy to change it now, if I don't forget, you won't see this message... maybe
		obj_player_overworld.x = obj_player_x;
		obj_player_overworld.y = obj_player_y;
		obj_player_overworld.image_alpha = 1;
		obj_player_overworld.player_sprite_reset(obj_player_direction);
		alarm[1] = 60;
	}
	
	obj_game.obj_player_x = _save_data[1];
	obj_game.obj_player_y = _save_data[2];
	obj_game.obj_player_direction = _save_data[3];
	
	global.player.max_hp = _save_data[4];
	global.player.hp = _save_data[5];
	global.player.lv = _save_data[6];
	global.player.gold = _save_data[7];
	global.player.name = _save_data[8];
	global.player.atk = _save_data[9];
	global.player.def = _save_data[10];
	global.player.exp = _save_data[11];
	global.player.next_exp = _save_data[12];
	global.player.weapon = _save_data[13];
	global.player.armor = _save_data[14]; //Yeah a consumable can be equipped as armor, even weapon.
	global.player.cell = _save_data[15];
	global.player.inventory = [];
	
	for (var _i = 0; _i < _items_amount; _i++){
		array_push(global.player.inventory, _save_data[17 + _i]);
	}
	
	global.player.inventory_size = _save_data[18 + _items_amount];
	global.player.cell_options = [];
	
	for (var _i = _items_amount; _i < _cell_amount; _i++){
		array_push(global.player.cell_options, _save_data[19 + _i]);
	}
	
	for (var _i = 0; _i < _box_count; _i++){
		global.box.inventory[_i] = [];
		global.box.inventory_size[_i] = _save_data[21 + _cell_amount];
		
		var _box_amount = _cell_amount + _save_data[20 + _cell_amount];
		
		for (var _j = _cell_amount; _j < _box_amount; _j++){
			array_push(global.box.inventory[_i], _save_data[22 + _j]);
		}
		
		_cell_amount = _box_amount + 2;
	}

	global.minutes = _save_data[20 + _cell_amount];
	global.seconds = _save_data[21 + _cell_amount];
	global.save_data = json_parse(_save_data[22 + _cell_amount]);
}

function load_save_info(){
	var _file_path = working_directory + "/save0.save";
	var _save_info = undefined;
	
	if (file_exists(_file_path)){
		var _file = file_text_open_read(_file_path);
		var _text = "";
		
		while (!file_text_eof(_file)){
			_text += file_text_read_string(_file);
			file_text_readln(_file);
		}
		file_text_close(_file);
		
		_save_info = json_parse(_text);
		
		var _save_size = array_length(_save_info);
		
		global.last_save.player = {
			name: _save_info[8],
			lv: _save_info[6]
		};
		global.last_save.room_name = get_room_name(asset_get_index(_save_info[0]));
		global.last_save.minutes = _save_info[_save_size - 3];
		global.last_save.seconds = _save_info[_save_size - 2];
	}else{
		global.last_save.player = {
			name: global.UI_texts[$"save empty player name"],
			lv: 0
		};
		global.last_save.room_name = "--";
		global.last_save.minutes = 0;
		global.last_save.seconds = 0;
	}
	
	return _save_info;
}

function start_battle(_enemies, _initial_dialog, _animation=BATTLE_START_ANIMATION.NORMAL, _init_function=undefined, _end_function=undefined, _heart_x=48, _heart_y=453){ //By default points to where the FIGHT button would be
	if (typeof(_enemies) != "array"){
		global.battle_enemies = [_enemies];
	}else{
		global.battle_enemies = _enemies;
	}
	
	with (obj_game){
		state = GAME_STATE.BATTLE_START_ANIMATION;
		battle_state = BATTLE_STATE.START;
		battle_init_function = _init_function;
		battle_end_function = _end_function;
		battle_start_animation_type = _animation;
		battle_start_animation_player_heart_x = _heart_x;
		battle_start_animation_player_heart_y = _heart_y;
		battle_current_box_dialog = _initial_dialog;
		battle_selection[0] = 0;
		
		if (_animation == BATTLE_START_ANIMATION.NORMAL or _animation == BATTLE_START_ANIMATION.FAST){
			anim_timer = -36;
			
			audio_play_sound(snd_warning, 100, false); //Plays the warning sound
		}else{
			anim_timer = 0;
			
			audio_play_sound(snd_switch_flip, 100, false); //Plays here since it doesn't play in the main time
		}
	}
}

function trigger_game_over(_music=mus_game_over, _dialog=undefined){ //This function is also used for the battle room, so it has a condition to separate both cases.
	with (obj_game){
		game_over_timer = 0;
		game_over_music = _music;
		state = GAME_STATE.GAME_OVER;
		
		if (is_undefined(_dialog)){
			var _dialog2 = global.UI_texts[$"game over dialogs"];
			game_over_dialog = _dialog2[irandom(array_length(_dialog2) - 1)];
		}else{
			game_over_dialog = _dialog;
		}
		
		var _length = array_length(game_over_dialog);
		for (var _i=0; _i<_length; _i++){
			var _dialog2 = game_over_dialog[_i];
			if (string_pos("[PlayerName]", _dialog2)){
				game_over_dialog[_i] = string_replace(_dialog2, "[PlayerName]", global.player.name);
			}
		}
		
		audio_stop_all();
		audio_play_sound(snd_player_hurt, 0, false);
		
		while (!dialog.is_finished()){
			dialog.next_dialog();
		}
		
		if (room == rm_battle){
			game_over_heart_index = obj_player_battle.image_index;
			game_over_heart_x = obj_player_battle.x;
			game_over_heart_y = obj_player_battle.y;
			game_over_heart_xscale = obj_player_battle.image_xscale;
			game_over_heart_yscale = obj_player_battle.image_yscale;
			game_over_heart_angle = obj_player_battle.image_angle;
			game_over_heart_color = obj_player_battle.image_blend;
			
			var _length = array_length(battle_enemies_dialogs);
			for (var _i=0; _i<_length; _i++){
				array_pop(battle_enemies_dialogs);
			}
			
			_length = array_length(battle_bullets);
			for (var _i=0; _i<_length; _i++){
				instance_destroy(battle_bullets[0]);
				array_delete(battle_bullets, 0, 1);
			}
		}else{
			game_over_heart_index = 0;
			game_over_heart_x = obj_player_overworld.x + obj_player_overworld.image_xscale;
			game_over_heart_y = obj_player_overworld.y - 15*obj_player_overworld.image_yscale;
			game_over_heart_xscale = 1;
			game_over_heart_yscale = 1;
			game_over_heart_angle = 0;
			game_over_heart_color = c_red;
		}
	}
}