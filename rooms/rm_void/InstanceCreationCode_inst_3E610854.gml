sprite_index = spr_player_heart
image_blend = c_red

var _yes_dialog = function(){
	var _dialogs = [
		"[no_voice]Then let us begin...",
		"Oh! My most sincere apologies[w:10], I have not introduced myself properly.",
		"You may call me...",
		"[font:" + string(int64(fnt_determination_mono_1)) + "][text_speed:12]W.D. Gaster"
	]
	for (var _i=0; _i<array_length(_dialogs); _i++){
		_dialogs[_i] = string_upper(_dialogs[_i])
	}
	overworld_dialog(_dialogs,, true)
}

var _no_dialog = function(){
	var _dialogs = [
		"[no_voice]I am know by many names.[w:20]\nThe man that speaks with the hands...",
		"The one that fell in his own creation...[w:20]\nThe man in the shadows...",
		"But please, you may call me...",
		"[font:" + string(int64(fnt_determination_mono_1)) + "][text_speed:12] W.D. Gaster"
	]
	for (var _i=0; _i<array_length(_dialogs); _i++){
		_dialogs[_i] = string_upper(_dialogs[_i])
	}
	overworld_dialog(_dialogs,, true)
}

create_choice_option(CHOICE_DIRECTION.LEFT, 80, "Proceed", _yes_dialog)
create_choice_option(CHOICE_DIRECTION.RIGHT, 80, "Who are you?", _no_dialog)

with (obj_game){
	state = GAME_STATE.EVENT
	timer = 0
	
	event_update = function(){
		timer++
		
		if (timer == 120){
			var _dialogs = [
				"[no_voice]Greetings human...[w:20] I must thank you for all this.",
				"Without you I would not have escaped that dark prison which I would like to call \"The Void\".",
				"It was quite the interesting experience of a failed experiment of mine.",
				"But I have to say that without it[w:10], I would have not known the truth of this world.",
				"This world is everything but real.",
				"It is just a machine simulating our reality[w:10], thousand of instructions executing called \"code\".",
				"Every time you reset[w:10], you are just going back to a previous state of this world.",
				"You may see this as creating another timeline in the universe.",
				"But in reality[w:10], you are just overwritting the existing one.",
				"I[w:10], unlike the rest of everyone who live inside this world[w:10], was vanished into The Void.",
				"And[w:10], while I was trapped in there[w:10], none of the modifications you made in this world could affect me.",
				"I know all the things you did...[w:20] From The Void I was able to watch everyone in this world.",
				"And how you manipulated them to achieve \"an ending\".",
				"But you are just not satisfied with the outcome[w:10], why else would you do many genocides and pacifisms?",
				"During all this time I was watching you[w:10], I was able to make a plan to use YOU to escape The Void.",
				"By changing the \"code\" of this world that I could access from The Void, quite similar to a god.",
				"You may say The Void is like...[w:20] a layer in between the \"code\" and its representation of it.",
				"I would have never expected that this would lead me to absorb the six human souls.",
				"Now your determination is not strong enough to manipulate the world as you are used to.",
				"I am now the one in control.[w:20] You will soon be part of my new grand experiment.",
				"Where I will exploit this world to their limits[w:10], to reach a bigger world.",
				"The one that is currently running this world that you have played a lot with.",
				"And for that I am going to need your soul to become a true god and be able to change the world as I wish.",
				"[progress_mode:none]Do you have any question before proceding?[w:10][func:" + string(start_choice_plus) + ",320,150,true]"
			]
			for (var _i=0; _i<array_length(_dialogs); _i++){
				_dialogs[_i] = string_upper(_dialogs[_i])
			}
			overworld_dialog(_dialogs,, true)
		}
	}
	
	event_end_condition = function(){
		return false
	}
}