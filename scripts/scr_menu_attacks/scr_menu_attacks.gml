function menu_attack(type) constructor{
	switch (type){
		case 1:
			Initial = function(){
				timer = 0;
				bone = Bone(55, 245, 40, 90, 0, 0, 0, [640, 0, 0, 480], "", 1, 0, 0, true, false, 1);
				Finished = false;
			}
			Update = function(){
				timer++;
				bone.y = 245 + abs(50*dsin(6*timer));
				bone.Head.Top.y = bone.y;
				bone.Head.Bottom.y = bone.y;
				if (timer%30 == 0 and (State == "Attacking" or State == "Flee" or State == "DialogResult" or State == "EnemyDialogue")){
					bone.Head.Top.Borrar = true;
					bone.Head.Bottom.Borrar = true;
					instance_destroy(bone);
					Finished = true;
				}
			}
			ForceEnd = function(){
				bone.Head.Top.Borrar = true;
				bone.Head.Bottom.Borrar = true;
				instance_destroy(bone);
			}
		break;
		case 2:
			Initial = function(){
				timer = 0;
				bone1 = Bone(555, 490, 120, 90, 6, 0, 0, [640, 0, 0, 500], "", 1, 0, 0, false, false, 1);
				bone2 = Bone(400, 490, 120, 90, 0, 0, 0, [640, 0, 0, 500], "", 1, 0, 0, false, false, 1);
				bone3 = Bone(240, 490, 120, 90, 6, 0, 0, [640, 0, 0, 500], "", 1, 0, 0, false, false, 1);
				bone4 = Bone(87, 490, 120, 90, 0, 0, 0, [640, 0, 0, 500], "", 1, 0, 0, false, false, 1);
				Finished = false;
			}
			Update = function(){
				timer++;
				if (State == "Attacking" or State == "Flee" or State == "DialogResult" or State == "EnemyDialogue"){
					if (!is_undefined(bone1) and bone1.image_angle%180 == 90){
						bone1.Head.Top.Borrar = true;
						bone1.Head.Bottom.Borrar = true;
						instance_destroy(bone1);
						bone1 = undefined;
					}
					if (!is_undefined(bone2) and bone2.image_angle%180 == 90){
						bone2.Head.Top.Borrar = true;
						bone2.Head.Bottom.Borrar = true;
						instance_destroy(bone2);
						bone2 = undefined;
					}
					if (!is_undefined(bone3) and bone3.image_angle%180 == 90){
						bone3.Head.Top.Borrar = true;
						bone3.Head.Bottom.Borrar = true;
						instance_destroy(bone3);
						bone3 = undefined;
					}
					if (!is_undefined(bone4) and bone4.image_angle%180 == 90){
						bone4.Head.Top.Borrar = true;
						bone4.Head.Bottom.Borrar = true;
						instance_destroy(bone4);
						bone4 = undefined;
					}
					if (is_undefined(bone1) and is_undefined(bone2) and is_undefined(bone3) and is_undefined(bone4)){
						Finished = true;
					}
				}else if (timer == 15){
					bone2.Vel.rot = 6;
					bone4.Vel.rot = 6;
				}
			}
			ForceEnd = function(){
				if (!is_undefined(bone1)){
					bone1.Head.Top.Borrar = true;
					bone1.Head.Bottom.Borrar = true;
					instance_destroy(bone1);
				}
				if (!is_undefined(bone2)){
					bone2.Head.Top.Borrar = true;
					bone2.Head.Bottom.Borrar = true;
					instance_destroy(bone2);
				}
				if (!is_undefined(bone3)){
					bone3.Head.Top.Borrar = true;
					bone3.Head.Bottom.Borrar = true;
					instance_destroy(bone3);
				}
				if (!is_undefined(bone4)){
					bone4.Head.Top.Borrar = true;
					bone4.Head.Bottom.Borrar = true;
					instance_destroy(bone4);
				}
			}
		break;
		case 3:
			Initial = function(){
				timer = 0;
				bone = Bone(55, 245, 40, 90, 0, 0, 0, [640, 0, 0, 480], "", 1, 0, 0, true, false, 1);
				bone1 = Bone(555, 490, 120, 90, 6, 0, 0, [640, 0, 0, 500], "", 1, 0, 0, false, false, 1);
				bone2 = Bone(400, 490, 120, 90, 0, 0, 0, [640, 0, 0, 500], "", 1, 0, 0, false, false, 1);
				bone3 = Bone(240, 490, 120, 90, 6, 0, 0, [640, 0, 0, 500], "", 1, 0, 0, false, false, 1);
				bone4 = Bone(87, 490, 120, 90, 0, 0, 0, [640, 0, 0, 500], "", 1, 0, 0, false, false, 1);
				Finished = false;
			}
			Update = function(){
				timer++;
				if (!is_undefined(bone)){
					bone.y = 245 + abs(50*dsin(6*timer));
					bone.Head.Top.y = bone.y;
					bone.Head.Bottom.y = bone.y;
				}
				if (State == "Attacking" or State == "Flee" or State == "DialogResult" or State == "EnemyDialogue"){
					if (timer%30 == 0){
						bone.Head.Top.Borrar = true;
						bone.Head.Bottom.Borrar = true;
						instance_destroy(bone);
						bone = undefined;
					}
					if (!is_undefined(bone1) and bone1.image_angle%180 == 90){
						bone1.Head.Top.Borrar = true;
						bone1.Head.Bottom.Borrar = true;
						instance_destroy(bone1);
						bone1 = undefined;
					}
					if (!is_undefined(bone2) and bone2.image_angle%180 == 90){
						bone2.Head.Top.Borrar = true;
						bone2.Head.Bottom.Borrar = true;
						instance_destroy(bone2);
						bone2 = undefined;
					}
					if (!is_undefined(bone3) and bone3.image_angle%180 == 90){
						bone3.Head.Top.Borrar = true;
						bone3.Head.Bottom.Borrar = true;
						instance_destroy(bone3);
						bone3 = undefined;
					}
					if (!is_undefined(bone4) and bone4.image_angle%180 == 90){
						bone4.Head.Top.Borrar = true;
						bone4.Head.Bottom.Borrar = true;
						instance_destroy(bone4);
						bone4 = undefined;
					}
					if (is_undefined(bone) and is_undefined(bone1) and is_undefined(bone2) and is_undefined(bone3) and is_undefined(bone4)){
						Finished = true;
					}
				}else if (timer == 15){
					bone2.Vel.rot = 6;
					bone4.Vel.rot = 6;
				}
			}
			ForceEnd = function(){
				if (!is_undefined(bone)){
					bone.Head.Top.Borrar = true;
					bone.Head.Bottom.Borrar = true;
					instance_destroy(bone);
				}
				if (!is_undefined(bone1)){
					bone1.Head.Top.Borrar = true;
					bone1.Head.Bottom.Borrar = true;
					instance_destroy(bone1);
				}
				if (!is_undefined(bone2)){
					bone2.Head.Top.Borrar = true;
					bone2.Head.Bottom.Borrar = true;
					instance_destroy(bone2);
				}
				if (!is_undefined(bone3)){
					bone3.Head.Top.Borrar = true;
					bone3.Head.Bottom.Borrar = true;
					instance_destroy(bone3);
				}
				if (!is_undefined(bone4)){
					bone4.Head.Top.Borrar = true;
					bone4.Head.Bottom.Borrar = true;
					instance_destroy(bone4);
				}
			}
		break;
	}
}