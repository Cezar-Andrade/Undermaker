enum BORDER{
	NONE = 0,
	BATTLE = 1,
	SNOW_FOREST = 2,
	SNOW_FOREST_2 = 3
}

global.room_borders = {
	rm_battle: BORDER.BATTLE,
	rm_overworld_1_grass_land: BORDER.SNOW_FOREST_2,
	rm_overworld_2_the_void: BORDER.SNOW_FOREST,
	rm_overworld_4_training_area: BORDER.SNOW_FOREST_2
}