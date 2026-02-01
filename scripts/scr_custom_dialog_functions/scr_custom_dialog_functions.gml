function custom_functions(_name){
	switch (_name){
		case "HurtWiltedVineItem":
			audio_play_sound(snd_player_hurt, 100, false)
			global.player.hp--
		break
	}
}