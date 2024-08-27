/// @description Player movement

switch (obj_game.state){
	case GAME_STATE.PLAYER_MENU_CONTROL:
		////STILL TO DO
	break;
	case GAME_STATE.PLAYER_CONTROL:
		timer--; //Timer that makes the player behave like if it was in 30 FPS running in a 60 FPS enviroment.
		
		if (timer == 0){
			timer = 2; //Reset the timer each time.
			
			//Animation timer to animate the player, of course.
			if (global.up_button > 0 or global.down_button > 0 or global.left_button > 0 or global.right_button > 0){
				animation_timer++;
			}else{ //Reset the animation and timer if it's not moving.
				animation_timer = 0;
				image_index -= image_index%4;
			}
			
			//If the timer has reached the animation speed, update the frame of the animation.
			if (animation_timer >= animation_speed){
				animation_timer -= animation_speed;
				image_index++;
				
				//Walk and run frames constitute of 4 frames, if you need more than that, make sure to change it on all parts of the code, there's one above to set the player in neutral position.
				if (image_index%4 == 0){
					image_index -= 4;
				}
			}
			
			var _y_upper_collision = false;
			
			//Special case check for the frisk_dance trigger, cannot do it the normal way because of the collision id system.
			//By the way, I see you saying it's not accurate, you don't need it accurate, the feature is there and you can see it "dance", if you don't like it then do it yourself or deactivate it, this is what you're getting.
			if (frisk_dance){
				with (obj_collision){
					if (collision_id == 0 and place_meeting(x, y + other.movement_speed*global.up_button, other)){
						_y_upper_collision = true;
						break;
					}
				}
			}

			//The priority on up and right is intentional, you will have to edit this part of the code if you want that if both buttons are held, it doesn't move; this priority system is also benefitial for the frisk dance feature and moon walk.
			if (global.up_button > 0 and (!_y_upper_collision or global.down_button == 0)){
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
			
			//Left and right movements, priority on right button, so you can only moon walk to the right, if you want it for both sides, do it differently than this.
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
		}
	break;
}

var _colliding_instances = [];
var _instance_directions = [];
var _collision_amount = 0;

with (obj_collision){
	if (place_meeting(x, y, other) and !is_undefined(when_colliding)){
		when_colliding();
	}
}

with (obj_interaction){
	if (place_meeting(x, y, other) and !is_undefined(when_colliding)){
		when_colliding();
	}
}

with (obj_entity){
	if (place_meeting(x, y, other) and !is_undefined(when_colliding)){
		when_colliding();
	}
}

var _current_x = x;
var _current_y = y;
var _has_checked = false;

do{
	//This is for the obj_collision, which if the collision_id is 0, it will make the player collide with it.
	//Different ids of collision are used so other objects like obj_entity can interact with these in different ways, shaping mazes where you push rocks, etc.
	with (obj_collision){
		if (collision_id == 0){
			_collision_amount = general_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_collision_object_and_interaction_collision);
		}
	}
	
	//obj_interaction acts like collision as well if their variable is set.
	//These pack dialog if interacted with of course, but most of the time they are paired with a collision to interact on the wall or to an object you cannot pass trough.
	//So I made it a feature of the object itself, so you save space on putting it paired with a collision.
	with (obj_interaction){
		if (can_player_collide){
			_collision_amount = general_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_collision_object_and_interaction_collision);
		}
	}
	
	with (obj_entity){
		if (can_player_collide and !can_player_push){
			_collision_amount = general_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_entity_collision);
		}
	}
	
	if (!_has_checked){
		_has_checked = true;
		
		for (var _i=0; _i < _collision_amount; _i++){
			var _valid_direction = true;
			var _direction = _instance_directions[_i];
			var _offset_x = dcos(_direction);
			var _offset_y = -dsin(_direction);
			
			do{
				for (var _j=0; _j < _collision_amount; _j++){
					if (_i == _j){
						continue;
					}
					
					if (!place_meeting(_current_x + _offset_x, _current_y + _offset_y, _colliding_instances[_j])){
						_valid_direction = false;
						
						break;
					}
				}
				
				if (!_valid_direction){
					break;
				}
				
				_offset_x += dcos(_direction);
				_offset_y -= dsin(_direction);
			}until (!place_meeting(_current_x + _offset_x, _current_y + _offset_y, _colliding_instances[_i]));
			
			if (_valid_direction){
				for (var _j=0; _j < _collision_amount; _j++){
					if (_i == _j){
						continue;
					}
					
					if (place_meeting(_current_x + _offset_x, _current_y + _offset_y, _colliding_instances[_j])){
						_valid_direction = false;
						
						break;
					}
				}
				
				if (_valid_direction){
					for (var _j=0; _j < _collision_amount; _j++){
						if (_i == _j){
							continue;
						}
						
						_instance_directions[_j] = _direction;
					}
					
					break;
				}
			}
		}
	}
}until (_collision_amount == 0);
	
//obj_entity represents a being or an interactable object to do various stuff.
//So they act as a collision to the player no matter what, you may control what to do once the player collides with them with its collision function, like trigger some death scene perhaps from a foe.
with (obj_entity){
	if (can_player_collide and place_meeting(x, y, other)){
		//Function that runs when the player collides with the entity.
		if (!is_undefined(when_colliding)){
			when_colliding();
		}
		
		//If the pushable flag is true, then the object may be moved around by the player.
		if (can_player_push){
			push_entity(other);
			
			//When the pushing has taken effect and the object cannot be pushed around any further, then it may overlap the player, so a collsion has to be checked to see if the player is still colliding with it after the push action.
			if (place_meeting(x, y, other)){
				do{
					_collision_amount = general_collision_handler(other, _colliding_instances, _instance_directions, _collision_amount, handle_entity_collision);
				}until (_collision_amount == 0);
			}
		}
	}
}

if (obj_game.state == GAME_STATE.PLAYER_CONTROL){
	//This is the part where the interaction check is being executed.
	var _direction = 90*(image_index div 4); //It calculates the direction the player is looking, where 0 is down, 90 is right, 180 is up and 270 is left.
	var _is_interacting = false;
	
	with (obj_interaction){
		if (_is_interacting){
			break;
		}
		
		_is_interacting = handle_interaction_action(_direction, other.movement_speed);
	}
	
	with (obj_entity){
		if (_is_interacting){
			break;
		}
		
		_is_interacting = handle_interaction_action(_direction, other.movement_speed);
	}
}

//Set the depth to it's current -Y position, so the player gives the effect of being behind or in front of stuff, essential.
depth = -y;