/// @description Variable method runs if set

if (!is_undefined(on_destroy)){
	on_destroy()
}

//Clean up the surface.
if (surface_exists(surface)){
	surface_free(surface)
}