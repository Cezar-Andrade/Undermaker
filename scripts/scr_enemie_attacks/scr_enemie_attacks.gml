enum ENEMY_ATTACK{
	SPARE,
	MAD_DUMMY_1,
	MAD_DUMMY_2
}

function enemy_attack(_attack_name, _position) constructor{
	timer = 0 //Every attack contains a timer for you to do stuff, if you don't need it ignore it, if you plan to design your attacks without a timer, might as well remove it, I do not recommend it tho.
	attack_done = false //A variable to read when the attack is flagged as finished and therefor must end the enemy attack state.
	cleanup = undefined //Not all attacks must have a cleanup, but it can be added.
	
	switch (_attack_name){
		case ENEMY_ATTACK.MAD_DUMMY_1: {
			battle_box_resize(130, 130)
			timer -= 15*_position
			
			update = function(){
				timer++
				
				if (timer%30 == 10){
					spawn_bullet(spr_circle_bullet, 0, 0, irandom(359), 300)
				}
				
				if (timer > 300){
					attack_done = true
				}
			}
			
			draw = function(){
			}
		break}
		case ENEMY_ATTACK.MAD_DUMMY_2: {
			battle_box_resize(130, 130)
			timer -= 15*_position
			direction = 0
			
			update = function(){
				timer++
				
				if (timer%30 == 10){
					spawn_bullet(spr_circle_bullet, 0, -55 + irandom(110), direction, 300)
					direction = (direction + 180)%360
				}
				
				if (timer > 300){
					attack_done = true
				}
			}
			
			draw = function(){
			}
		break}
		case ENEMY_ATTACK.SPARE: { //Yeah this is just a Spare Attack
			update = function(){
				timer++
				
				if (timer > 60){
					attack_done = true
				}
			}
			
			draw = function(){
				//Nothing
			}
		break}
	}
}