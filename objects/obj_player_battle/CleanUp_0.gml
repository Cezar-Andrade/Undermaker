/// @description Removal of instance reference on global variable and trail layer cleanup

//If player is deleted either you created multiple for an attack, delete the instance reference and layer trail resources
layer_destroy(layer_trail)
remove_instance_reference(id)
