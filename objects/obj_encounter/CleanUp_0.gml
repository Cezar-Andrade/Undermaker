var length = array_length(Enemies);
for (var i=0;i<length;i++){
	Enemies[0].Dialog.Delete();
	delete Enemies[0];
	array_delete(Enemies, 0, 1);
}