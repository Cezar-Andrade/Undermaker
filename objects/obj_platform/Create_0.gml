/// @description Initial variables

update = undefined
on_destroy = undefined
when_colliding = undefined //Will do nothing until it's defined, it triggers when the player collides with it.
has_collided = false

surface = -1
length = 100
conveyor_speed = 1

type = PLATFORM_TYPE.TRAMPOLINE
anim_timer = 0

fragile = {duration_time: 0, respawn_time: 0, state: 0, timer: 0}