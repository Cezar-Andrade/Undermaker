/// @description Initial variables

frisk_dance = true //Allow the player to do the frisk dance?
moon_walk = false //Let the player do a moon walk?
can_run = false //Player can run?
round_collision_behavior = false
can_collide = true
can_open_menu = true
state = PLAYER_STATE.MOVEMENT //The player can move around in the state 0, any other number makes the player do nothing, perfect for controlling separatedlly animations or any behavior, make sure to call player_anim_reset() so the player doesn't look like it's in the middle of a walk in the trigger event objects and interactions.
//If you wanna add other systems like, idle animations when the player stands on place or want it to fall asleep if they don't move for a period of time, you will need to add the variables and code the logic, you can use the state variable to manage these animations, modifying or adding code without making a conflict with already existing code (see the programmer manual for detailed info on how this engine operates).

timer = 2 //For replicating that 30 FPS feel on the 60 FPS, that means the variable player_speed is doubled for that reason, needed for the frisk_dance consistency.
bubble_warning_sprite_index = 0 //The exclamation mark that appears when an Encounter starts, check spr_player_bubble_warning_sign for the sprite itself and the available indexes.
animation_timer = 5 //Starts at animation_speed - 1, so it walks immediatelly when the button is pressed.
movement_speed = 6
animation_speed = 6 //This is in a 30 FPS enviroment, that means that it takes twice the amount in 60 FPS actually, that is to avoid changing the sprite when it's not moving still.
spawn_point_reference = noone
spawn_point_offset = 0

walk_sprite = spr_unknown_walk
run_sprite = undefined

player_sprite_reset = function(_direction=0){
	sprite_index = walk_sprite
	image_index = 4*_direction
}

player_anim_stop = function(){
	image_index	-= image_index%4
}