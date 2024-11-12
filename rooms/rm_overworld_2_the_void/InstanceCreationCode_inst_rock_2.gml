array_pop(collision_ids); //Remove the collision on id 0 so it doesn't collide with that one, but the player does.
array_push(collision_ids, 1); //Add collision to the 1.

can_player_push = !global.save_data.puzzle_1;
can_entities_push = true;
can_push_entities = true;

sprite_index = spr_rock;

if (global.save_data.puzzle_1){
	x = 540;
	y = 400;
}