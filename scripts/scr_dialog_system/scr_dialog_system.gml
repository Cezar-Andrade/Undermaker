//I MIGHT JUST MAKE 2 CONSTRUCTORS INSTEAD OF 3, BUBBLE AND BOX SHARE THE SAME PROPERTIES, SO IMMA MIX THEM ALL IN ONE.
//OR MAYBE JUST MAKE ALL IN 1, BECAUSE IT'S THE SAME, DIALOG BUT WITH A BOX BEHIND IT, THAT ONE CAN BE MANAGED IN THE DRAW ITSELF OF THE EXISTING DIALOG.

/*
This constructor/class makes a bubble dialogs, these don't start with asterisk, use only in battles/encounters preferably.

INTEGER _bubble_sprite -------------------> ID of the sprite to be used for the bubble that is behind the dialog.
ARRAY OF STRINGS / STRING _dialogues -----> Dialogs that will be displayed on screen, using the proper format for dialogs.
INTEGER _width ---------------------------> Amount of text that can fit horizontally in pixels, if you put it too low, words may display outside of the bubble as they don't fit in the line of text alone. (The bubble sprite will resize its width to the amount you put to contain the text inside.)
INTEGER _height --------------------------> Height in pixels of the bubble sprite, if NaN is given or if the text doesn't fit in that height, it will resize to fit all the dialogues, not just the current one displaying. (May cause a slight drop for a single frame depending of the amount of dialogues as it needs to calculate the height to contain the text of all of them inside.)
ARRAY OF INTEGERS / INTEGER _voices ------> ID or IDs of the audios that will be used for the voice of every single letter being displayed, by default it uses the monster voice.
INTEGER	_font ----------------------------> ID of the initial font resource that will be used for displaying the dialogs, by default it uses monster font.
INTEGER _face_sprite ---------------------> The ID or IDs of the sprite to be used as a face in the bubble dialog, if undefined is given, no face sprite will be shown, if multiple are given, it will iterate through them while the dialog is being spoken and the first ID will be the one for not speaking, usually bubble dialogs don't have it, but just in case you need it, there it is.
*/
function BubbleDialog(_bubble_sprite, _tail_sprite, _dialogues, _width, _height=NULL, _voices=NULL, _font=NULL, _face_sprite=NULL) constructor{
	
}

/*
This constructor/class makes a box dialog for the overworld, use only in overworld rooms preferably.
These dialogs have a fixed _width, it is recommended you don't modify it. (Because you can and I won't bother to do a check to prevent it when you can bypass or modify the code.)

ARRAY OF STRINGS / STRING _dialogues -----> Dialogs that will be displayed on screen, using the proper format for dialogs.
ARRAY OF INTEGERS / INTEGER _voices ------> The ID or IDs of the audios that will be used for the voice of every single letter being displayed, by default it uses the monster voice.
INTEGER	_font ----------------------------> The ID of the initial font resource that will be used for displaying the dialogs, by default it uses monster font.
INTEGER _face_sprite ---------------------> The ID or IDs of the sprite to be used as a face in the box dialog, if undefined is given, no face sprite will be shown, if multiple are given, it will iterate through them while the dialog is being spoken and the first ID will be the one for not speaking.
BOOLEAN	_asterisk ------------------------> Initialize the dialogs with an asterisk at the beginning or not.
INTEGER _box_sprite ----------------------> The ID of the sprite to be used for the bubble that is behind the dialog.
*/
function OverworldDialog(_dialogues, _voices=NULL, _font=NULL, _face_sprite=NULL, _asterisk=true, _box_sprite=NULL) constructor{
	
}

