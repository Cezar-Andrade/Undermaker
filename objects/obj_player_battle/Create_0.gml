/// @description Variable declaration

x = 320;
y = 240;
movement_speed = 2;
mode = -1;
invulnerability_frames = 0;

gravity_data = {Dir: "Down", Jump: 0, MaxJump: 40, CannotStopJump: false, CannotJump: false, OnPlatform: false, ignore_first_frame: false, Push: {val: 0, count: 0}, Plat: {x: 0, y: 0, vel: {x: 0, y: 0}}, PrevPlat: {found: false, plat: undefined}};

set_mode = function(_mode, _args=undefined){
	mode = _mode;
	switch (mode){
		case HEART_MODE.NORMAL:
			image_blend = c_red;
			image_angle = 0;
		break;
		case HEART_MODE.GRAVITY:
			image_blend = make_color_rgb(0,60,255);
		break;
	}
}

set_mode(HEART_MODE.NORMAL);