extends "res://mods-unpacked/RomatoPotato-Abilitious/abilities/activate_behaviors/ability_activate_behavior.gd"


func release_projectile(angle:float)-> void :
	var stats = _parent.current_stats
	var projectile = Utils.instance_scene_on_main(stats.projectile_scene, initial_position)

	projectile.spawn_position = initial_position
	projectile.set_effects(_parent.effects)
	projectile.velocity = Vector2.RIGHT.rotated(angle) * stats.projectile_speed
	projectile.rotation = projectile.velocity.angle()
	projectile.set_from(_parent)
	projectile.weapon_stats = imitate_weapon_stats(stats)
	projectile.set_damage(stats.damage, 1, 0, 0, stats.burning_data, false)
	projectile.set_knockback_vector( - Vector2(cos(angle), sin(angle)), stats.knockback)


func imitate_weapon_stats(stats:Resource) -> WeaponStats :
	var new_stats = RangedWeaponStats.new()

	new_stats.burning_data = stats.burning_data
	new_stats.damage = stats.damage
	new_stats.max_range = stats.max_range
	new_stats.knockback = stats.knockback
	new_stats.lifesteal = stats.lifesteal
	new_stats.nb_projectiles = stats.nb_projectiles
	new_stats.piercing = stats.piercing
	new_stats.piercing_dmg_reduction = stats.piercing_dmg_reduction
	new_stats.bounce = stats.bounce
	new_stats.bounce_dmg_reduction = stats.bounce_dmg_reduction
	new_stats.projectile_speed = stats.projectile_speed

	return new_stats
