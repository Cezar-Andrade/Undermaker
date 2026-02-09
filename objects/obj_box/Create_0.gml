/// @description Variable declaration

width = 565
height = 130
x = 320
y = 390
resize_speed = 20
movement_speed = 10
box_size = {x: 565, y: 130}
box_position = {x: 320, y: 390}
box_center_offset = {x: 0, y: -5 - round(height)/2}
box_polygon_points = {
	inside: [x - round(width)/2, y - 5, x + round(width)/2, y - 5, x + round(width)/2, y - round(height) - 5, x - round(width)/2, y - round(height) - 5],
	outside: [],
	direction: []
}
box_default_polygons = true
box_background_color = c_black