extends "res://mods-unpacked/RomatoPotato-Abilitato/abilities/activate_behaviors/ability_activate_behavior.gd"

export (Resource) var entity
export (Resource) var structure_effect

var entity_spawner

var Ally = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/entities/ally/ally.gd")

onready var cooldown_timer = $"BehaviorCooldownTimer"

var entity_type = -1


func _ready():
	entity_spawner = get_tree().current_scene.get_node("EntitySpawner")

	
func activate() -> void:
	.activate()
	
	if _parent.current_stats.duration != -1:
		cooldown_timer.wait_time = _parent.current_stats.duration
		cooldown_timer.start()


func release_projectile(_angle:float):
	var instance = entity.instance()
	var distance = 50 + _parent.current_stats.max_range

	if instance is Structure:		
		var entity_info = [[EntityType.STRUCTURE, entity, Vector2(initial_position.x + distance * cos(_angle), initial_position.y + distance * sin(_angle)), structure_effect]]

		entity_spawner.spawn(entity_info)
		return

	if instance is Neutral:
		entity_type = EntityType.NEUTRAL
	elif instance is Enemy:
		entity_type = EntityType.ENEMY
	elif instance is Ally:
		entity_type = 10
	
	if entity_type != -1:
		var entity_info = [[entity_type, entity, Vector2(initial_position.x + distance * cos(_angle), initial_position.y + distance * sin(_angle))]]
		
		entity_spawner.spawn(entity_info)


func _on_BehaviorCooldownTimer_timeout():
	for ally in entity_spawner.allies:
		ally.die()
	
	# one more time, because for some reason, there's one ally left
	for ally in entity_spawner.allies:
		ally.die()
