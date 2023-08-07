extends Node
class_name AbilitiesSelector

onready var ability_1_container = $"Ability1"
onready var ability_2_container = $"Ability2"
onready var ability_3_container = $"Ability3"
onready var ability_4_container = $"Ability4"

var free_containers:Dictionary
var current_abilities:Dictionary


func _ready():
	free_containers = {
		ability_1_container : true,
		ability_2_container : true,
		ability_3_container : true,
		ability_4_container : true
	}

	current_abilities = {
		ability_1_container : null,
		ability_2_container : null,
		ability_3_container : null,
		ability_4_container : null
	}


func add_ability(ability_data:ItemParentData, _player:Player) -> void:
	for container in free_containers:
		if free_containers[container]:
			get_container_icon(container).texture = ability_data.icon
			get_container_label(container).text = str(ability_data.stats.cooldown)

			var instance = ability_data.scene.instance()
	
			instance.stats = ability_data.stats.duplicate()
			instance.ability_id = ability_data.ability_id
			instance.tier = ability_data.tier

			instance.set_player(_player)

			if ability_data.effects != null:
				for effect in ability_data.effects:
					instance.effects.push_back(effect.duplicate())
				
			get_container_place(container).add_child(instance)

			free_containers[container] = false
			current_abilities[container] = instance
			break


func display_cooldown():
	for container in current_abilities:
		if !container_is_free(container):
			get_container_label(container).text = str(current_abilities[container].reload_track)


func activate_ability():
	if Input.is_key_pressed(KEY_UP):
		if !container_is_free(ability_1_container):
			current_abilities[ability_1_container].shoot()
	if Input.is_key_pressed(KEY_RIGHT):
		if !container_is_free(ability_2_container):
			current_abilities[ability_2_container].shoot()
	if Input.is_key_pressed(KEY_DOWN):
		if !container_is_free(ability_3_container):
			current_abilities[ability_3_container].shoot()
	if Input.is_key_pressed(KEY_LEFT):
		if !container_is_free(ability_4_container):
			current_abilities[ability_4_container].shoot()

		
func save_cooldowns():
	var cooldowns = []

	for container in current_abilities:
		if current_abilities[container] != null:
			cooldowns.push_back(current_abilities[container].reload_track)

	return cooldowns


func load_cooldowns(cooldowns):
	if cooldowns != null:
		var i = 0
		for container in current_abilities:
			if current_abilities[container] != null:
				current_abilities[container].reload_track = cooldowns[i] if cooldowns.size() >= (i + 1) else current_abilities[container].current_stats.cooldown
				i += 1


func free_container(_container:Node):
	get_container_icon(_container).texture = null
	get_container_label(_container).text = ""
	get_container_place(_container).queue_free()

	free_containers[_container] = true
	current_abilities[_container] = null


func free_all_containers():
	for container in free_containers:
		free_container(container)


func container_is_free(_container:Node):
	for container in free_containers:
		if container == _container:
			return free_containers[container]


func get_container_icon(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/Icon")
	
	
func get_container_label(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/CooldownScore")
	
	
func get_container_place(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/AbilityPlace")
