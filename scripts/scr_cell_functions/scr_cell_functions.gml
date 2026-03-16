
enum CELL{
	CALL_GASTER,
	DIMENTIONAL_BOX_A,
	DIMENTIONAL_BOX_B,
	LOAD_GAME
}

function cell_use(_cell_index){
	var _cell_option = global.player.cell_options[_cell_index]
	var _message = ""
	
	switch (_cell_option){
		case CELL.CALL_GASTER:{
			_message = global.dialogues.cell.gaster_call
		break}
		case CELL.DIMENTIONAL_BOX_A:{
			start_box_menu(0)
		return}
		case CELL.DIMENTIONAL_BOX_B:{
			start_box_menu(1)
		return}
		case CELL.LOAD_GAME:{
			if (does_save_file_0_exist()){
				perform_game_load()
			
				audio_play_sound(snd_game_saved, 100, false)
			}
		return}
	}
	
	audio_play_sound(snd_cell_ring, 100, false)
	
	return _message
}