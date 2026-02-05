function drop_wilted_vine_item(){
	audio_play_sound(snd_player_hurt, 100, false)
	global.player.hp--
}