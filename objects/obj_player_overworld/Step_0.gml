/// @description Player movement

switch (obj_game.state){
	case GAME_STATE.BATTLE_START_ANIMATION:
		player_anim_stop(); //Player stops moving when a battle is about to happen.
	break;
	case GAME_STATE.ROOM_CHANGE:
		if (obj_game.anim_timer == 1){
			player_anim_stop();
		}
	break;
	case GAME_STATE.PLAYER_CONTROL:
		//Add more enums in the scr_constants and manage their logic here for more functionality of the player, like specific movement behavior or animations.
		switch (state){
			case PLAYER_STATE.NONE:
				//This is so other entities can manipulate it without interference, there's nothing here, in case you want something to happen when this state is on, put it here.
				//You could place all instance dependencies here, so the player can store some info and give feedback to the other instances that may be manipulating it, if not, it is recomendable to remove this case.
			break;
			case PLAYER_STATE.STILL: //Player is unable to move but the animation is being reset, it's different from the NONE state for that reason, make sure whatever put the player in the STILL state has a way to make it go back to MOVEMENT or you'll softlock yourself here.
				player_anim_stop();
			break;
			case PLAYER_STATE.MOVEMENT:
				timer--; //Timer that makes the player behave like if it was in 30 FPS running in a 60 FPS enviroment.
		
				if (timer == 0){
					timer = 2; //Reset the timer each time.
			
					//Animation timer to animate the player, of course.
					if (global.up_hold_button > 0 or global.down_hold_button > 0 or global.left_hold_button > 0 or global.right_hold_button > 0){
						animation_timer++;
					}else{ //Reset the animation and timer if it's not moving.
						animation_timer = animation_speed - 1; //Set to 1 frame of changing the animation so it looks like it moves immediatelly after pressing.
						player_anim_stop();
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
							if (collision_id == 0 and place_meeting(x, y + other.movement_speed*global.up_hold_button, other)){
								_y_upper_collision = true;
								break;
							}
						}
					}

					//The priority on up and right is intentional, you will have to edit this part of the code if you want that if both buttons are held, it doesn't move; this priority system is also benefitial for the frisk dance feature and moon walk.
					if (global.up_hold_button > 0 and (!_y_upper_collision or global.down_hold_button == 0)){
						y -= movement_speed*global.up_hold_button;
						while (image_index >= 12){
							image_index -= 4;
						}
						while (image_index < 8){
							image_index += 4;
						}
					}else if (global.down_hold_button > 0){
						y += movement_speed*global.down_hold_button;
						while (image_index >= 4){
							image_index -= 4;
						}
					}
			
					//Left and right movements, priority on right button, so you can only moon walk to the right, if you want it for both sides, do it differently than this.
					if (global.right_hold_button > 0){
						x += movement_speed*global.right_hold_button;
						while (image_index >= 8){
							image_index -= 4;
						}
						if (image_index < 4){
							image_index += 4;
						}
					}else if (global.left_hold_button > 0){
						x -= movement_speed*global.left_hold_button;
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
	break;
}