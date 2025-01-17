/// @description Game over displaying

draw_self();
/*
if (State == "GameOver"){
	if (!Dunked){
		anim++;
		var alpha = clamp(timer - 60, 0, 30)/30 + (state != "");
		var alpha2 = clamp(timer - 120, 0, 30)/30 + (state != "") - (state == "Continue")*min(timer + 200, 60)/60;
		var color = make_color_rgb(255 - 128*alpha2, 255 - 128*alpha2, 255 - 128*alpha2);
		draw_sprite_ext(spr_GAMEOVER, 0, 0, -(16*anim)%40, 2, 2, 0, c_white, alpha);
		draw_sprite_ext(spr_GAMEOVER, 0, 0, 480 - (16*anim)%40, 2, 2, 0, c_white, alpha);
		draw_sprite_ext(spr_GAMEOVER, 1, 0, 0, 2, 2, 0, c_white, 1);
		shader_set(shd_outline);
		shader_set_uniform_f(uAlpha, alpha2);
		shader_set_uniform_f(uPixelX, texelX);
		shader_set_uniform_f(uPixelY, texelY);
		draw_sprite_ext(spr_chara_dies, (anim/3)%3, 320, 300, 2, 2, 0, color, alpha);
		shader_reset();
		draw_sprite_ext(spr_GAMEOVER, 2, 0, 0, 2, 2, 0, c_white, (state == "Give up") + (clamp(timer - 60, 0, 60) + (state == "Continue")*max(-timer - 140, 0))/60);
		draw_set_alpha(alpha2);
		draw_set_font(fn_big_8bit);
		var pink = make_color_rgb(255,187,212);
		draw_set_color(c_white);
		if (timer >= 165 and select == 0){
			draw_set_color(pink);
		}
		draw_text(140, 380, "Continue");
		draw_set_color(c_white);
		if (timer >= 165 and select == 1){
			draw_set_color(pink);
		}
		draw_text(400, 380, "Give up");
		if (state == "Give up"){
			draw_set_alpha(min(timer + 200, 60)/60);
			draw_set_color(c_black);
			draw_rectangle(-10,-10,650,490,false);
			draw_set_color(c_white);
		}
		draw_set_alpha(1);
		if (timer == 110){
			GameOverText.Draw();
		}
	}else{
		var alpha = clamp(timer - 170, 0, 30)/30 + (state != "")*(1 - min(timer + 200, 60)/60);
		draw_sprite_ext(spr_GAMEOVER, 3, 0, 0, 2, 2, 0, c_white, clamp(timer - 90, 0, 60)/60 + (state != "")*(1 - min(timer + 200, 60)/60));
		draw_set_alpha(alpha);
		draw_set_font(fn_big_8bit);
		var pink = make_color_rgb(255,187,212);
		draw_set_color(c_white);
		if (timer >= 215 and select == 0){
			draw_set_color(pink);
		}
		draw_text(140, 380, "Continue");
		draw_set_color(c_white);
		if (timer >= 215 and select == 1){
			draw_set_color(pink);
		}
		draw_text(400, 380, "Give up");
		draw_set_alpha(1);
		if (timer == 160){
			GameOverText.Draw();
		}
	}
	for (var i=0;i < array_length(Shards);i++){
		draw_sprite_ext(spr_heartshard, Shards[i].frame, Shards[i].xpos, Shards[i].ypos, 1, 1, 0, image_blend, 1);
	}
}