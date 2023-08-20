extends Node

var MIN_RANGE = 50

var AbilityStats = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/ability_stats.gd")


func init_stats(from_stats:Resource, effects:Array) -> Resource:
	var current_stats = from_stats.duplicate()
	var new_stats = AbilityStats.new()

	var percent_dmg_bonus = (1 + (Utils.get_stat("stat_percent_damage") / 100.0))
	new_stats.damage = max(1, round(current_stats.damage * percent_dmg_bonus)) as int if current_stats.damage > 0 else 0

	new_stats.cooldown = current_stats.cooldown
	new_stats.duration = current_stats.duration

	new_stats.max_range = max(MIN_RANGE, current_stats.max_range + Utils.get_stat("stat_range")) as int if current_stats.max_range > 0 else 0
	
	new_stats.knockback = current_stats.knockback
	new_stats.lifesteal = current_stats.lifesteal
	new_stats.shooting_sounds = current_stats.shooting_sounds
	new_stats.sound_db_mod = current_stats.sound_db_mod
	new_stats.nb_projectiles = current_stats.nb_projectiles
	new_stats.piercing = current_stats.piercing
	new_stats.piercing_dmg_reduction = current_stats.piercing_dmg_reduction
	new_stats.bounce = current_stats.bounce
	new_stats.bounce_dmg_reduction = current_stats.bounce_dmg_reduction
	new_stats.projectile_speed = current_stats.projectile_speed
	new_stats.projectile_scene = current_stats.projectile_scene
	new_stats.reload_condition = current_stats.reload_condition

	for effect in effects:
		if effect is BurningEffect:
			new_stats.burning_data = BurningData.new(effect.burning_data.chance, effect.burning_data.damage, effect.burning_data.duration, BurningData.BurningType.ELEMENTAL)

	return new_stats
