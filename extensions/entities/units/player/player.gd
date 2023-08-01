extends "res://entities/units/player/player.gd"

var current_abilities = []

var abilities = Node.new()

var killed_by_melee:int = 0
var killed_by_ranged:int = 0

func _ready():
	add_child(abilities)


func apply_items_effects()->void :
	for i in RunData.abilities.size():
		add_ability(RunData.abilities[i])
	
	.apply_items_effects()

	for weapon in current_weapons:
		if weapon is MeleeWeapon:
			weapon._hitbox.connect("killed_something", self, "on_killed_something_by_melee")
		elif weapon is RangedWeapon:
			weapon._shooting_behavior.connect("projectile_shot", self, "on_projectile_shot")


func on_projectile_shot(projectile:Node2D)->void :
	var _killed_sthing = projectile._hitbox.connect("killed_something", self, "on_killed_something_by_ranged")


func on_killed_something_by_melee(_thing_killed:Node) -> void :
	killed_by_melee += 1
	

func on_killed_something_by_ranged(_thing_killed:Node) -> void :
	killed_by_ranged += 1


func add_ability(ability:AbilityData)->void :
	var instance = ability.scene.instance()
	
	instance.stats = ability.stats.duplicate()
	instance.ability_id = ability.ability_id
	instance.tier = ability.tier

	instance.set_player(self)
	
	if ability.effects != null:
		for effect in ability.effects:
			instance.effects.push_back(effect.duplicate())

	abilities.add_child(instance)
	current_abilities.push_back(instance)
	RunData.holding_ability = instance

func die(knockback_vector:Vector2 = Vector2.ZERO, p_cleaning_up:bool = false)->void :
	.die(knockback_vector, p_cleaning_up)

	abilities.queue_free()
