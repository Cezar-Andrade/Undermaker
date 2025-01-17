/// @description Arena resizing step

switch (obj_game.battle_state){
	case BATTLE_STATE.ENEMY_DIALOG: case BATTLE_STATE.ENEMY_ATTACK:
		box_size.x = round(box_size.x)
		box_size.y = round(box_size.y)
		if (width > box_size.x){
			width = max(width - 40, box_size.x);
		}
		if (width < box_size.x){
			width = min(width + 40, box_size.x);
		}
		if (height > box_size.y){
			height = max(height - 40, box_size.y);
		}
		if (height < box_size.y){
			height = min(height + 40, box_size.y);
		}
	break;
	default:
		if (width > 565){
			width = max(width - 40, 565);
		}
		if (width < 565){
			width = min(width + 40, 565);
		}
		if (height > 130){
			height = max(height - 40, 130);
		}
		if (height < 130){
			height = min(height + 40, 130);
		}
		if (x > 320){
			x = min(x - 20, 320);
		}
		if (x < 320){
			x = min(x + 20, 320);
		}
		if (y > 390){
			y = min(y - 20, 390);
		}
		if (y < 390){
			y = min(y + 20, 390);
		}
	break;
}