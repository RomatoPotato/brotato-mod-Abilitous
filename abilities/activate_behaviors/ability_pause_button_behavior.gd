extends "res://mods-unpacked/RomatoPotato-Abilitato/abilities/activate_behaviors/ability_activate_behavior.gd"

onready var cooldown_timer = $"BehaviorCooldownTimer"

var entity_spawner
var projectiles


func _ready():
	var _wave_timer = get_tree().current_scene.get_node("WaveTimer").connect("timeout", self, "_on_WaveTimer_timeout")
	entity_spawner = get_tree().current_scene.get_node("EntitySpawner")
	projectiles = get_tree().current_scene.get_node("Projectiles")


func release_projectile(_angle:float) -> void:
	RunData.mod_effects["time_stopped"] = true

	cooldown_timer.wait_time = _parent.current_stats.duration
	cooldown_timer.start()

	pause_all_entities()


func _on_BehaviorCooldownTimer_timeout():
	RunData.mod_effects["time_stopped"] = false
	unpause_all_entities()


func _on_WaveTimer_timeout():
	remove_child(cooldown_timer)
	RunData.mod_effects["time_stopped"] = false
	unpause_all_entities()


func pause_entity(entity:Entity):
	entity._animation_player.stop()
	entity.set_physics_process(false)


func unpause_entity(entity:Entity):
	entity._animation_player.play()
	entity.set_physics_process(true)


func pause_all_entities():
	for enemy in entity_spawner.enemies:
		pause_entity(enemy)

	for boss in entity_spawner.bosses:
		pause_entity(boss)
		
	for neutral in entity_spawner.neutrals:
		pause_entity(neutral)
		
	for structure in entity_spawner.structures:
		pause_entity(structure)

	for projectile in projectiles.get_children():
		if projectile is EnemyProjectile:
			projectile.set_physics_process(false)


func unpause_all_entities():
	for enemy in entity_spawner.enemies:
		unpause_entity(enemy)

	for boss in entity_spawner.bosses:
		unpause_entity(boss)
		
	for neutral in entity_spawner.neutrals:
		unpause_entity(neutral)
		
	for structure in entity_spawner.structures:
		unpause_entity(structure)

	for projectile in projectiles.get_children():
		if projectile is EnemyProjectile:
			projectile.set_physics_process(true)
