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

			var instance = ability_data.scene.instance()
	
			instance.stats = ability_data.stats.duplicate()
			instance.ability_id = ability_data.ability_id
			instance.tier = ability_data.tier

			instance.set_player(_player)

			if ability_data.effects != null:
				for effect in ability_data.effects:
					instance.effects.push_back(effect.duplicate())
				
			get_container_place(container).add_child(instance)
			get_container_progress(container).max_value = instance.stats.cooldown

			free_containers[container] = false
			current_abilities[container] = instance
			break


func display_cooldown():
	for container in current_abilities:
		if !container_is_free(container):
			get_container_progress(container).value = current_abilities[container].reload_track
			get_container_label(container).text = str(current_abilities[container].reload_track)
			if current_abilities[container].ability_is_charged():
				container.set_self_modulate(Color.green)


func activate_ability():
	if is_input_pressed(ProgressData.ability_actions["ability1"]) || Input.is_joy_button_pressed(0, JOY_XBOX_Y || JOY_SONY_TRIANGLE):
		if !container_is_free(ability_1_container):
			current_abilities[ability_1_container].shoot()
			ability_1_container.set_self_modulate(Color.black)
	if is_input_pressed(ProgressData.ability_actions["ability2"]) || Input.is_joy_button_pressed(0, JOY_XBOX_B || JOY_SONY_CIRCLE):
		if !container_is_free(ability_2_container):
			current_abilities[ability_2_container].shoot()
			ability_2_container.set_self_modulate(Color.black)
	if is_input_pressed(ProgressData.ability_actions["ability3"]) || Input.is_joy_button_pressed(0, JOY_XBOX_A || JOY_SONY_X):
		if !container_is_free(ability_3_container):
			current_abilities[ability_3_container].shoot()
			ability_3_container.set_self_modulate(Color.black)
	if is_input_pressed(ProgressData.ability_actions["ability4"]) || Input.is_joy_button_pressed(0, JOY_XBOX_X || JOY_SONY_SQUARE):
		if !container_is_free(ability_4_container):
			current_abilities[ability_4_container].shoot()
			ability_4_container.set_self_modulate(Color.black)


func is_input_pressed(code:int) -> bool:
	return Input.is_key_pressed(code) || Input.is_mouse_button_pressed(code)


func reload_stats():
	for container in current_abilities:
		if current_abilities[container] != null:
			current_abilities[container].init_stats()

		
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
	get_container_place(_container).queue_free()
	get_container_progress(_container).max_value = 0
	get_container_label(_container).text = ""

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
	return get_node(str(get_path_to(_container)) + "/AbilityContainer/Icon")
	
	
func get_container_progress(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/AbilityContainer/CooldownProgress")
	
	
func get_container_place(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/AbilityContainer/AbilityPlace")
	

func get_container_label(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/Label")
