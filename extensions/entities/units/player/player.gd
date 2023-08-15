extends "res://entities/units/player/player.gd"

signal killed_by_melee
signal killed_by_ranged

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")


func apply_items_effects()->void :	
	.apply_items_effects()

	if GameModeManager.current_gamemode_is_ability():
		for weapon in current_weapons:
			if weapon is MeleeWeapon:
				weapon._hitbox.connect("killed_something", self, "on_killed_something_by_melee")
			elif weapon is RangedWeapon:
				weapon._shooting_behavior.connect("projectile_shot", self, "on_projectile_shot")


func on_projectile_shot(projectile:Node2D)->void :
	var _killed_sthing = projectile._hitbox.connect("killed_something", self, "on_killed_something_by_ranged")


func on_killed_something_by_melee(_thing_killed:Node) -> void :
	emit_signal("killed_by_melee")
	

func on_killed_something_by_ranged(_thing_killed:Node) -> void :
	emit_signal("killed_by_ranged")
