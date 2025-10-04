/// @description Initial variables

//Do use the functions to spawn bullets as there are variables set in there that are not set here and it will cause errors if you don't set them yourself manually, handle with care.

type = BULLET_TYPE.WHITE;
can_damage = true;
karma = 5; //Used only for karmic retribution player status effect, will do nothing if not in that status effect.
persistent = false; //This plays with the persistency of the bullet between rooms too yes but the system uses it for deleting the bullets in the proper time.