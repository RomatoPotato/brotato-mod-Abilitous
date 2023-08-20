extends "res://entities/units/player/player.gd"

signal killed_by_melee
signal killed_by_ranged

var not_moving_timer_for_ability
var moving = true

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")


func _ready():
	if GameModeManager.current_gamemode_is_ability():
		not_moving_timer_for_ability = Timer.new()
		add_child(not_moving_timer_for_ability)
		not_moving_timer_for_ability.start()


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


func update_animation(movement:Vector2)->void :
	if not_moving_timer_for_ability:
		if movement.x == 0 and movement.y == 0 && !moving:
			not_moving_timer_for_ability.start()
			moving = true
		elif movement.x != 0 or movement.y != 0 && moving:
			moving = false
			not_moving_timer_for_ability.stop()
			
	.update_animation(movement)