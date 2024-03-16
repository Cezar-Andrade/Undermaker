/*
1. Loading and saving data
2. Room changing between battle and overworld
3. Background art in fullscreen - DONE, there's just 1 border for now, but it works.
*/

//Background Borders stuff start here
display_set_gui_size(640, 480);
application_surface_draw_enable(false);
borderID = 0; //There's just 1 border as of now, so this won't do anything yet