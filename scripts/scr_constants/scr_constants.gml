/*
If you are gonna change the game size then you will have to redo the border system to fit the new game size and probably also change the border's size.
Also take into account the fullscreen feature with the , you might also need to change some stuff in it.
All that can be found in obj_game.
*/
#macro GAME_WIDTH 640
#macro GAME_HEIGHT 480

/*
Constant that tells how many pixels should the asterisk from the begginning of dialogs should be separated from the text.
It doesn't count the asterisk's size.
*/
#macro ASTERISK_SPACING 16

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
	MENU_CONTROL, //This state is not used in the engine, it is for you to use in your menu so you have your own logic and doesn't affect anything inside this engine, you can chane it, remove it, whatever you want.
	ROOM_CHANGE,
	PLAYER_CONTROL,
	PLAYER_MENU_CONTROL,
	EVENT,
	DIALOG_CHOICE
}

/*
Constants for the commands of the dialog system.
*/
enum COMMAND_TYPE{
	WAIT,
	WAIT_KEY_PRESS,
	WAIT_FOR,
	SKIP_ENABLING,
	SKIP_DIALOG,
	STOP_SKIP,
	DISPLAY_TEXT,
	PROGRESS_MODE,
	NEXT_DIALOG,
	FUNCTION,
	COLOR_RGB,
	COLOR_HSV,
	TEXT_EFFECT,
	DISABLE_TEXT_EFFECT,
	SET_TEXT_SPEED,
	SET_SPRITE,
	SET_SUBIMAGES,
	SET_SPRITE_SPEED,
	PLAY_SOUND,
	SET_VOICE,
	VOICE_MUTING,
	APPLY_TO_ASTERISK,
	SET_ASTERISK,
	SET_FONT,
	SET_WIDTH_SPACING,
	SET_HEIGHT_SPACING,
	SET_SPRITE_Y_OFFSET,
	SET_CONTAINER,
	SET_CONTAINER_TAIL,
	SET_CONTAINER_TAIL_MASK,
	SET_CONTAINER_TAIL_DRAW_MODE,
	SET_CONTAINER_TAIL_POSITION,
	SHOW_DIALOG_POP_UP,
	BIND_INSTANCE
}

/*
Constants for the various modes a dialog pop up can appear in a dialog, check the dialog system for more information on the user documentation.
*/
enum POP_UP_MODE{
	NONE,
	FADE,
	LEFT,
	RIGHT,
	UP,
	DOWN,
	INSTANT,
	LEFT_INSTANT,
	RIGHT_INSTANT,
	UP_INSTANT,
	DOWN_INSTANT,
}

/*
Constants for the various effects you can apply on dialog texts.
*/
enum EFFECT_TYPE{
	NONE,
	TWITCH,
	SHAKE,
	OSCILLATE,
	RAINBOW,
	SHADOW,
	MALFUNCTION
}

/*
Constants for the different ways of text displaying a dialog can have, only 2.
*/
enum DISPLAY_TEXT{
	LETTERS,
	WORDS
}

/*
Constants for the different draw modes the tail of a container can have, these are used in the dialog system when drawing the container with a tail.
*/
enum CONTAINER_TAIL_DRAW_MODE{
	BELOW,
	TOP,
	SPRITE_MASK,
	INVERTED_SPRITE_MASK
}

/*
Constants for the CONTROLLER_MAPPING state of a controller when there's no control map that game maker can assign in it.
*/
enum CONTROLLER_MAPPING{
	WAITING_ENTER,
	GET_CONFIRM,
	GET_CANCEL,
	GET_MENU,
	DONE
}