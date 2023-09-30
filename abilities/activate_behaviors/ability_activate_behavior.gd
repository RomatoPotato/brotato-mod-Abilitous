extends Behavior
class_name AbilityActivateBehavior

var initial_position = Vector2.ZERO


func activate() -> void:
	if _parent.current_stats.nb_projectiles == 0:
		release_projectile(0)
		return

	var angle = rand_range(0, deg2rad(360))
	var angle_step = deg2rad(360 / _parent.current_stats.nb_projectiles)

	for i in _parent.current_stats.nb_projectiles:
		release_projectile(angle)
		angle += angle_step


func release_projectile(_angle:float) -> void:
	pass
