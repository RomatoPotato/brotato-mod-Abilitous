extends Node
class_name AbilitiesSelector

onready var ability_1_container = $"Ability1"
onready var ability_2_container = $"Ability2"
onready var ability_3_container = $"Ability3"
onready var ability_4_container = $"Ability4"

var current_abilities:Dictionary
var abilities_data:Dictionary


func _ready():
	current_abilities = {
		ability_1_container : null,
		ability_2_container : null,
		ability_3_container : null,
		ability_4_container : null
	}

	abilities_data = {}

	if !ProgressData.tier_indicator:
		for container in current_abilities:
			get_container_tier_indicator(container).hide()


func add_ability(ability_data:ItemParentData, _player:Player) -> void:
	for container in current_abilities:
		if current_abilities[container] != null:
			continue

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

		match ability_data.tier:
			0:
				get_container_tier_indicator(container).set_self_modulate("#c2c2c2")
			1:
				get_container_tier_indicator(container).set_self_modulate(ItemService.TIER_UNCOMMON_COLOR)
			2:
				get_container_tier_indicator(container).set_self_modulate(ItemService.TIER_RARE_COLOR)
			3:
				get_container_tier_indicator(container).set_self_modulate(ItemService.TIER_LEGENDARY_COLOR)

		current_abilities[container] = instance
		abilities_data[instance] = ability_data

		instance.connect("cooldown_changed", self, "on_cooldown_changed")
		instance.connect("duration_changed", self, "on_duration_changed")
		instance.connect("ability_charged", self, "on_ability_charged")
		instance.connect("ability_activated", self, "on_ability_activated")
		instance.connect("duration_timer_started", self, "on_duration_timer_started")
		instance.connect("duration_timer_ended", self, "on_duration_timer_ended")

		display_cooldown(instance)
		break


func dye_container(ability:Node2D, color:Color):
	for container in current_abilities:
		if current_abilities[container] == ability:
			container.set_self_modulate(color)
	

func on_duration_timer_started(ability:Node2D):
	for container in current_abilities:
		if current_abilities[container] == ability:
			get_container_progress(container).max_value = ability.stats.duration
	
	dye_container(ability, Color.red)
	

func on_ability_charged(ability:Node2D):
	dye_container(ability, Color.green)


func on_ability_activated(ability:Node2D):
	dye_container(ability, Color.black)
	display_cooldown(ability)


func on_duration_changed(ability:Node2D):
	display_duration(ability)


func on_duration_timer_ended(ability:Node2D):
	for container in current_abilities:
		if current_abilities[container] == ability:
			get_container_progress(container).max_value = ability.stats.cooldown
	
	on_ability_activated(ability)


func on_cooldown_changed(ability:Node2D):
	display_cooldown(ability)


func display_cooldown(ability:Node2D):
	for container in current_abilities:
		if current_abilities[container] == ability:
			get_container_progress(container).value = current_abilities[container].current_cooldown
			get_container_label(container).text = str(current_abilities[container].current_cooldown)

			if ability.ability_charged():
				on_ability_charged(ability)


func display_duration(ability:Node2D):
	for container in current_abilities:
		if current_abilities[container] == ability:
			get_container_progress(container).value = current_abilities[container].current_duration
			get_container_label(container).text = str(current_abilities[container].current_duration)


func activate_ability():
	if is_input_pressed(ProgressData.ability_actions["ability1"]) || Input.is_joy_button_pressed(0, JOY_XBOX_Y):
		if current_abilities[ability_1_container]: current_abilities[ability_1_container].shoot()
	if is_input_pressed(ProgressData.ability_actions["ability2"]) || Input.is_joy_button_pressed(0, JOY_XBOX_B):
		if current_abilities[ability_2_container]: current_abilities[ability_2_container].shoot()
	if is_input_pressed(ProgressData.ability_actions["ability3"]) || Input.is_joy_button_pressed(0, JOY_XBOX_A):
		if current_abilities[ability_3_container]: current_abilities[ability_3_container].shoot()
	if is_input_pressed(ProgressData.ability_actions["ability4"]) || Input.is_joy_button_pressed(0, JOY_XBOX_X):
		if current_abilities[ability_4_container]: current_abilities[ability_4_container].shoot()


func is_input_pressed(code:int) -> bool:
	return Input.is_key_pressed(code) || Input.is_mouse_button_pressed(code)


func reload_stats():
	for container in current_abilities:
		if current_abilities[container]:
			current_abilities[container].init_stats()

		
func save_cooldowns():
	var cooldowns = []

	for ability in get_abilities():
		cooldowns.push_back(ability.current_cooldown)

	return cooldowns


func load_cooldowns(cooldowns):
	if cooldowns:
		var i = 0
		for container in current_abilities:
			if current_abilities[container]:
				current_abilities[container].current_cooldown = cooldowns[i] if cooldowns.size() >= (i + 1) else current_abilities[container].current_stats.cooldown
				display_cooldown(current_abilities[container])
				i += 1


func get_abilities() -> Array:
	var abilities = []

	for container in current_abilities:
		if current_abilities[container]:
			abilities.push_back(current_abilities[container])

	return abilities


func get_ability_data(_ability:Node2D) -> ItemParentData:
	for ability in get_abilities():
		if ability == _ability:
			return abilities_data[ability]

	return null


func get_container_icon(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/AbilityContainer/Icon")
	
	
func get_container_progress(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/AbilityContainer/CooldownProgress")
	
	
func get_container_place(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/AbilityContainer/AbilityPlace")
	

func get_container_label(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/Label")
	
	
func get_container_tier_indicator(_container:Node) -> Node:
	return get_node(str(get_path_to(_container)) + "/TierIndicator")
