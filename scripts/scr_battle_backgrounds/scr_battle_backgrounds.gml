enum BATTLE_BACKGROUND{
	NO_BG,
	SQUARE_GRID,
	MOVING_SQUARE_GRID
}

function BattleBackground(_name, _depth=500){
	var _renderer = instance_create_depth(0, 0, _depth, obj_renderer)
	with (_renderer){
		timer = 0
	
		switch (_name){
			case BATTLE_BACKGROUND.SQUARE_GRID:{
				draw = function(){
					draw_set_color(c_green)
					for (var _i=0; _i<6; _i++){
						for (var _j=0; _j<2; _j++){
							draw_rectangle(50 + 90*_i, 50 + 90*_j, 138 + 90*_i, 138 + 90*_j, true)
						}
					}
					draw_set_color(c_white)
				}
			break}
			case BATTLE_BACKGROUND.MOVING_SQUARE_GRID:{
				step = function(){
					timer++
				}
			
				draw = function(){
					draw_set_color(c_green)
					for (var _i=0; _i<6; _i++){
						for (var _j=0; _j<2; _j++){
							draw_rectangle(50 + 90*_i, 50 + 90*_j - 30*dsin(timer + 45*_i), 138 + 90*_i, 138 + 90*_j - 30*dsin(timer + 45*_i), true)
						}
					}
					draw_set_color(c_white)
				}
			break}
			default:{ //BATTLE_BACKGROUND.NO_BG //No background
				//Nothing
			break}
		}
	}
	
	return _renderer
}
