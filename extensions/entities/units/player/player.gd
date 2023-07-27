extends "res://entities/units/player/player.gd"

var current_abilities = []

var abilities = Node.new()

func _ready():
	add_child(abilities)

func apply_items_effects()->void :
	for i in RunData.abilities.size():
		add_ability(RunData.abilities[i])
	.apply_items_effects()


func add_ability(ability:AbilityData)->void :
	var instance = ability.scene.instance()
	
	instance.stats = ability.stats.duplicate()
	instance.ability_id = ability.ability_id
	instance.tier = ability.tier
	
	for effect in ability.effects:
		instance.effects.push_back(effect.duplicate())

	abilities.add_child(instance)
	current_abilities.push_back(instance)
	RunData.holding_ability = instance

func die(knockback_vector:Vector2 = Vector2.ZERO, p_cleaning_up:bool = false)->void :
	.die(knockback_vector, p_cleaning_up)

	abilities.queue_free()
