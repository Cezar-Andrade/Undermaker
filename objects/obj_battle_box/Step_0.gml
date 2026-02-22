/// @description Arena resizing step

box_size.x = round(box_size.x)
box_size.y = round(box_size.y)

var _angle_difference = angle_difference(box_rotation, image_angle)

if (_angle_difference > 0){
	image_angle += min(rotation_speed, _angle_difference)
}
if (_angle_difference < 0){
	image_angle += max(-rotation_speed, _angle_difference)
}

if (width > box_size.x){
	width = max(width - resize_speed, box_size.x)
}
if (width < box_size.x){
	width = min(width + resize_speed, box_size.x)
}

if (height > box_size.y){
	height = max(height - resize_speed, box_size.y)
}
if (height < box_size.y){
	height = min(height + resize_speed, box_size.y)
}

if (x > box_position.x){
	x = max(x - movement_speed, box_position.x)
}
if (x < box_position.x){
	x = min(x + movement_speed, box_position.x)
}

if (y > box_position.y){
	y = max(y - movement_speed, box_position.y)
}
if (y < box_position.y){
	y = min(y + movement_speed, box_position.y)
}

var _defined_points = box_polygon_points.defined
var _inside_points = box_polygon_points.inside
var _outside_points = box_polygon_points.outside

var _length = array_length(_outside_points)
if (_length > 0){
	array_delete(_outside_points, 0, _length)
}
_length = array_length(_inside_points)
if (_length > 0){
	array_delete(_inside_points, 0, _length)
}

_length = array_length(_defined_points)
if (_length > 0){
	for (var _i = 0; _i < _length; _i++){
		_inside_points[_i] = _defined_points[_i]
	}
}else{
	_inside_points[0] = x - round(width)/2
	_inside_points[1] = y - 5
	_inside_points[2] = x + round(width)/2
	_inside_points[3] = y - 5
	_inside_points[4] = x + round(width)/2
	_inside_points[5] = y - round(height) - 5
	_inside_points[6] = x - round(width)/2
	_inside_points[7] = y - round(height) - 5
	
	_length = 8
}

var _x = x + box_center_offset.x
var _y = y + box_center_offset.y

for (var _i = 0; _i < _length; _i += 2){
	var _px = _inside_points[_i]
	var _py = _inside_points[_i+1]
	
	var _distance = point_distance(_x, _y, _px, _py)
	var _direction = point_direction(_x, _y, _px, _py) + image_angle
	_px = _x + _distance*dcos(_direction)
	_py = _y - _distance*dsin(_direction)
	
	_inside_points[_i] = _px
	_inside_points[_i+1] = _py
}

if (array_length(_outside_points) == 0 and _length > 0){
	var _direction_points = box_polygon_points.direction
	var _length_2 = array_length(_direction_points)
	if (_length_2 > 0){
		array_delete(_direction_points, 0, _length_2)
	}
	
	var _prev_direction = point_direction(_inside_points[_length-2], _inside_points[_length-1], _inside_points[0], _inside_points[1])
	for (var _i = 0; _i < _length; _i += 2) {
		var _p1_x = _inside_points[_i]
		var _p1_y = _inside_points[_i+1]
	
		var _direction = point_direction(_p1_x, _p1_y, _inside_points[(_i + 2)%_length], _inside_points[(_i + 3)%_length])
	
		var _p2_x = _p1_x + 5*dcos(_direction - 90)
		var _p2_y = _p1_y - 5*dsin(_direction - 90)
	
		var _p_1_x = _p1_x + 5*dcos(_prev_direction - 90)
		var _p_1_y = _p1_y - 5*dsin(_prev_direction - 90)
	
		var _delta_x1 = lengthdir_x(1, _prev_direction)
		var _delta_y1 = lengthdir_y(1, _prev_direction)
		var _delta_x2 = lengthdir_x(1, _direction)
		var _delta_y2 = lengthdir_y(1, _direction)
	
		var _determinant = _delta_x1 * _delta_y2 - _delta_y1 * _delta_x2
	
		var _scalar_distance = ((_p2_x - _p_1_x) * _delta_y2 - (_p2_y - _p_1_y) * _delta_x2) / _determinant
		var _p_intersection_x = _p_1_x + _scalar_distance * _delta_x1
		var _p_intersection_y = _p_1_y + _scalar_distance * _delta_y1
	
		_prev_direction = _direction
	
	    array_push(_outside_points, _p_intersection_x, _p_intersection_y)
		array_push(_direction_points, _direction)
	}
}
