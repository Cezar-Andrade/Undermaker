/// @description Bullet handling

if (other.can_damage and image_alpha == 1 and invulnerability_frames <= 0){
	if ((other.type == BULLET_TYPE.CYAN and (xprevious != x or yprevious != y)) or (other.type == BULLET_TYPE.ORANGE and xprevious == x and yprevious == y) or (other.type != BULLET_TYPE.CYAN and other.type != BULLET_TYPE.ORANGE)){
		global.player.hp = max(min(global.player.hp - other.damage, global.player.max_hp), (obj_game.battle_state != BATTLE_STATE.ENEMY_ATTACK))
		
		if (global.player.status_effect.type == PLAYER_STATUS_EFFECT.KARMIC_RETRIBUTION){
			global.player.status_effect.value = min(global.player.status_effect.value + other.karma, global.player.hp - 1, 40)
			other.karma = min(other.karma, 1) //There are more steps to karmic retribution but I'm doing it the simple way really.
		}
		
		if (other.type == BULLET_TYPE.GREEN){
			audio_play_sound(snd_player_heal, 0, false)
		}else{
			audio_play_sound(snd_player_hurt, 0, false)
		}
		
		invulnerability_frames = global.player.invulnerability_frames
	}
}