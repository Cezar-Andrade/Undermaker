/// @description Update event

if (!is_undefined(update)){
	update();
}

//Collision goes here.

if (depth_ordering){
	depth = -y;
}