/// @description After update event

if (!is_undefined(after_update)){
	after_update()
}

general_entity_update() //Update of the entity for colliding.

if (depth_ordering){
	depth = -y
}