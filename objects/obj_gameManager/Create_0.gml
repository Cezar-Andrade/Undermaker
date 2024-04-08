/*
1. Loading and saving data
2. Room changing between battle and overworld
3. Background art in fullscreen - DONE, there's just 1 border for now, but it works.
*/

border_id = 0; //There's just 1 border as of now, so this won't do anything yet.

// Arrays of width and height of available resolutions that are integer multiples of 640 x 480.
resolutions_width = [];
resolutions_height = [];
resolution_active = 0;

// enable borderless window fullscreen mode.
window_enable_borderless_fullscreen(true);

var display_width = display_get_width();
var display_height = display_get_height();

for (var i = 1; GAME_WIDTH * i < display_width && GAME_HEIGHT * i < display_height; ++i) {
    array_push(resolutions_width, GAME_WIDTH * i);
	array_push(resolutions_height, GAME_HEIGHT * i);
}

array_push(resolutions_width, display_width);
array_push(resolutions_height, display_height);