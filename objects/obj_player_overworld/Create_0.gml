/// @description Initial variables

player_sprite_reset = function(_direction=0){
	sprite_index = walk_sprite
	image_index = animation_frames*_direction
}

player_anim_stop = function(){
	image_index	-= image_index%animation_frames
}

frisk_dance = true //Allow the player to do the frisk dance?
moon_walk = true //Let the player do a moon walk?
can_run = true //Player can run?
round_collision_behavior = false
can_collide = true
can_open_menu = true
state = PLAYER_STATE.MOVEMENT //The player can move around in the state 0, any other number makes the player do nothing, perfect for controlling separatedlly animations or any behavior, make sure to call player_anim_reset() so the player doesn't look like it's in the middle of a walk in the trigger event objects and interactions.
//If you wanna add other systems like, idle animations when the player stands on place or want it to fall asleep if they don't move for a period of time, you will need to add the variables and code the logic, you can use the state variable to manage these animations, modifying or adding code without making a conflict with already existing code (see the programmer manual for detailed info on how this engine operates).

bubble_warning_sprite_index = 0 //The exclamation mark that appears when an Encounter starts, check spr_player_bubble_warning_sign for the sprite itself and the available indexes.
movement_speed = 6
animation_speed = 6 //This is in a 30 FPS enviroment, that means that it takes twice the amount in 60 FPS actually, that is to avoid changing the sprite when it's not moving still.

walk_sprite = spr_unknown_walk
run_sprite = undefined
animation_frames = sprite_get_number(walk_sprite)/4 //Amount of frames the walking and running animations have, you can edit the code to change this dynamically in case your running sprite has more frames than the walking or viceversa, or create separate variables for these and use them in the step event of this object (requires you to edit the functions).

//-------------------------

player_previous_positions = []

x_previous = x
y_previous = y

state_none_function = undefined

spawn_point_reference = noone
spawn_point_offset = 0

timer = 2 //For replicating that 30 FPS feel on the 60 FPS, that means the variable player_speed is doubled for that reason, needed for the frisk_dance consistency.
animation_timer = 5 //Starts at animation_speed - 1, so it walks immediatelly when the button is pressed.
move_x = 0 //Used to move the player pixel by pixel
move_y = 0
move_to_x = undefined
move_to_y = undefined
