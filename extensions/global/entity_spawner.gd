extends "res://global/entity_spawner.gd"

var allies = []


func _physics_process(_delta:float)->void :
	if RunData.mod_effects["time_stopped"]:
		cur_spawn_delay = 0


func spawn_entity_birth(type:int, scene:PackedScene, pos:Vector2, data:Resource = null)->void :
	if type == 10:
		# code below is taken from entity_spawner.gd from spawn_entity_birth function
		var entity_birth = entity_birth_scene.instance()

		entity_birth.color = "#0094A5"
	
		entity_birth.global_position = pos
		_births_container.call_deferred("add_child", entity_birth)
		
		entity_birth.set_entity(type, scene, data)
		entity_birth.connect("birth_timeout", self, "on_entity_birth_timeout")
		
		births.push_back(entity_birth)
		# end
	else:
		.spawn_entity_birth(type, scene, pos, data)


func on_group_spawn_timing_reached(group_data:WaveGroupData, _is_elite_wave:bool)->void :
	if RunData.mod_effects["time_stopped"]:
		return

	.on_group_spawn_timing_reached(group_data, _is_elite_wave)


func on_entity_birth_timeout(birth:EntityBirth, type:int, scene:PackedScene, pos:Vector2, data:Resource)->void :
	if type == 10:
		# code below is taken from entity_spawner.gd from a part of on_entity_birth_timeout function
		var entity = spawn_entity(scene, pos, false, data)
		allies.push_back(entity)
		entity.connect("died", self, "_on_ally_died")
		births.erase(birth)
		# end
		return

	if RunData.mod_effects["time_stopped"]:
		births.erase(birth)
		return

	.on_entity_birth_timeout(birth, type, scene, pos, data)


func _on_ally_died(ally:Node2D)->void :
	if not _cleaning_up:
		allies.erase(ally)

	
func clean_up_room()->void :
	.clean_up_room()

	for ally in allies:
		ally.die(Vector2.ZERO, _cleaning_up)