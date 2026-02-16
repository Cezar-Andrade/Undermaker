enum ENEMY_ATTACK{
	SPARE,
	MAD_DUMMY_1,
	MAD_DUMMY_2,
	PLATFORM_1,
	PLATFORM_2,
	PLATFORM_3
}

function enemy_attack(_attack_name, _position) constructor{
	timer = 0 //Every attack contains a timer for you to do stuff, if you don't need it ignore it, if you plan to design your attacks without a timer, might as well remove it, I do not recommend it tho.
	attack_done = false //A variable to read when the attack is flagged as finished and therefor must end the enemy attack state.
	draw = undefined
	cleanup = undefined
	
	switch (_attack_name){
		case ENEMY_ATTACK.PLATFORM_1: {
			battle_resize_box(300, 300, true)
			spawn_platform(0, -110, 180,,, PLATFORM_TYPE.STICKY, 0, 120)
			spawn_platform(-40, -40, -135,,, PLATFORM_TYPE.STICKY, 60, 120, false)
			spawn_platform(-100, -100, -160,,, PLATFORM_TYPE.STICKY, 60, 120)
			spawn_platform(-110, 0, -90,,, PLATFORM_TYPE.STICKY, 0, 120)
			spawn_platform(-40, 40, -45,,, PLATFORM_TYPE.STICKY, 60, 120, false)
			spawn_platform(-100, 100, -70,,, PLATFORM_TYPE.STICKY, 60, 120)
			spawn_platform(0, 110, 0,,, PLATFORM_TYPE.STICKY, 0, 120)
			spawn_platform(40, 40, 45,,, PLATFORM_TYPE.STICKY, 60, 120, false)
			spawn_platform(100, 100, 20,,, PLATFORM_TYPE.STICKY, 60, 120)
			spawn_platform(110, 0, 90,,, PLATFORM_TYPE.STICKY, 0, 120)
			spawn_platform(40, -40, 135,,, PLATFORM_TYPE.STICKY, 60, 120, false)
			spawn_platform(100, -100, 110,,, PLATFORM_TYPE.STICKY, 60, 120)
			
			update = function(){
				if (keyboard_check_pressed(ord("1"))){
					set_soul_mode(SOUL_MODE.NORMAL)
				}
				if (keyboard_check_pressed(ord("2"))){
					set_soul_mode(SOUL_MODE.GRAVITY)
				}
				if (keyboard_check_pressed(ord("3"))){
					set_soul_mode(SOUL_MODE.GRAVITY, {orange_mode: true})
				}
				if (keyboard_check_pressed(ord("I"))){
					set_soul_gravity(GRAVITY_SOUL.UP)
				}
				if (keyboard_check_pressed(ord("J"))){
					set_soul_gravity(GRAVITY_SOUL.LEFT)
				}
				if (keyboard_check_pressed(ord("K"))){
					set_soul_gravity() //GRAVITY_SOUL.DOWN
				}
				if (keyboard_check_pressed(ord("L"))){
					set_soul_gravity(GRAVITY_SOUL.RIGHT)
				}
			}
		break}
		case ENEMY_ATTACK.PLATFORM_2: {
			//TODO
		break}
		case ENEMY_ATTACK.PLATFORM_3: {
			
		break}
		case ENEMY_ATTACK.MAD_DUMMY_1: {
			battle_resize_box(130, 130)
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
		break}
		case ENEMY_ATTACK.MAD_DUMMY_2: {
			battle_resize_box(130, 130)
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
		break}
		case ENEMY_ATTACK.SPARE: { //Yeah this is just a Spare Attack
			update = function(){
				timer++
				
				if (timer > 60){
					attack_done = true
				}
			}
		break}
	}
}