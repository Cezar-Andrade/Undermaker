/// @description Player movement

switch (obj_game.state){
	case GAME_STATE.PLAYER_MENU_CONTROL:
		////STILL TO DO
	break;
	case GAME_STATE.ROOM_CHANGE:
		if (obj_game.room_change_timer == 1){
			image_index -= image_index%4;
		}
	break;
	case GAME_STATE.PLAYER_CONTROL:
		timer--; //Timer that makes the player behave like if it was in 30 FPS running in a 60 FPS enviroment.
		
		if (timer == 0){
			timer = 2; //Reset the timer each time.
			
			//Animation timer to animate the player, of course.
			if (global.up_button > 0 or global.down_button > 0 or global.left_button > 0 or global.right_button > 0){
				animation_timer++;
			}else{ //Reset the animation and timer if it's not moving.
				animation_timer = animation_speed - 1; //Set to 1 frame of changing the animation so it looks like it moves immediatelly after pressing.
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

//Set the depth to it's current -Y position, so the player gives the effect of being behind or in front of stuff, essential.
depth = -y;