/// @description Variable method runs if set

if (!is_undefined(on_destroy)){
	on_destroy()
}

if (surface_exists(surface)){
	surface_free(surface)
}