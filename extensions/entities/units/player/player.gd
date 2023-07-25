extends "res://entities/units/player/player.gd"

var current_abilities = []

onready var player_node = get_node("RunningSmoke") # i chose a random node for abilities parent :D

func apply_items_effects()->void :
	for i in RunData.abilities.size():
		add_ability(RunData.abilities[i])
	.apply_items_effects()


func add_ability(ability:WeaponData)->void :
	var instance = ability.scene.instance()

	instance.stats = ability.stats.duplicate()
	instance.weapon_id = ability.weapon_id
	instance.tier = ability.tier
	
	for effect in ability.effects:
		instance.effects.push_back(effect.duplicate())

	player_node.add_child(instance)
	current_abilities.push_back(instance)
