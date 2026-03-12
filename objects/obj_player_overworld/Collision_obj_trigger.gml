/// @description Trigger an event, change room, make a cutscene, etc.

//If it collides with an obj_trigger, trigger its event as long as you have control of the player tho.
if (obj_game.state == GAME_STATE.PLAYER_CONTROL){
	other.trigger_function()
}