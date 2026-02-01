/// @description Arena resizing step

box_size.x = round(box_size.x)
box_size.y = round(box_size.y)

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