/*
This constructor/class allows for the dialogs to be displayed on screen, both the overworld and battle dialogs use this, this is basically the core of the dialogs system.
This can be used separatedly to make dialogs anytime you want, anywhere you want for any use you want.

FLOAT _x ----------------------------------------> Initial X position of the dialog, being the origin the left top corner.
FLOAT _y ----------------------------------------> Initial Y position of the dialog, being the origin the left top corner.
ARRAY OF STRINGS / STRING _dialogues ------------> Dialogs that will be displayed on screen, using the proper format for dialogs.
INTEGER _width ----------------------------------> Amount of text that can fit horizontally in pixels.
ARRAY OF INTEGERS / INTEGER _voices -------------> ID or IDs of the audios that will be used for the voice of every single letter being displayed, by default it uses the monster voice.
INTEGER _portrait_sprite ------------------------> ID of the sprite to be used as a portrait in the dialog, if undefined is given, no portrait sprite will be shown, by default is undefined.
ARRAY OF INTEGERS / INTEGER _portrait_subimages -> ID or IDs of the subimages of the sprite that will be used to animate it, if undefined is given, it will take all the subimages from the sprite and iterate through all of them by default for the animation, by default is undefined.
INTEGER _portrait_speed -------------------------> Frames it will take to change between the subimages of the sprite while it's speaking the dialog, by default it's 10 frames.
INTEGER _portrait_y_offset ----------------------> Offset in pixels for the Y coordinate between the portrait and the dialog text, if the number is positive, the text will be moved downwards, if the number is negative, the portrait is the one that will be moved downwards instead, this is to avoid offsetting the Y position in general of the dialog (for more information check the user manual and/or the programmer manual), by default is 0.
INTEGER	_font -----------------------------------> ID of the initial font resource that will be used for displaying the dialogs, by default it uses monster font.
INTEGER _spacing_width --------------------------> Space in pixels between the letters horizontally (spaces included), by default is 0.
INTEGER _spacing_height -------------------------> Space in pixels between the letters in new lines of text, by default is 0.
BOOLEAN	_asterisk -------------------------------> Initialize the dialogs with an asterisk at the beginning or not, by default is true.
*/
function DisplayDialog(_x, _y, _dialogues, _width, _voices=snd_monster_voice, _face_sprite=undefined, _face_subimages=undefined, _face_speed=10, _face_y_offset=0, _font=fnt_determination, _spacing_width=0, _spacing_height=0, _asterisk=true) constructor{
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//INITIALIZATION OF VARIABLES
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	//Timer variables for the text and its effects.
	text_timer = 0; //Starts at 0 so it executes the commands at the start of the dialog, if there are any, this happens at the very bottom.
	effect_timer = 0;
	text_speed = 2;
	
	//Variables to contain information.
	dialogues = [];
	dialogues_amount = 0; //There are variable that hold the lenght of the arrays, so there's no need to calculate it when needed.
	font = _font; //The font will never change, if you need it to change, you will have to add the command to it I guess.
	spacing_width = _spacing_width; //This is the additional space between letters, the fonts themselves already have a space between each letter, this adds more between them, can be negative as well.
	asterisk = _asterisk;
	dialog_x = _x; //X and Y coordinates of the dialog itself, can be moved around!
	dialog_y = _y;
	xscale = 1; //Can also be scaled being the pivot the top left corner of the boundary box of the text, check the user documentation for more information about that.
	yscale = 1;
	alpha = 1; //You can also make it transparent with this variable!
	color = []; //This variable is to color the text as it is being displayed, it gets filled in the draw function of this constructor.
	
	//Converts the voices into an array if it was given as a ref directly and also calculates length of the array in a variable.
	if (typeof(_voices) == "ref"){
		voices = [];
		voices_length = 1;
		
		array_push(voices, _voices);
	}else{
		voices = _voices;
		voices_length = array_length(voices);
	}
	initial_voices = voices; //This is to reset the voices if they get changed with the [voice] command.
	
	//Converts the dialog into an array if it was a single string given, if an array was given it makes a copy of that array to not modify the original one as arrays passed into other variables or as arguments pass the reference.
	if (typeof(_dialogues) == "string"){
		dialogues_amount = 1;
		array_push(dialogues, _dialogues);
	}else{
		dialogues_amount = array_length(_dialogues);
		array_copy(dialogues, 0, _dialogues, 0, dialogues_amount);
	}
	
	//Configuration variables for the dialog.
	string_index = -asterisk; //booleans are 0 (false) or 1 (true), so if true, this will start at -1.
	skipeable = true;
	can_progress = true; //This variable sets if the player can progress the dialog by pressing the confirm button, if false, it disables that, so you'll have to manually do it by code.
	reproduce_voice = true;
	wait_for_key = undefined; //This variable will hold the key the player will have to press to continue the dialog, make sure the player is aware of which one has to be tho, unless you use the confirm option of it.
	wait_for_function = undefined; //This variable will hold the function that has to run and return true (or a number above or equal to 1, since thats also true) in order to progress the dialog.
	function_arguments = undefined; //This variable holds the arguments of the function that is executed until it returns true.
	display_mode = DISPLAY_TEXT.LETTERS;
	display_amount = 1;
	
	//Variables that handle the portrait sprite in the dialog.
	face_sprite = _face_sprite;
	face_timer = 0;
	face_animation = true;
	face_y_offset = _face_y_offset;
	face_subimages_cycle = _face_subimages;
	face_index = 0;
	face_speed = _face_speed;
	
	//Width and alignment of the dialog.
	text_area_width = _width;
	text_align_x = 0;
	
	draw_set_font(font); //Set the font before doing string_width() calculations.
	
	//If the text will contain an asterisk, it calculates the width the text needs to move to the right to align.
	if (asterisk){
		asterisk_size = 2.5*string_width("*");
		text_align_x += asterisk_size;
	}
	
	//If the value given as sprite is a sprite, then align the text to the right depending on the size of the sprite.
	if (sprite_exists(face_sprite)){
		text_align_x += sprite_get_width(face_sprite) + 10;
		
		//If no subimages are given, it uses all of the subimages of the sprite for the speaking animation.
		if (!is_undefined(face_subimages_cycle)){
			if (typeof(face_subimages_cycle) == "number"){
				face_index = face_subimages_cycle;
				face_subimages_length = 1;
			}else{
				face_subimages_length = array_length(face_subimages_cycle);
			}
		}else{
			face_subimages_length = sprite_get_number(face_sprite);
		}
	}
	
	text_area_width -= text_align_x; //Substract the width the alignation the text has to move to the right.
	
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//INITIALIZATION OF VARIABLES FOR COMMAND AND ESCAPE SEQUENCE PARSING AND AUTO LINE JUMP ALGORITHM
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//Command handling and autoline jumping is being performed on all dialogs by this for cycle.
	action_commands = [];
	visual_commands = [];
	for (var _i = 0; _i < dialogues_amount; _i++){
		//Set variables for easier access to some information and containers too.
		var _dialog = dialogues[_i];
		var _dialog_length = string_length(_dialog); //Get the lenght of the dialog, it gets substracted as stuff is being removed.
		var _array_visual = []; //Saves only commands classified as visual for text rendering.
		var _array_action = []; //Saves only commands classified as action that change the way text is being displayed.
		
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//COMMAND AND ESCAPE SEQUENCE PARSER
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//This for cycle removes any escape sequence on the string and all the commands from the dialog as well by sorting the commands in the action and visual arrays.
		
		for (var _j = 1; _j <= _dialog_length; _j++){
			//Here is the command handling, finds a [ then starts doing it, it will error if no ] is found, make sure to always close your commands and use the proper format.
			while (string_char_at(_dialog, _j) == "["){
				var _command_end_index = string_pos_ext("]", _dialog, _j);
				var _command_length = _command_end_index - _j + 1; //Get the command length, since the first character is not counted in the substraction, 1 is added always.
				_dialog_length -= _command_length;
				
				//Start the information of the commands.
				var _command_content = string_split(string_copy(_dialog, _j + 1, _command_length - 2), ":"); //If no : is found, it gives an array of size 1, good to handle commands with no arguments.
				var _command_action = true; //Flag for command being an action.
				var _command_data = {index: _j};
				
				//Delete the command from the dialog itself, as it won't be displayed on the game.
				_dialog = string_delete(_dialog, _j, _command_length);
				
				//Sort the type of command, fill the data of it and flag it properly as visual or action.
				switch (_command_content[0]){
					case "wait": case "w":
						_command_data.type = COMMAND_TYPE.WAIT;
						_command_data.value = real(_command_content[1]);
					break;
					case "text_speed": case "talk_speed":
						_command_data.type = COMMAND_TYPE.SET_TEXT_SPEED;
						_command_data.value = real(_command_content[1]);
					break;
					case "sprite":
						_command_data.type = COMMAND_TYPE.SET_SPRITE;
						_command_data.value = string_split(_command_content[1], ",");
						var _command_arguments_length = array_length(_command_data.value);
					
						for (var _k = 0; _k < _command_arguments_length; _k++){
							_command_data.value[_k] = int64(_command_data.value[_k]);
						}
					break;
					case "subimages":
						_command_data.type = COMMAND_TYPE.SET_SUBIMAGES;
						_command_data.value = string_split(_command_content[1], ",");
						_command_arguments_length = array_length(_command_data.value);
					
						for (var _k = 0; _k < _command_arguments_length; _k++){
							_command_data.value[_k] = int64(_command_data.value[_k]);
						}
					break;
					case "animation_speed": case "anim_speed":
						_command_data.type = COMMAND_TYPE.SET_SPRITE_SPEED;
						_command_data.value = real(_command_content[1]);
					break;
					case "voice": case "voices": //Notice this command has a condition break.
						if (array_length(_command_content) > 1){ //If no arguments is provided to the voice command, it becomes an unmute command instead.
							_command_data.type = COMMAND_TYPE.SET_VOICE;
							_command_data.value = string_split(_command_content[1], ",");
							_command_arguments_length = array_length(_command_data.value);
					
							for (var _k = 0; _k < _command_arguments_length; _k++){
								_command_data.value[_k] = int64(_command_data.value[_k]);
							}
						
							break;
						}
					case "unmute":
						_command_data.type = COMMAND_TYPE.VOICE_MUTING;
						_command_data.value = true;
					break;
					case "no_voice": case "no_voices": case "mute":
						_command_data.type = COMMAND_TYPE.VOICE_MUTING;
						_command_data.value = false;
					break;
					case "play_sound":
						_command_data.type = COMMAND_TYPE.PLAY_SOUND;
						_command_data.value = int64(_command_content[1]);
					break;
					case "color_rgb":
						_command_data.type = COMMAND_TYPE.COLOR_RGB;
						_command_data.value = string_split(_command_content[1], ",");
						
						for (var _k = 0; _k < 3; _k++){ //If 3 arguments at minimum are not given, this will error.
							_command_data.value[_k] = clamp(int64(_command_data.value[_k]), 0, 255);
						}
						
						_command_action = false; //Flag command as visual
					break;
					case "color_hsv":
						_command_data.type = COMMAND_TYPE.COLOR_HSV;
						_command_data.value = string_split(_command_content[1], ",");
						
						for (var _k = 0; _k < 3; _k++){ //Same as rgb variant.
							_command_data.value[_k] = clamp(int64(_command_data.value[_k]), 0, 255);
						}
						
						_command_action = false; //Flag command as visual
					break;
					case "effect":
						_command_data.type = COMMAND_TYPE.TEXT_EFFECT;
						var _command_arguments = string_split(_command_content[1], ",");
						
						switch (_command_arguments[0]){
							case "twitch":
								_command_data.subtype = EFFECT_TYPE.TWITCH;
							
								if (array_length(_command_arguments) > 1){
									_command_data.value = abs(int64(_command_arguments[1]));
								}else{
									_command_data.value = 2;
								}
							break;
							case "shake":
								_command_data.subtype = EFFECT_TYPE.SHAKE;
							
								if (array_length(_command_arguments) > 1){
									_command_data.value = abs(int64(_command_arguments[1]));
								}else{
									_command_data.value = 2;
								}
							break;
							case "oscillate":
								_command_data.subtype = EFFECT_TYPE.OSCILLATE;
							
								if (array_length(_command_arguments) > 1){
									_command_data.value = abs(int64(_command_arguments[1]));
								}else{
									_command_data.value = 2;
								}
							break;
							case "rainbow":
								_command_data.subtype = EFFECT_TYPE.RAINBOW;
							
								if (array_length(_command_arguments) > 1){
									_command_data.value = abs(int64(_command_arguments[1]));
								}else{
									_command_data.value = 0;
								}
							break;
							default:
								_command_data.subtype = EFFECT_TYPE.NONE;
							break;
						}
						
						_command_action = false; //Flag command as visual
					break;
					case "next": case "continue": case "finish":
						_command_data.type = COMMAND_TYPE.NEXT_DIALOG;
					break;
					case "skip":
						_command_data.type = COMMAND_TYPE.SKIP_DIALOG;
					break;
					case "stop_skip":
						_command_data.type = COMMAND_TYPE.STOP_SKIP;
					break;
					case "wait_press_key":
						_command_data.type = COMMAND_TYPE.WAIT_PRESS_KEY;
						_command_data.value = _command_content[1];
					break;
					case "wait_for":
						_command_data.type = COMMAND_TYPE.WAIT_FOR;
						var _arguments = string_split(_command_content[1], ",");
						
						_command_data.value = handle_parse(_arguments[0]);
						array_delete(_arguments, 0, 1);
						_command_data.arguments = _arguments;
					break;
					case "skipless": case "no_skip":
						_command_data.type = COMMAND_TYPE.SKIP_ENABLING;
						_command_data.value = false;
					break;
					case "skipeable":
						_command_data.type = COMMAND_TYPE.SKIP_ENABLING;
						_command_data.value = true;
					break;
					case "progress_mode":
						_command_data.type = COMMAND_TYPE.PROGRESS_MODE;
						
						if (_command_content[1] == "input"){
							_command_data.value = true;
						}else{
							_command_data.value = false;
						}
					break;
					case "display_text":
						_command_data.type = COMMAND_TYPE.DISPLAY_TEXT;
						_command_arguments = string_split(_command_content[1], ",");
						
						switch (_command_arguments[0]){
							case "letters":
								_command_data.subtype = DISPLAY_TEXT.LETTERS;
							
								if (array_length(_command_arguments) > 1){
									_command_data.value = int64(_command_arguments[1]);
								}else{
									_command_data.value = 1;
								}
							break;
							case "words":
								_command_data.subtype = DISPLAY_TEXT.WORDS;
							
								if (array_length(_command_arguments) > 1){
									_command_data.value = int64(_command_arguments[1]);
								}else{
									_command_data.value = 1;
								}
							break;
						}
					break;
					case "apply_to_asterisk": //Only save this command if it's in the beginning of the dialog.
						if (_command_data.index == 1){
							_command_data.type = COMMAND_TYPE.APPLY_TO_ASTERISK;
							
							_command_action = false; //Flag command as visual.
						}else{
							continue;
						}
					break;
					case "func": case "function": case "method": ////THIS DOESN'T WORK
						_command_data.type = COMMAND_TYPE.FUNCTION;
						var _arguments = string_split(_command_content[1], ",");
						
						_command_data.value = handle_parse(_arguments[0]);
						array_delete(_arguments, 0, 1);
						_command_data.arguments = _arguments;
					break;
					default:
						continue;
				}
				
				//Puts the command in the proper array according to its type which has been flaged by the variable _command_action.
				if (_command_action){
					array_push(_array_action, _command_data);
				}else{
					array_push(_array_visual, _command_data);
				}
			}
			
			//Once all commands have been cleared out in an index, it checks the character that left.
			//Looks for any \ in the string and deletes it, ignoring the character that is next to it, useful for marking "[" as not a command so it prints it.
			if (string_char_at(_dialog, _j) == "\\"){
				_dialog = string_delete(_dialog, _j, 1);
				_dialog_length--;
			}
		}
		
		//Once all commands have been removed from the dialog and stored their information on the arrays, put them in the variables of commands in order so they match the dialog position on its array as well.
		array_push(action_commands, _array_action);
		array_push(visual_commands, _array_visual);
		
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//AUTO LINE JUMP ALGORITHM
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//From here starts the auto line jump algorithm for the dialog, that is why the width of the dialog is asked.
		
		var _word_ender_chars_array = [" ", "\n", "\r", "-", "/", "\\", "|"]; //Characters that are marked as word enders, usually all words end in one of these at least.
		var _length = 7; //Length of the _word_ender_chars_array, always is 7.
		var _current_action_commands_array = action_commands[_i]; //During the process of the automatic line jump, some line jumps are inserted, making it increase by 1 and offsetting the commands's indexes.
		var _current_action_commands_length = array_length(_current_action_commands_array);
		var _current_visual_commands_array = visual_commands[_i]; //These variables are to keep a short reference to the commands of the current dialog and their length, if needed when inserting line jumps.
		var _current_visual_commands_length = array_length(_current_visual_commands_array);
		
		//Indexes for searching and checking the word ender characters in the dialog.
		var _search_index = 0; //This one stores the index from where it starts searching in the dialog, it changes all the time so it doesn't repeteadly find the same character.
		var _last_newline_index = 0; //This one stores the most recent index where a line jump has been performed so it avoids unnecesarry calculation.
		var _check_index = 0; //This one stores the index it found a word ender character and is checked to determinate if it exceeds the width limit by the size of the letters at that point and perform a line jump in the dialog.
		var _last_check_index = 0; //This one stores the last index _check_index had before calculating the new one, whatever index this one holds is where the line jump is placed if it has to perform a line jump in the dialog.
		
		//While cycle that goes through all the dialog seeing if all words fit in the width provided and performs line jumps if needed to fit the text horizontally, but not vertically (have that in mind, your dialogs may end up with multiple lines if it's too long for the width limit given, read the user documentation for more information).
		while (_length > 0){
			var _j = 0;
			
			_last_check_index = _check_index; //Saves the last value _check_index had.
			while (_j < _length){ //While there are still word enders characters in the array, keep searching, once it doesn't find any, they get removed and eventually decrease _length.
				var _char_index = string_pos_ext(_word_ender_chars_array[_j], _dialog, _search_index);
				
				if (_char_index == 0){ //If character not found.
					array_delete(_word_ender_chars_array, _j, 1);
					_length -= 1; //Remove from the array and go again.
					
					if (_length == 0){ //If no more word enders are found, it checks now the very end of the string starting from the last line jump to measure its width.
						_check_index = _dialog_length; //It may not be a word ender that last position, but it doesn't matter as _check_index is not the index where the line jump is being done, but the previous one it had.
					}
					
					continue;
				}
				
				if (_j == 0){ //If it's the first iteration, which is the very first value the _word_ender_chars_array has, then set the _check_index.
					_check_index = _char_index;
				}else{ //Otherwise, just get the minimum index of any other found.
					_check_index = min(_char_index, _check_index);
				}
				
				_j++;
			}
			
			//In this part the _last_check_index must hold a previous index found by _check_index (which is a number above 0).
			//This means, the first time a word ender is found by _check_index, nothing is done other than keep the index so it gets set on _last_check_index (you can't jump a line with just 1 word, yes you can "wo\nrd", but that's 2 words not 1).
			if (_last_check_index > 0){
				var _last_char = string_char_at(_dialog, _last_check_index);
				
				//If the char the index in _last_check_index is a line jump, set the _last_newline_index on that index + 1, a manual line jump has been done, so start calculating the width from there instead.
				if (_last_char == "\n" or _last_char == "\r"){
					_last_newline_index = _last_check_index + 1;
				}else{ //Otherwise, check if it exceeds the width limit.
					var _char_amount = _check_index - _last_newline_index; //Calculates how many chars are between the last line jump and the index where a word ender char has been found.
					var _is_a_space = (string_char_at(_dialog, _last_check_index) == " ");
					
					//If the last index where a word ender is found it's a space, it replaces that space for a line jump, doesn't add it in between.
					if (!_is_a_space){
						_char_amount++; //If the character is not a space (and also cannot be a line jump \n or \r due to the previous condition of course), take it into account for the width size calculation.
					}
					
					var _string = string_copy(_dialog, _last_newline_index, _char_amount); //Get the string that represents the current line.
					if (text_area_width < string_width(_string) + _spacing_width*(string_length(_string) - 1)){ //For each character in the string - 1, add the width spacing of all of them that was given as _spacing_width between the letters besides the width size of the whole line for the calculation of width limit.
						//This section is only entered when a line jump is needed to be performed.
						var _insert_index = _last_check_index + 1; //This index is 1 ahead of the index where a line jump would be placed if it's a space, and it's where it would be placed if it wasn't a space instead, take it as an auxiliar to same a simple addition calculation.
						
						if (_is_a_space){ //If the word ender found previously with _last_check_index is a space, replace it with a line jump.
							_dialog = string_copy(_dialog, 0, _last_check_index - 1) + "\r" + string_copy(_dialog, _insert_index, string_length(_dialog));
						}else{ //Otherwise add it in between the letters.
							_dialog = string_insert("\r", _dialog, _insert_index);
							_dialog_length++;
							_check_index++; //Since a line jump is being added in the previous check index, and the current check index is ahead of it, it will be off by 1, so fix it by adding 1.
							
							//Adding something in between makes all indexes of the commands ahead of it off by 1 as well, these two for cycle fix that.
							for (_j = 0; _j < _current_action_commands_length; _j++){
								var _current_action_command = _current_action_commands_array[_j];
								
								//Any command index that is ahead of the point a line jump was inserted, will increase its index by 1, otherwise stay the same.
								if (_current_action_command.index > _insert_index){
									_current_action_command.index++;
								}
							}
							
							for (_j = 0; _j < _current_visual_commands_length; _j++){
								var _current_visual_command = _current_visual_commands_array[_j];
								
								//Any command index that is ahead of the point a line jump was inserted, will increase its index by 1, otherwise stay the same.
								if (_current_visual_command.index > _insert_index){
									_current_visual_command.index++;
								}
							}
						}
						
						//Set the start of the new line by setting the index of start of the new line.
						_last_newline_index = _last_check_index + 1;
					}
				}
			} //After a line jump as been performed or not, set the index position to look ahead for more word ender characters.
			_search_index = _check_index + 1;
		}
		
		//After all the commands have been removed from the dialog and inserted on arrays for their easy management.
		//And automatic line jumps have been inserted or replaced in the dialog, replace the dialog in the array of dialogs and repeat for the other dialogs.
		dialogues[_i] = _dialog;
	}
	
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//CURRENT DATA VARIABLES
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//Variables that get the current information of the current dialog to display it on screen properly.
	
	command_length = array_length(action_commands[0]);
	visual_command_length = array_length(visual_commands[0]);
	dialog = dialogues[0];
	default_spacing_height = string_height(string_replace_all(string_replace_all(dialog, "\n", " "), "\r", " ")) + _spacing_height; //Except this one, this is persistent, since the font never changes, the height set won't either.
	spacing_height = default_spacing_height;
	dialog_length = string_length(dialog); //Length of all the dialogs.
	
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//MAIN LOGIC FUNCTIONS
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//These functions are the ones meant to be called in your code so the dialogs can peform the actions.
	
	//The step function handles all the logic, portrait sprites and inputs from the player to have all the information of the current state of the dialog ready to display.
	//Prefered place to call this is in any of the 3 step functions, avoid using it on the draw events alongside the draw function, that is not a good practice.
	step = function(){
		//If there are no dialogs to display, return.
		if (dialogues_amount == 0){
			return;
		}
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//PLAYER INPUT CHECKING
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		//Condition to get the confirm button to advance to the next dialog.
		if (string_index == dialog_length and can_progress and (global.confirm_button or global.menu_hold_button)){ //global.confirm_button and global.menu_hold_button only returns 0 or 1, so essencially it's a great boolean thing.
			next_dialog();
			face_step();
			
			return;
		}
		
		//Conditions for the special wait commands, waiting for input on keyboard or buttons or until a function returns true.
		if (!is_undefined(wait_for_function)){
			if (method_call(wait_for_function, function_arguments)){ //Until true is returned, it will not reset wait_for_function.
				wait_for_function = undefined;
				function_arguments = undefined;
			}
		}else if (!is_undefined(wait_for_key)){
			switch (wait_for_key){
				case "confirm":
					if (global.confirm_button){
						wait_for_key = undefined;
					}
				break;
				case "cancel":
					if (global.cancel_button){
						wait_for_key = undefined;
					}
				break;
				case "menu":
					if (global.menu_button){
						wait_for_key = undefined;
					}
				break;
				case "any":
					if (keyboard_check_pressed(vk_anykey)){
						wait_for_key = undefined;
					}
				break;
				default:
					if (keyboard_check_pressed(ord(wait_for_key))){
						wait_for_key = undefined;
					}
				break;
			} //If there's not waiting in process, then if the player is pressing the cancel button, dialog may be skipped.
		}else if (string_index < dialog_length and skipeable and (global.cancel_button or global.menu_hold_button)){ //Same property with global.cancel_button from the others.
			skip_dialog();
		}
		//It is important to note that skip condition is checked after the next dialog condition, so text is shown on screen for the current frame and not just emptiness.
		
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//DIALOG PROGRESSION
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//First it is checked if it's not waiting for a key or a function and it's in range to advance the dialog.
		
		if (is_undefined(wait_for_key) and is_undefined(wait_for_function) and string_index < dialog_length){
			text_timer--; //Counts down until 0 is reached so it may advance the dialog.
			var _voice_reproduced = false; //In case multiple characters are being displayed, we don't want a sound for each one, right? It gets pretty loud otherwise.
		
			//First execute any commands that may be left over and are yet to be executed (that can happen due to the [wait] command not executing more commands once it's set).
			if (text_timer <= 0){
				execute_action_commands();
			
				//In the execution of the commands maybe any of these paramenters changed, must check again.
				while (text_timer <= 0 and is_undefined(wait_for_key) and is_undefined(wait_for_function) and string_index < dialog_length){
					face_animation = true;
				
					//--------------------------------------------------------------------------------------------------------------------------------------------------------
					//DIALOG ADVANCING TYPE
					//--------------------------------------------------------------------------------------------------------------------------------------------------------
				
					var _found_not_space = false; //This is a flag that sets to true once any character that is not a jump line or a space is found, this is to make a sound in the dialog.
					switch (display_mode){
						case DISPLAY_TEXT.LETTERS: //Dialog may advance by letters, one by one, set by the amount of letters that you want to be displayed on the dialog.
							for (var _i = 0; _i < display_amount; _i++){
								string_index++;
							
								if (string_index == 0){
									break; //If it's an initial asterisk what must be shown, do that and next frame do the letters (for stylish points).
								}
							
								var _letter = string_char_at(dialog, string_index);
								if (_letter == "\n" or _letter == "\r"){ //If it's a line jump, stop advacing the dialog, for stylish points (doesn't break anything if you don't, but it looks great this way).
									break;
								}else if (_letter != " "){
									_found_not_space = true; //Set flag since a non jump line or space has been found.
								}
							
								_letter = string_char_at(dialog, string_index + 1);
								if (_letter == "\n" or _letter == "\r"){ //If the character next to the currently being advanced is also a line jump, also stop advancing for even more stylish points.
									break;
								}
							}
						break;
						case DISPLAY_TEXT.WORDS: //Dialogs may advance by whole words instead, word by word, set by the amount of words that you want to display on the dialog.
							//If it's the beggining of the dialog and asterisk must be displayed, just advance one and stop doing it, next frame do the words.
							if (string_index < 0){
								string_index++;
							
								break;
							}
						
							//Follows kind of a similar cycle for the auto line jump algorithm.
							var _word_ender_chars_array = [" ", ",", ".", ":", ";", "\n", "\r", "-", "/", "\\", "|"];
							var _special_char_length = 11; //11 characters are considered word enders this time.
						
							//Set the search and check indexes.
							var _search_index = max(string_index + 1, 1); //_search_index sets its index to the next char from the current one in string_index.
						
							for (var _i = 0; _i < display_amount; _i++){ //Display X words.
								var _char = string_char_at(dialog, _search_index);
								var _check_index = 0; //Set to 0 every word displayed.
							
								//This while cycle searches starting from the _search_index for any of the word ender characters.
								var _j = 0;
								while (_j < _special_char_length){
									if (_char == _word_ender_chars_array[_j]){ //If the next char to the current is one word ender, increase the string_index by 1 and end there.
										string_index++;
										_check_index = -1;
									
										break;
									}
								
									var _char_index = string_pos_ext(_word_ender_chars_array[_j], dialog, _search_index);
								
									if (_char_index == 0){ //If no word ender character has been found, delete from the array since no more are in the dialog.
										_special_char_length--;
										array_delete(_word_ender_chars_array, _j, 1);
									
										continue; //Go again for the other word ender chars.
									}
								
									if (_check_index == 0){ //If its the very first word ender char found, set it on _check_index.
										_check_index = _char_index;
									}else{ //Otherwise, get the minimum index of them.
										_check_index = min(_char_index, _check_index);
									}
								
									_j++;
								}
							
								//Set the string_index depending on string_index value.
								if (_check_index == 0){ //_check_index is only 0 when no word ender chars have been found.
									string_index = dialog_length;
								
									break;
								}else if (_check_index > 0){ //_check_index is above 0 when a word ender has been found.
									string_index = _check_index; //It gets set ON the word ender character found.
								
									if (string_char_at(dialog, string_index) != "-"){ //If the word ender is "-" display it as well, otherwise no.
										string_index--;
									}
								}else{ //This is a section only executed when _check_index is -1, which only happens when the word ender char is the next one from the current one directly.
									var _letter = string_char_at(dialog, string_index);
								
									if (_letter == "\n" or _letter == "\r"){ //If it's a line jump, stop advacing the dialog.
										break;
									}
								}
							
								var _letter = string_char_at(dialog, string_index);
								if (_letter != " " and _letter != "\n" and _letter != "\r"){ //If the char in the current position of the string_index is not a jump line or a space, it's valid to set the flag.
									_found_not_space = true; //It always ends on end of word character when displaying a word, so it's guaranteed to find one per word, but not on spaces.
								}
							
								if (string_index + 1 < dialog_length){ //If it's inside the dialog length the index increased by 1.
									_letter = string_char_at(dialog, string_index + 1); //Then check the letter.
								
									if (_letter == "\n" or _letter == "\r"){ //If it's a jump line the next character where it ended, then stop advancing for stylish looks.
										break;
									}
								}
							
								//Update the _search_index by setting it one ahead of the current index.
								_search_index = string_index + 1;
							}
						break;
					}
				
					//--------------------------------------------------------------------------------------------------------------------------------------------------------
					//COMMAND EXECUTION
					//--------------------------------------------------------------------------------------------------------------------------------------------------------
				
					//After the string_index is in the correct position for the current frame, execute the commands it can do.
					var _execute_commands_code = execute_action_commands(); //The function returns always a number of the text_timer that was set by the commands or not.
					if (is_undefined(_execute_commands_code)){ //undefined is returned by the execution of commands only when the [next] command has been performed, that means another dialog is being displayed and this one is no longer valid, hence stop everything and return.
						return;
					}else if (_execute_commands_code <= 0){ //Otherwise, if the text_timer returned is below or equal to 0, set it to the text_speed.
						text_timer += text_speed; //Keep in mind that if you set it to negative number than the text_speed cannot add up to a positive, it will advance the text until it's greather than 0 either by commands or increasing by text_speed (for more information on that check the user documentation or the programmer documentation).
					}
				
					//--------------------------------------------------------------------------------------------------------------------------------------------------------
					//VOICE REPRODUCTION
					//--------------------------------------------------------------------------------------------------------------------------------------------------------
				
					var _voice = voices[0];
					if (voices_length > 1 and reproduce_voice){ //if there are at least 2 voices, and the voice is not muted, get the random voice.
						_voice = voices[irandom(voices_length - 1)];
					}
				
					//string_index being 0 means it has just displayed the initial asterisk, if there's no asterisk this condition never becomes true.
					if (string_index == 0){
						text_timer += 2*text_speed; //For the initial asterisk it takes 2 times the text_speed;
				
						if (reproduce_voice){
							audio_play_sound(_voice, 0, false);
							_voice_reproduced = true;
						}
				
						continue; //Since it is the first asterisk do nothing more.
					}
				
					var _letter = string_char_at(dialog, string_index);
				
					//If asterisks are enabled and the string_index is pointing to a line jump \n and not a \r one, then it takes twice the time to advance the dialog, it also stops the face animation.
					if (_letter == "\n" and asterisk){
						text_timer += 2*text_speed;
						face_animation = false;
					
						if (!_voice_reproduced and reproduce_voice){
							audio_play_sound(_voice, 0, false);
							_voice_reproduced = true;
						} //If no voice has been reproduced yet and something besides a space and line jumps have been found, reproduce the voice.
					}else if (!_voice_reproduced and reproduce_voice and _found_not_space){
						audio_play_sound(_voice, 0, false);
						_voice_reproduced = true;
					}
				}
			}
		}
		
		//Lastly just step the portrait animation, it does nothing if there's no sprite assigned to it.
		face_step();
	}
	
	//This functions is in charge of displaying the dialog and portrait (if set) properly with the information the step function has prepared, such as the proper string_index position and some other configuration things.
	//This functions must be called only in draw events of objects that use this constructor function, obviously.
	draw = function(){
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//SETTING DRAWING CONFIGURATION
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_font(font);
		
		//If there are no dialogs to display, end it there, but do set the properties in case some stuff depends from it.
		if (dialogues_amount == 0){
			return;
		}
		
		color[0] = c_white; //Resets color, this is to avoid creating another array every frame.
		color[1] = c_white; //Yes I know the garbage collector exists, but why must you make it collect every frame the same array?
		color[2] = c_white; //Ease some of the job it does.
		color[3] = c_white; //Optimize.
		
		var _letter_x = dialog_x + text_align_x;
		var _letter_y = dialog_y;
		
		//Do stuff only if the sprite for the portrait is set.
		if (sprite_exists(face_sprite)){
			//Portrait variables.
			var _face_y = _letter_y;
			var _subimage_index = face_index;
			
			//If the face Y offset given is positive, it moves that amount downwards the text from the top part of the sprite.
			if (face_y_offset > 0){
				_letter_y += face_y_offset;
			}else{ //Otherwise the portrait sprite downwards the amount downwards.
				_face_y -= face_y_offset;
			}
			
			//If more than 1 subimages has been given, get the current index that has been set by the face_step function in the step function.
			if (face_subimages_length > 1 and !is_undefined(face_subimages_cycle)){
				_subimage_index = face_subimages_cycle[face_index];
			}
			
			draw_sprite_ext(face_sprite, _subimage_index, dialog_x, _face_y, xscale, yscale, 0, c_white, alpha);
		}
		
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//DIALOG DISPLAYING
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		//Dialogs may start with a string_index of -1, so when it's that, nothing to do.
		if (string_index >= 0){
			effect_timer++; //This is a timer for effects on the dialog.
			
			//Variables for the different effects and the index of the visual commands.
			var _current_commands = visual_commands[0];
			visual_command_index = 0;
			visual_command_data = undefined;
			draw_position_effect = EFFECT_TYPE.NONE;
			draw_position_effect_value = 0;
			draw_color_effect = EFFECT_TYPE.NONE;
			draw_color_effect_offset = 0;
			draw_color_effect_value = 0;
			draw_effect_x = 0;
			draw_effect_y = 0;
			
			if (visual_command_length > 0){ //If there are any commands, set the visual_command_data already for the first one.
				visual_command_data = _current_commands[0];
			}
			
			if (asterisk){ //If there's an initial asterisk, draw it.
				if (execute_visual_commands(0, _current_commands)){ //If the command [apply_to_asterisk] is at the beginning of the dialog, then display it with all the effects that are loaded at that point.
					draw_text_transformed_color(_letter_x + draw_effect_x - asterisk_size, _letter_y + draw_effect_y, "*", xscale, yscale, 0, color[0], color[1], color[2], color[3], alpha);
				}else{ //Otherwise, display a normal asterisk.
					draw_text_transformed_color(_letter_x - asterisk_size, _letter_y, "*", xscale, yscale, 0, c_white, c_white, c_white, c_white, alpha);
				}
			}
			
			//------------------------------------------------------------------------------------------------------------------------------------------------------------
			//LETTER RENDERING
			//------------------------------------------------------------------------------------------------------------------------------------------------------------
			//This for cycle runs for every letter it has to draw, applying the effects and color it has to draw the letter with, these are defined by the visual commands.
			
			for (var _i = 1; _i <= string_index; _i++){
				execute_visual_commands(_i, _current_commands); //Execute the visual commands.
				
				var _letter = string_char_at(dialog, _i);
				
				if (_letter == "\n" or _letter == "\r"){ //If it's a line jump do other stuff.
					_letter_x = dialog_x + text_align_x;
					_letter_y += spacing_height;
					
					if (_letter == "\n" and asterisk){ //If the line jump is \n, print an asterisk, conserving the properties of the effects.
						if (draw_color_effect == EFFECT_TYPE.RAINBOW){ //If the effect currently on is a rainbow, do a different color rendering.
							draw_text_transformed_color(_letter_x + draw_effect_x - asterisk_size, _letter_y + draw_effect_y, "*", xscale, yscale, 0, draw_color_effect_value, draw_color_effect_value, draw_color_effect_value, draw_color_effect_value, alpha);
						}else{
							draw_text_transformed_color(_letter_x + draw_effect_x - asterisk_size, _letter_y + draw_effect_y, "*", xscale, yscale, 0, color[0], color[1], color[2], color[3], alpha);
						}
					}
				}else{ //Otherwise, render the letter.
					if (draw_color_effect == EFFECT_TYPE.RAINBOW){ //If the effect currently on is a rainbow, do a different color rendering.
						draw_text_transformed_color(_letter_x + draw_effect_x, _letter_y + draw_effect_y, _letter, xscale, yscale, 0, draw_color_effect_value, draw_color_effect_value, draw_color_effect_value, draw_color_effect_value, alpha);
					}else{
						draw_text_transformed_color(_letter_x + draw_effect_x, _letter_y + draw_effect_y, _letter, xscale, yscale, 0, color[0], color[1], color[2], color[3], alpha);
					}
					
					_letter_x += string_width(_letter) + spacing_width; //Incremented the X position by the width of the letter plus additional space given by the user.
				}
			}
		}
	}
	
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//CALLABLE FUNCTIONS
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//These functions you can call to perform certain actions in the dialog from your code and not from the user input, usually you would use these when you negate the input to the player from doing these.
	
	//This function when called skips the dialog, something the player can do by pressing the cancel button, but there are commands that disable it, so you can call this so you can manually in code do it.
	//It can be called any moment, of course calling it once the text is done or the user has skipped it won't do anything instead.
	//Be aware that if you call this function before the step function and the user does a perfect frame confirm press (if it can progress the dialog) as you call this function in your code, it may jump the dialog immediatelly, if you want to avoid that, call it after the step event has been called.
	skip_dialog = function(){
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//COMMAND EXECUTION
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		text_timer = 0; //Set the text_timer to 0 so it if it stops skipping by some commands, it executes any command that may be still in the position.
		string_index = dialog_length; //Set the string_index to the final of the dialog so it executes all commands properly.
		
		if (is_undefined(execute_action_commands(true))){ //If executing the action commands ends up with a undefined being returned, it means the dialog is different now and this context is no longer needed.
			return undefined; //Since the skip_dialog may be called by a command as well, return the undefined received as it stops any execution in the step or next_dialog functions.
		}
		
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//VOICE REPRODUCTION
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//Reproduce a voice if the skip happens however and no other thing interrupts it.
		
		if (reproduce_voice){
			var _voice = voices[0];
		
			if (voices_length > 1){
				_voice = voices[irandom(voices_length - 1)];
			}
			audio_play_sound(_voice, 0, false);
		}
		
		return text_timer; //Return the text_timer that may have been changed by the execution of the commands.
	}
	
	//This function when called goes directly to the next dialog, regardless of the state the dialog may be in, if there's no more dialogs, it show nothing then.
	//If it's called when there's no dialog on screen (that only happens when the dialogs have been depleted), it does nothing.
	//It contains an argument which can be set to false so it ignores all commands yet to be executed further in the dialog, this may end up with some settings not being set such as portraits not changing sprite because the command was ignored as the function was called with a false argument, ending with some inconsistencies.
	//Unless you know what you're doing I recommend leaving it as true by default (for more information on this, check the user or programmer documentation).
	next_dialog = function(_do_commands=true){
		//If no more dialogs are there, just do nothing.
		if (dialogues_amount == 0){
			return;
		}
		
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//COMMAND EXECUTION
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//To execute the commands it is used skip_dialog function instead of doing it itself, repeating some code, so just make skip_dialog do it.
		
		if (_do_commands){ //Execute all commands yet to be executed
			do{
				//Sometimes in the commands, these variables may be set by the commands and they stop the skip_dialog from continuing, so in case it fails to finish the skip for any reason, set them to undefined.
				wait_for_key = undefined;
				wait_for_function = undefined;
				function_arguments = undefined;
				
				if (is_undefined(skip_dialog())){ //If undefined is returned, it means it has found a [next] command that skips the dialog and advances to the next, since that one will do the job already, then stop this execution.
					return;
				}
			}until (string_index == dialog_length); //Since the skip_dialog function is being used for executing all commands remaining in the dialog, sometimes it may find commands that stop the skip, in this case that is not what it is wanted as it is advancing the dialog to the next one.
		} //So instead the do-until cycle, makes sure the dialog always executes all the commands in it, if it stops the skips, well, do it again.
		
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//DIALOG ADVACING
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//After commands have been executed to set or change portrait sprites or other persistent configuration, the variables are reset and from the arrays of commands and dialog, it is removed the one that it holds currently, it is no longer needed.
		
		array_delete(action_commands, 0, 1);
		array_delete(visual_commands, 0, 1);
		array_delete(dialogues, 0, 1);
		dialogues_amount--;
		
		//If no more dialogs are there after deleting it, just finish there.
		if (dialogues_amount == 0){
			return;
		}
		
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//VARIABLE RESET
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//If there are no stopping points, reset the variables.
		
		command_length = array_length(action_commands[0]);
		visual_command_length = array_length(visual_commands[0]);
		dialog = dialogues[0];
		voices = initial_voices; //Voices get reset.
		voices_length = array_length(initial_voices);
		text_timer = 0; //Starts at 0 so initial commands execute.
		text_speed = 2; //Speed also gets reset.
		effect_timer = 0;
		string_index = -asterisk;
		spacing_height = default_spacing_height;
		dialog_length = string_length(dialog);
		skipeable = true; //Player input checking is restored.
		can_progress = true;
		reproduce_voice = true; //Voice gets unmuted.
		wait_for_key = undefined;
		function_arguments = undefined;
		wait_for_function = undefined;
		display_mode = DISPLAY_TEXT.LETTERS; //Display mode also gets reset.
		display_amount = 1;
		face_animation = true;
		
		if (execute_action_commands() == 0){ //Execute any initial commands and if no text_timer is set, strart it on 1.
			text_timer = 1;
		}
	}
	
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//NOT CALLABLE FUNCTIONS
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//Calling these functions in your code does nothing or just speeds up the portrait animation, so just don't execute them, as commands already give you a way to speed up portrait animation.
	
	//This is a special step function that controls only the portrait sprite of the dialog if there's any, since there are more than 1 place that needs to execute the same logic, it is a separate function (only 2 places in the step function XD).
	face_step = function(){
		//First it checks for the sprite, if the sprite exists and has more than 1 subimage assigned for use, then continue.
		if (sprite_exists(face_sprite) and face_subimages_length > 1){
			//This condition prevents the animation from running when a [wait] command has been executed, so it looks like it's actually talking.
			if (((string_index < dialog_length and is_undefined(wait_for_key) and is_undefined(wait_for_function)) and face_animation or face_index > 0) and string_index > 0){ //Once again, abusing the fact, booleans are 0 (false) and 1 (true).
				face_timer++; //Counter for the portrait animations
			
				if (face_timer >= face_speed){ //When it's time to change the subimage for the animation do the following.
					face_timer -= face_speed;
					face_index++; //Just change the index of the portrait sprite.
					
					if (face_index >= face_subimages_length){ //If it goes over the length of the array, set it back to 0.
						face_index = 0;
					}
				}
			}else{ //When it's not talking, just set the first index for the sprite.
				face_index = 0;
			}
		}
	}
	
	//This function is in charge of executing all the action commands of the dialog, this function is being called in several parts of the step function and on initialization.
	//It returns the current text_timer everytime it's called, except when it executes the command [next] (or its variants) where it returns undefined, there's only one point in the step function where that matters.
	execute_action_commands = function(_is_skipping=false){
		if (command_length > 0){ //If there are any commands to execute, do enter.
			//------------------------------------------------------------------------------------------------------------------------------------------------------------
			//VARIABLE DEFINITION
			//------------------------------------------------------------------------------------------------------------------------------------------------------------
			//Set the variables for action command execution.
			
			var _current_commands = action_commands[0];
			var _command_data = _current_commands[0];
			var _index = max(string_index, 0) + 1;
			var _has_skipped = _is_skipping;
			
			//While commands exist and not wait events happen and the index of the command is in bounds of the current position of the dialog and text_timer is under or equal 0 or _is_skipping is set, do execute commands.
			while (command_length > 0 and is_undefined(wait_for_key) and is_undefined(wait_for_function) and (_is_skipping or (text_timer <= 0 and _command_data.index <= _index))){
				//--------------------------------------------------------------------------------------------------------------------------------------------------------
				//COMMAND TYPE EXECUTION
				//--------------------------------------------------------------------------------------------------------------------------------------------------------
				//Depeding of the type of command which has been set by the parser of commands, do different stuff.
				
				switch (_command_data.type){
					case COMMAND_TYPE.WAIT:
						//When the text is skipping, it ignores specific commands, such as wait.
						if (_is_skipping){
							break;
						}else{
							string_index = min(_command_data.index - 1, string_index);
						}
						
						text_timer = _command_data.value;
						face_animation = false;
					break;
					case COMMAND_TYPE.WAIT_PRESS_KEY:
						//Some commands, may stop the skipping, like wait press key or stop skip.
						string_index = min(_command_data.index - 1, string_index);
						
						if (_is_skipping){
							_index = max(string_index, 0) + 1;
							
							_is_skipping = false;
						}
						
						wait_for_key = _command_data.value;
						face_animation = false;
					break;
					case COMMAND_TYPE.WAIT_FOR:
						string_index = min(_command_data.index - 1, string_index);
						
						if (_is_skipping){
							_index = max(string_index, 0) + 1;
							
							_is_skipping = false;
						}
						
						wait_for_function = _command_data.value;
						function_arguments = _command_data.arguments;
						face_animation = false;
					break;
					case COMMAND_TYPE.SKIP_ENABLING:
						skipeable = _command_data.value;
						
						if (_is_skipping and !skipeable){
							string_index = min(_command_data.index - 1, string_index);
							_index = max(string_index, 0) + 1;
							
							_is_skipping = false;
						}
					break;
					case COMMAND_TYPE.SKIP_DIALOG:
						//No need to skip when it is already skipping.
						if (_is_skipping){
							break;
						}
						
						//Since a skip is comming, and it returns, it is needed to remove the command from here.
						command_length--;
						array_delete(_current_commands, 0, 1);
					return skip_dialog(); //When skipping dialog it will call this function again with _is_skipping being true, so just do a return with any value the skip_dialog() returns.
					case COMMAND_TYPE.STOP_SKIP:
						//Yeah, this prevents the skip to continue.
						if (_is_skipping){
							string_index = min(_command_data.index - 1, string_index);
							_index = max(string_index, 0) + 1;
							
							_is_skipping = false;
						}
					break;
					case COMMAND_TYPE.DISPLAY_TEXT:
						string_index = min(_command_data.index - 1, string_index);
						_index = max(string_index, 0) + 1;
						
						display_mode = _command_data.subtype;
						display_amount = _command_data.value;
					break;
					case COMMAND_TYPE.PROGRESS_MODE:
						can_progress = _command_data.value;
					break;
					case COMMAND_TYPE.NEXT_DIALOG:
						next_dialog(false);
					return undefined; //When next dialog, stop executing commands.
					case COMMAND_TYPE.FUNCTION:
						method_call(_command_data.value, _command_data.arguments);
					break;
					case COMMAND_TYPE.SET_TEXT_SPEED:
						text_speed = _command_data.value;
					break;
					case COMMAND_TYPE.SET_SPRITE:
						var _sprite = _command_data.value[0];
						
						if (!sprite_exists(_sprite)){
							break;
						}
						
						face_sprite = _sprite;
						
						array_delete(_command_data.value, 0, 1);
						
						if (array_length(_command_data.value) == 0){
							break;
						}
					case COMMAND_TYPE.SET_SUBIMAGES: //Yeah, what this does, the set_sprite command also uses.
						face_index = 0;
						var _subimages = _command_data.value;
						var _subimages_length = array_length(_subimages);
						
						if (_subimages_length > 0){
							face_subimages_length = _subimages_length;
							if (face_subimages_length == 1){
								face_index = _subimages[0];
								face_subimages_cycle = face_index;
							}else{
								face_subimages_cycle = _subimages;
							}
						}else{
							face_subimages_cycle = undefined;
							face_subimages_length = sprite_get_number(face_sprite);
						}
					break;
					case COMMAND_TYPE.SET_SPRITE_SPEED:
						face_speed = _command_data.value;
					break;
					case COMMAND_TYPE.PLAY_SOUND:
						audio_play_sound(_command_data.value, 100, false);
					break;
					case COMMAND_TYPE.SET_VOICE:
						reproduce_voice = true;
						voices = _command_data.value;
						voices_length = array_length(voices);
					break;
					case COMMAND_TYPE.VOICE_MUTING:
						reproduce_voice = _command_data.value;
					break;
				}
				
				//Remove the command from the list once it has been executed, it is no longer needed and free some memory.
				command_length--;
				array_delete(_current_commands, 0, 1);
				
				//If commands are still available, keep doing it.
				if (command_length > 0){
					_command_data = _current_commands[0];
				}
			}
			
			//If the commands were skipping but a command stopped the skip, then set the text_timer to the text_speed.
			if (_has_skipped and !_is_skipping){
				text_timer = text_speed;
			}
		}
		
		return text_timer; //Return the current text_timer for stuff to be done in the dialogs.
	}
	
	//This function is in charge of executing all the visual commands of the dialog, this function only gets called 2 times in the draw function.
	//It returns wheter if the command [apply_to_asterisk] has been executed, which can only happen at the very start of displaying the dialog, so if the first call in the draw step doesn't return true, it will always return false.
	execute_visual_commands = function(_i, _current_commands){
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//VARIABLE DEFINITION
		//----------------------------------------------------------------------------------------------------------------------------------------------------------------
		//Set the variables for executing visual commands and its configuration.
		
		var _is_initial_asterisk = false;
		var _aux_i = max(_i, 1); //For checking the initial asterisk properties, _i gives a 0, but since the index on strings start at 1, this has to be done.
		
		while (visual_command_index < visual_command_length and visual_command_data.index <= _aux_i){
			//These are for color specific commands.
			var _color_direction = "";
			var _color = 0;
			
			//------------------------------------------------------------------------------------------------------------------------------------------------------------
			//COMMAND TYPE EXECUTION
			//------------------------------------------------------------------------------------------------------------------------------------------------------------
			//There are color commands, effect commands and the special command to apply the effects and colors to the initial asterisk of the dialog.
			
			switch (visual_command_data.type){
				case COMMAND_TYPE.APPLY_TO_ASTERISK:
					_is_initial_asterisk = true; //Flag to set the application of the effects and colors currently configured to the asterisk, can be used more than 1 time at the beginning and will override the previous one, please avoid that.
				break;
				case COMMAND_TYPE.COLOR_RGB:
					var _values = visual_command_data.value;
					_color = make_color_rgb(_values[0], _values[1], _values[2]);
					draw_color_effect = EFFECT_TYPE.NONE; //Overrides any color effect.
					
					//Type of coloring
					if (array_length(_values) >= 4){
						_color_direction = _values[3];
					}else{
						_color_direction = "all";
					}
				break;
				case COMMAND_TYPE.COLOR_HSV:
					_values = visual_command_data.value;
					_color = make_color_hsv(_values[0], _values[1], _values[2]);
					draw_color_effect = EFFECT_TYPE.NONE; //Overrides any color effect.
					
					//Type of coloring.
					if (array_length(_values) >= 4){
						_color_direction = _values[3];
					}else{
						_color_direction = "all";
					}
				break;
				case COMMAND_TYPE.TEXT_EFFECT:
					var _subtype = visual_command_data.subtype;
					
					//Effects subtyping.
					switch (_subtype){
						case EFFECT_TYPE.RAINBOW:
							draw_color_effect = _subtype;
							draw_color_effect_offset = visual_command_data.value;
						break;
						case EFFECT_TYPE.NONE: //When none type is used (usually by just [effect] with no arguments or not valid effect arguments), remove all effects.
							draw_position_effect = EFFECT_TYPE.NONE;
							draw_color_effect = EFFECT_TYPE.NONE;
						break;
						default: //These are the effects for position of the text.
							draw_position_effect_value = visual_command_data.value;
							
							if (draw_position_effect_value == 0){
								draw_position_effect = EFFECT_TYPE.NONE;
							}else{
								draw_position_effect = _subtype;
							}
						break;
					}
				break;
			}
			
			//------------------------------------------------------------------------------------------------------------------------------------------------------------
			//COLORING TYPE
			//------------------------------------------------------------------------------------------------------------------------------------------------------------
			//When the text is being colored, it can be set what corners to apply the color, if no valid one is given, it does nothing.
			
			switch (_color_direction){
				case "up":
					color[0] = _color;
					color[1] = _color;
				break;
				case "down":
					color[2] = _color;
					color[3] = _color;
				break;
				case "left":
					color[0] = _color;
					color[3] = _color;
				break;
				case "right":
					color[1] = _color;
					color[2] = _color;
				break;
				case "up_left":
					color[0] = _color;
				break;
				case "up_right":
					color[1] = _color;
				break;
				case "down_right":
					color[2] = _color;
				break;
				case "down_left":
					color[3] = _color;
				break;
				case "all":
					color[0] = _color;
					color[1] = _color;
					color[2] = _color;
					color[3] = _color;
				break;
			}
			
			//Advance to the next visual command, these are not deleted, as they are needed to render the text properly evert frame.
			visual_command_index++;
			if (visual_command_index < visual_command_length){
				visual_command_data = _current_commands[visual_command_index];
			}
			
			//If configuration has to be set to the initial asterisk, do not run more commands to apply the current ones, the rest will be executed when the text needs to be drawn in their given time.
			if (_is_initial_asterisk){
				break;
			}
		}
		
		//------------------------------------------------------------------------------------------------------------------------------------------------------------
		//SETTING EFFECT CONFIGURATION
		//------------------------------------------------------------------------------------------------------------------------------------------------------------
		//This is the part effects being set by the command take place and are being calculated to display the text with various effects.
		
		draw_effect_x = 0;
		draw_effect_y = 0;
		
		//Positional effects, they offset the letters in different ways to give style to the dialog.
		switch (draw_position_effect){
			case EFFECT_TYPE.OSCILLATE:
				var _timer = 6*(effect_timer + _i);
				
				draw_effect_x = draw_position_effect_value*dcos(_timer);
				draw_effect_y = draw_position_effect_value*dsin(_timer);
			break;
			case EFFECT_TYPE.TWITCH: //Twitch effect is like a shake effect but for just 1 frame, with a chance of 1/1000 to happen.
				if (irandom(1000) != 500){
					break;
				}
			case EFFECT_TYPE.SHAKE:
				draw_effect_x = irandom_range(-draw_position_effect_value, draw_position_effect_value);
				draw_effect_y = irandom_range(-draw_position_effect_value, draw_position_effect_value);
			break;
		}
		
		//Color effects, they give special colors to the text that changes, it overrides any flat color that has been set, but it doesn't reset the color once removed, it keeps the last set color.
		switch (draw_color_effect){
			case EFFECT_TYPE.RAINBOW:
				draw_color_effect_value = make_color_hsv((effect_timer + _i*draw_color_effect_offset)%256, 255, 255);
			break;
		}
		
		return _is_initial_asterisk; //Return if the initial asterisk needs to be displayed with the coloring and effects.
	}
	
	//If there are any commands executing at the beggining, they get executed, if no [wait] command changes the text_timer, then it sets it to 1 to begin the dialog logic.
	if (execute_action_commands() == 0){
		text_timer = 1;
	}
}