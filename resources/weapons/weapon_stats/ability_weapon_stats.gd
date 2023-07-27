class_name AbilityWeaponStats
extends WeaponStats

export (int) var nb_projectiles: = 1
export (int) var piercing: = 0
export (float, 0, 1, 0.05) var piercing_dmg_reduction: = 0.5
export (int) var bounce: = 0
export (float, 0, 1, 0.05) var bounce_dmg_reduction: = 0.5
export (int) var projectile_speed: = 3000
export (PackedScene) var projectile_scene = null

func get_piercing_text(_base_stats:Resource)->String:
	if piercing <= 0:return ""
	
	return "\n" + Text.text("PIERCING_FORMATTED", [tr("PIERCING") + "∞"])


func get_cooldown_text(_base_stats:Resource, _multiplier:float = 1.0)->String:
	return ""
