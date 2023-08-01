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
	var stats = _parent.current_stats
	var projectile = Utils.instance_scene_on_main(stats.projectile_scene, initial_position)

	projectile.spawn_position = initial_position
	projectile.set_effects(_parent.effects)
	projectile.velocity = Vector2.RIGHT.rotated(angle) * stats.projectile_speed
	projectile.rotation = projectile.velocity.angle()
	projectile.set_from(_parent)
	projectile.weapon_stats = imitate_weapon_stats(stats)
	projectile.set_damage(stats.damage, 1, 0, 0, stats.burning_data, false)
	projectile.set_knockback_vector(Vector2.ZERO, stats.knockback)


func imitate_weapon_stats(stats:AbilityStats) -> WeaponStats :
	var new_stats = RangedWeaponStats.new()

	new_stats.burning_data = stats.burning_data
	new_stats.damage = stats.damage
	new_stats.max_range = stats.max_range
	new_stats.knockback = stats.knockback
	new_stats.lifesteal = stats.lifesteal
	new_stats.nb_projectiles = stats.nb_projectiles
	new_stats.piercing = stats.piercing
	new_stats.bounce = stats.bounce
	new_stats.projectile_speed = stats.projectile_speed

	return new_stats
