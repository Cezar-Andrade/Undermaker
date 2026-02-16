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
#macro ASTERISK_SPACING 15

#macro PLAYER_BASE_INVULNERABILITY_FRAMES 90

/*
Constant that determinates custom craeted fonts, following the same name syntax that fonts use to keep consistency between fonts.
DO NOT UNDER ANY CIRCUMSTANCE PUT THE FUNCTION TO ADD FONTS DIRECTLY IN THE MACRO, USE A GLOBAL VARIABLE TO PASS THE INDEX.
Otherwise it will create the font everytime you call the macro, potentially causing memory leak.
*/
global.custom_fnt_hachiko = font_add_sprite(spr_fnt_hachiko, 32, true, 4)

#macro fnt_hachiko global.custom_fnt_hachiko

/*

*/
enum PLAYER_STATUS_EFFECT{
	NONE,
	KARMIC_RETRIBUTION //Because it's the most used of course you sans freaks!!!
}

/*

*/
enum SOUL_MODE{
	NORMAL, //Red
	GRAVITY //Blue
}

/*

*/
enum BUTTON{
	FIGHT,
	ACT,
	ITEM,
	MERCY
}

/*

*/
enum BATTLE_START_ANIMATION{
	NORMAL,
	FAST,
	NO_WARNING,
	NO_WARNING_FAST
}

/*

*/
enum BATTLE_STATE{
	START,
	START_DODGE_ATTACK,
	PLAYER_BUTTONS,
	PLAYER_ENEMY_SELECT,
	PLAYER_ATTACK,
	PLAYER_ACT,
	PLAYER_ITEM,
	PLAYER_MERCY,
	PLAYER_FLEE,
	PLAYER_WON,
	END,
	END_DODGE_ATTACK,
	PLAYER_DIALOG_RESULT,
	ENEMY_DIALOG,
	ENEMY_ATTACK,
	TURN_END
}

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

*/
enum PLAYER_STATE{
	NONE,
	STILL, //Like unable to move
	MOVEMENT
}

/*
Player menu states for the overworld player, used in the Player Overworld object.
*/
enum PLAYER_MENU_STATE{
	INITIAL,
	INVENTORY,
	ITEM_SELECTED,
	CELL,
	BOX, //From this state it can either go back to the overworld or the cell menu.
	SAVE,
	STATS,
	WAITING_DIALOG_END
}

/*
Player menu options that you can select in run time.
*/
enum PLAYER_MENU_OPTIONS{
	ITEM,
	STAT,
	CELL
}

/*
////TODO
*/
enum PLAYER_MENU_INVENTORY_OPTIONS{
	USE,
	INFO,
	DROP
}

/*
Directions of the options the player can choose in a multiple choice option direction dialog, used only in the create_choice_option() function to indicate which key to listen to for the choice option to select it.
*/
enum CHOICE_DIRECTION{
	LEFT,
	DOWN,
	RIGHT,
	UP
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
	BATTLE_START_ANIMATION,
	BATTLE,
	BATTLE_END,
	DIALOG_CHOICE,
	GAME_OVER
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