draw_set_font(fnt_determination_mono);
/*draw_text(0, 0, "Control type: " + string(control_type));
draw_text(0, 20, "Up: " + string(global.up_hold_button))
draw_text(0, 40, "Left: " + string(global.left_hold_button))
draw_text(0, 60, "Down: " + string(global.down_hold_button))
draw_text(0, 80, "Right: " + string(global.right_hold_button))
draw_text(0, 100, "Z: " + string(global.confirm_hold_button))
draw_text(0, 120, "X: " + string(global.cancel_hold_button))
draw_text(0, 140, "C: " + string(global.menu_hold_button))
draw_text(0, 160, "Escape: " + string(global.escape_hold_button))*/


if (control_type == CONTROL_TYPE.MAPPING_CONTROLLER){
	switch (controller_controller_mapping_state){
		case CONTROLLER_MAPPING.WAITING_ENTER:
			draw_text(100, 140, "Controlador detectado.\nPresiona Enter para empezar\nel mapeado.");
		break;
		case CONTROLLER_MAPPING.GET_CONFIRM:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar Z.");
		break;
		case CONTROLLER_MAPPING.GET_CANCEL:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar X.");
		break;
		case CONTROLLER_MAPPING.GET_MENU:
			draw_text(100, 140, "Presiona el boton del mando\npara asignar C.");
		break;
	}
}