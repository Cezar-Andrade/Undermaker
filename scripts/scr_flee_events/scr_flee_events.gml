function flee_event(type) constructor{
	switch(type) {
		case "Special": //or something, idk
		
		break;
		default:
			Initial = function(){
				obj_PlayerH.image_alpha = 0;
				obj_Box.CurrentText.editActText(["* You tried to flee...[w:10]\nBut you realized[w:10], that you suck\fat fleeing XD."], "[font:" + string(int64(fn_big_8bit)) + "][voice:" + string(int64(snd_ui)) + "][xspace:16][yspace:32]");
			}
			Update = function(){
				if (ds_list_size(obj_Box.FlavorText.AllTextData) <= 0) {
					State = "EnemyDialogue";
				}
			}
		break;
	}
}