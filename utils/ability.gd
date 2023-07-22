class_name Ability
extends Weapon

var need_shoot = false

func set_position(initial_position:Vector2):
	_shooting_behavior.initial_position = initial_position

func _physics_process(delta):
	._physics_process(delta)

	_current_cooldown = max(_current_cooldown - Utils.physics_one(delta), 0)

func shoot():
	if !should_shoot():
		return

	_shooting_behavior.shoot(current_stats.max_range)
	
	need_shoot = false
	_current_cooldown = current_stats.cooldown

func should_shoot():
	return need_shoot && _current_cooldown == 0
