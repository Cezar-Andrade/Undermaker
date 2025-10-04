enum BULLET_TYPE{
	WHITE,
	ORANGE,
	CYAN,
	GREEN
}

function spawn_bullet(_sprite, _x, _y, _depth=0, _damage=3, _update=undefined, _draw_begin=undefined, _draw=draw_self, _draw_end=undefined, _destroy=undefined){
	var _bullet = instance_create_depth(_x + obj_box.x, _y + obj_box.y - obj_box.height/2, _depth, obj_bullet);
	_bullet.sprite_index = _sprite;
	_bullet.update = _update;
	_bullet.draw_begin = _draw_begin;
	_bullet.draw = _draw;
	_bullet.draw_end = _draw_end;
	_bullet.on_destroy = _destroy;
	_bullet.damage = _damage;
	
	array_push(obj_game.battle_bullets, _bullet);
	
	return _bullet;
}