/// @description Initial variables

frisk_dance = true; //Allow the player to do the frisk dance?
moon_walk = false; //Let the player do a moon walk?
state = 0; //The player is moving in the state 0, any other number makes the player do nothing, perfect for controlling separatedlly animations or any other thing, make sure to call player_anim_rest() so the player doesn't look like it's in the middle of a walk in the trigger event objects and interactions.
//If you wanna add other systems like, idle animations when the player stands on place or want it to fall asleep if they don't move for a period of time, you will need to add the variables and code the logic, modifying or adding the code without making a conflict with already existing code (see the programmer manual for detailed info on how this engine operates).

timer = 2; //For replicating that 30 FPS feel on the 60 FPS, that means the variable player_speed is doubled for that reason, needed for the frisk_dance consistency.
animation_timer = 0;
movement_speed = 3;
animation_speed = 6; //This is in a 30 FPS enviroment, that means that it takes twice the amount in 60 FPS actually, that is to avoid changing the sprite when it's standing still.
spawn_point_reference = noone;
spawn_point_offset = 0;

walk_sprite = spr_player_overworld_walk;

reset = function(){
	sprite_index = walk_sprite;
	image_index = 0;
}

