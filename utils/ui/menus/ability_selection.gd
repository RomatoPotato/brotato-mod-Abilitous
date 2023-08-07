extends CharacterSelection

var ability_added: = false
var cancelled = false

onready var _character_panel:ItemPanelUI = $MarginContainer / VBoxContainer / DescriptionContainer / CharacterPanel
onready var _weapon_panel:ItemPanelUI = $MarginContainer / VBoxContainer / DescriptionContainer / WeaponPanel

func _ready()->void :
	_character_panel.set_data(RunData.current_character)
	
	if RunData.starting_weapon:
		_weapon_panel.show()
		_weapon_panel.set_data(RunData.starting_weapon)
	else :
		_weapon_panel.hide()


func _input(event:InputEvent)->void :
	manage_back(event)


func manage_back(event:InputEvent)->void :
	# Brotato's code from difficulty_selection.gd
	if event.is_action_pressed("ui_cancel") and not cancelled:
		cancelled = true
		RunData.abilities = [] # my code
		RunData.weapons = []
		RunData.items = []
		RunData.effects = RunData.init_effects()
		RunData.init_appearances_displayed()
		
		Utils.last_elt_selected = RunData.starting_weapon
		RunData.starting_weapon = null
		
		RunData.active_set_effects = []
		RunData.unique_effects = []
		RunData.additional_weapon_effects = []
		RunData.tier_iv_weapon_effects = []
		RunData.tier_i_weapon_effects = []
		
		RunData.add_character(RunData.current_character)
		
		if RunData.effects["weapon_slot"] == 0:
			RunData.apply_weapon_selection_back() # my change
		else :
			var _error = get_tree().change_scene(MenuData.weapon_selection_scene)
	# End of Brotato's code


func get_elements_unlocked()->Array:
	var unlocked_abilities = []

	for ability in ItemService.abilities:
		unlocked_abilities.push_back(ability.my_id)

	return unlocked_abilities


func get_all_possible_elements()->Array:
	return ItemService.abilities


func get_reward_type()->int:
	return 8


func on_element_pressed(element:InventoryElement)->void :
	if ability_added:
		return 

	var starting_ability
	
	if element.is_random:
		ability_added = true
		starting_ability = Utils.get_rand_element(available_elements)
	else :
		ability_added = true
		starting_ability = element.item
		
	RunData.starting_ability = starting_ability
	RunData.add_ability(starting_ability)
	
	var _error = get_tree().change_scene(MenuData.current_difficulty_selection_scene)


func update_info_panel(_item_info:ItemParentData)->void :
	pass


func is_char_screen()->bool:
	return false


func is_locked_elements_displayed()->bool:
	return false
