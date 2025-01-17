
enum CELL{
	CALL_GASTER,
	DIMENTIONAL_BOX_A,
	DIMENTIONAL_BOX_B,
	SAVE_GAME
}

function load_ui_texts(_path){
	var _file = file_text_open_read(working_directory + "/" + _path);
	var _text = "";
	
	while (!file_text_eof(_file)){
		_text += file_text_read_string(_file);
		file_text_readln(_file);
	}
	file_text_close(_file);
	
	global.UI_texts = json_parse(_text);
}

function cell_use(_cell_index){
	var _cell_option = global.player.cell_options[_cell_index];
	var _message = "";
	
	switch (_cell_option){
		case CELL.CALL_GASTER:
			_message = "The man who speaks with the hands is not available right now...";
		break;
		case CELL.DIMENTIONAL_BOX_A:
			start_box_menu(0);
		return;
		case CELL.DIMENTIONAL_BOX_B:
			start_box_menu(1);
		return;
		case CELL.SAVE_GAME:
			start_save_menu();
			
			audio_play_sound(snd_menu_selecting, 100, false);
		return;
	}
	
	audio_play_sound(snd_cell_ring, 100, false);
	
	return _message;
}