extends "res://mods-unpacked/RomatoPotato-Abilitato/abilities/shooting_behaviors/ability_shooting_behavior.gd"

export (Array, Resource) var entities:Array

var entity_spawner

func _ready():
	entity_spawner = get_tree().get_root().get_node("Main/EntitySpawner")


func shoot_projectile(_angle:float):
	var entity_to_spawn = Utils.get_rand_element(entities)
	var entity_info = [[WaveUnitData.Type.NEUTRAL, entity_to_spawn, Vector2(initial_position.x + 50 * cos(_angle), initial_position.y + 50 * sin(_angle))]]

	entity_spawner.spawn(entity_info)
