/// @description Increases the game time.

global.seconds++;

if (global.seconds >= 60){
	global.seconds -= 60;
	global.minutes++;
}

alarm[1] = 60;