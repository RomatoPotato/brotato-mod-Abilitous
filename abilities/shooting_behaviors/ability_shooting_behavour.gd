extends WeaponShootingBehavior
class_name AbilityShootingBehavior

var initial_position = Vector2.ZERO

func shoot(_distance:float)->void :
	SoundManager.play(Utils.get_rand_element(_parent.current_stats.shooting_sounds), _parent.current_stats.sound_db_mod, 0.2)

	var angle = 0
	var angle_step = deg2rad(360 / _parent.current_stats.nb_projectiles)

	for i in _parent.current_stats.nb_projectiles:
		shoot_projectile(angle)
		angle += angle_step

func shoot_projectile(angle:float)-> void :
	var projectile = WeaponService.spawn_projectile(
		angle,
		_parent.current_stats,
		initial_position,
		Vector2.ZERO,
		false,
		_parent.effects,
		_parent
	)

	emit_signal("projectile_shot", projectile)
