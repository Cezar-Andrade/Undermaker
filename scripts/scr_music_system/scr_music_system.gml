function MusicSystem() constructor{
	music_instance = undefined
	change_music_to = undefined
	ignore = false
	
	step = function(){
		if (audio_exists(music_instance) and audio_is_paused(music_instance)){
			resume_music(1000)
		}
		
		if (ignore){
			ignore = false
			
			return
		}
		
		set_music(change_music_to)
		
		change_music_to = undefined
	}
	
	set_music = function(_music=undefined){
		var _undefined = is_undefined(_music)
		
		if (!_undefined){
			if (music_instance != undefined and audio_get_name(_music) == audio_get_name(music_instance)){
				return
			}
			
			if (audio_exists(music_instance) and audio_is_playing(music_instance)){
				audio_stop_sound(music_instance)
				
				music_instance = undefined
			}
		
			if (_music != -1){
				music_instance = audio_play_sound(_music, 100, true)
			}
		}
	}
	
	pause_music = function(){
		if (audio_exists(music_instance) and !audio_is_paused(music_instance)){
			set_gain(0, 0)
			audio_pause_sound(music_instance)
		}
	}
	
	stop_music = function(){
		if (audio_exists(music_instance) and audio_is_playing(music_instance)){
			audio_stop_sound(music_instance)
			
			music_instance = undefined
		}
	}
	
	set_gain = function(_gain=0, _time=0){
		if (audio_exists(music_instance) and audio_is_playing(music_instance)){
			audio_sound_gain(music_instance, _gain, _time)
		}
	}
	
	resume_music = function(_time=0){
		if (audio_exists(music_instance) and audio_is_paused(music_instance)){
			audio_resume_sound(music_instance)
			set_gain(1, _time)
		}
	}
	
	schedule_music_change_to = function(_music=undefined){
		change_music_to = _music
	}
	
	is_playing = function(){
		return audio_is_playing(music_instance)
	}
	
	ignore_next_update = function(){
		ignore = true
	}
}