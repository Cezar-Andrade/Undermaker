/// @description Increases the game time.

//Only count minutes, if you want to include hours just gotta add the global variable
//And edit the save point drawing on the player_menu_system script when the state is PLAYER_MENU_STATE.SAVE
global.seconds++

if (global.seconds >= 60){
	global.seconds -= 60
	global.minutes++
}

alarm[1] = 60 //Keep counting as long as you're in game