function DialogTree() constructor{
    current = 0;
	counter = [0,0,0,0];
    dialogs = [{ids:[0,0,0,0,0,0,0,0]}];
	
    //The first struct has no content cause it's the start.
    create_dialog = function(_text){
        push(dialogs, {content:_text, ids:[0,0,0,0,0,0,0,0]});
        return (array_lenght(dialogs) - 1);
    }
	
    connect = function(_dialog_id, _atk_id, _act_id, _spare_id, _default_id, _special_atk_id=0, _special_act_id=0, _special_spare_id=0, _special_timed_act_id=0){
        dialogs[_dialog_id].ids = [_atk_id, _act_id, _spare_id, _default_id, _special_atk_id, _special_act_id, _special_spare_id, _special_timed_act_id];
    }
	
    reset = function(){
        current = 0;
    } //Yes it's needed, we could do it by just put current to 0, but... Makes more sense with the function name... Might remove it xd
	
    get_next_dialog = function(_action){
		if (current == -1){
			return "[next]"; //No more dialogs, a path's end has been reached at this point.
		}
		
		counter[3]--;
		if (_action <= 2){
			counter[_action]++;
			if (_action == 2){
				counter[3] = 2;
			}
		}
		
		if (dialogs[current].ids[4] != 0 and _action == 0 and counter[0] >= 6){
			current = dialogs[current].ids[4];
		}else if (dialogs[current].ids[5] != 0 and (_action == 0 or _action == 2) and counter[1] <= 3 and counter[2] >= 4 and counter[2] > counter[0]){
			current = dialogs[current].ids[5];
		}else if (dialogs[current].ids[6] != 0 and _action == 1 and counter[1] > counter[2] and counter[1] >= 6 and counter[0] <= 1){
			current = dialogs[current].ids[6];
		}else if (dialogs[current].ids[7] != 0 and _action == 0 and counter[3] >= 0){
			current = dialogs[current].ids[7];
		}else if (dialogs[current].ids[_action] != 0){
			current = dialogs[current].ids[_action];
		}else{
			current = -1;
			return "[next]"; //There's just no dialog, you have reached the end and there's no connections anymore, and that's just the end of the dialog tree.
		}
        return dialogs[current].content;
    }
}