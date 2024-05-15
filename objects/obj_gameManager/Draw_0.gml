draw_set_font(fnt_arial)
draw_text(0, 0, "Control type: " + string(control_type));
draw_text(0, 20, "Up: " + string(up_button))
draw_text(0, 40, "Left: " + string(left_button))
draw_text(0, 60, "Down: " + string(down_button))
draw_text(0, 80, "Right: " + string(right_button))
draw_text(0, 100, "Z: " + string(confirm_hold_button))
draw_text(0, 120, "X: " + string(cancel_hold_button))
draw_text(0, 140, "C: " + string(menu_hold_button))
draw_text(0, 160, "Escape: " + string(escape_hold_button))
if (control_type == CONTROL_TYPE.MAPPING_CONTROLLER){
	switch (controller_mapping_state){
		case MAPPING.WAITING_ENTER:
			draw_text(100, 140, "Controlador detectado.\nPresiona Enter para empezar\nel mapeado.");
		break;
		case MAPPING.GET_CONFIRM:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar Z.");
		break;
		case MAPPING.GET_CANCEL:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar X.");
		break;
		case MAPPING.GET_MENU:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar C.");
		break;
	}
}