/// @description Most likely this will be deleted and the game will handle all the logic

State = "EncounterStarting";
canFlee = 0;
Page = 1; //Yeah this is for the item interface, literally nothing else

FleeType = new Flee("");
Selecting = [0, 0, 0];
CurrentAttacks = [];
KRcolor = make_color_rgb(232, 0, 255);
Stats = {x: 70, y: 415, HealthSize: 110, aux: 0, timer: 0};
BtOrder = ["MERCY", "ITEM", "ACT", "FIGHT"];
musica = -1;
musica2 = -1;
DIE = false;
CurrentMenuAttack = -1;
Shake = [0, 0];