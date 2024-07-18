/*
If you are gonna change the game size then you will have to redo the border system to fit the new game size and probably also change the border's size.
Also take into account the fullscreen feature with the , you might also need to change some stuff in it.
All that can be found in obj_game.
*/
#macro GAME_WIDTH 640
#macro GAME_HEIGHT 480

/*
Control types that are mainly used for obj_game to set the global inputs of the user.
You can use them for something else as well in other variables and your own systems.
*/
enum CONTROL_TYPE{
	KEYBOARD,
	CONTROLLER,
	MAPPING_CONTROLLER
}

/*
Player menu states for the overworld player, used in the Player Overworld object.
*/
enum PLAYER_MENU_STATE{
	INITIAL,
	INVENTORY,
	INVENTORY_SELECTED,
	CELL,
	STATS,
	WAITING_DIALOG_END
}

/*
Player states for the overworld, used in the Player Overworld object, and changed with the Trigger events to do various stuff with the player, such as disabling it and moving it for cutscenes, or wait a certain amount of time to move.
Read the programmer manual to know more about this.
*/
enum GAME_STATE{
	MENU_CONTROL,
	ROOM_CHANGE,
	PLAYER_CONTROL,
	PLAYER_MENU_CONTROL,
	EVENT
}

/*
Constants for the commands of the dialog system.
*/
enum COMMAND_TYPE{
	WAIT,
	WAIT_PRESS_KEY,
	WAIT_FOR, ////DOES NOT WORK FOR NOW
	SKIP_ENABLING,
	SKIP_DIALOG,
	STOP_SKIP,
	DISPLAY_TEXT,
	PROGRESS_MODE,
	NEXT_DIALOG,
	FUNCTION, ////DOES NOT WORK FOR NOW
	COLOR_RGB,
	COLOR_HSV,
	TEXT_EFFECT,
	SET_TEXT_SPEED,
	SET_SPRITE,
	SET_SUBIMAGES,
	SET_SPRITE_SPEED,
	PLAY_SOUND,
	SET_VOICE,
	VOICE_MUTING,
	APPLY_TO_ASTERISK
}

/*
Constants for the various effects you can apply on dialog texts.
*/
enum EFFECT_TYPE{
	NONE,
	TWITCH,
	SHAKE,
	OSCILLATE,
	RAINBOW
}

/*
Constants for the different ways of text displaying a dialog can have, only 2.
*/
enum DISPLAY_TEXT{
	LETTERS,
	WORDS
}

/*
Constants for the mapping state of a controller when there's no control map that game maker can assign in it.
*/
enum MAPPING{
	WAITING_ENTER,
	GET_CONFIRM,
	GET_CANCEL,
	GET_MENU,
	DONE
}