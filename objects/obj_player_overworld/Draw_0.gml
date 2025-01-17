/// @description Drawing of player and animation of battle starting

if (obj_game.state == GAME_STATE.BATTLE_START_ANIMATION){
	draw_sprite_ext(spr_player_bubble_warning_sign, bubble_warning_sprite_index, x, y - sprite_height - 2*image_yscale, image_xscale, image_yscale, 0, c_white, 1);
}

if (obj_game.state != GAME_STATE.BATTLE){
	draw_self();
}