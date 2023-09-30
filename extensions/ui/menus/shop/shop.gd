extends "res://ui/menus/shop/shop.gd"

onready var container = $"Content/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3"
onready var empty_space = $"Content/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/EmptySpace"

var abilities_container

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitious/utils/gamemode_manager.gd")
var AbilityData = load("res://mods-unpacked/RomatoPotato-Abilitious/utils/ability_data.gd")


func _ready():
	if GameModeManager.current_gamemode_is_ability():
		abilities_container = load("res://mods-unpacked/RomatoPotato-Abilitious/ui/menus/shop/abilities_container.tscn").instance()

		container.add_child_below_node(empty_space, abilities_container)
		container.set("custom_constants/separation", 50)
		
		abilities_container.set_data(get_abilities_label_text(), 10, RunData.abilities)
		_items_container._elements.columns = 6
		
		_focus_manager.init_abilities_container(abilities_container)
		var _error_abilities_item_bought = connect("item_bought", abilities_container._elements, "on_item_bought")
		
		var _error_cancel_item = _item_popup.connect("item_cancel_button_pressed", self, "on_ability_item_cancel_button_pressed")
		var _error_discard_item = _item_popup.connect("item_discard_button_pressed", self, "on_ability_item_discard_button_pressed")
		var _error_combine_item = _item_popup.connect("item_combine_button_pressed", self, "on_ability_item_combine_button_pressed")


func get_abilities_label_text()->String:
	return tr("ABILITIES") + " (" + str(RunData.abilities.size()) + "/" + str(RunData.mod_effects["ability_slot"]) + ")"
	

func on_shop_item_bought(shop_item:ShopItem)->void :
	if GameModeManager.current_gamemode_is_ability():
		if shop_item.item_data.get_category() == 10:
			if not RunData.has_ability_slot_available():
				for ability in RunData.abilities:
					if ability.my_id == shop_item.item_data.my_id and ability.upgrades_into != null:
						var _ability = RunData.add_ability(shop_item.item_data)
						on_ability_item_combine_button_pressed(ability)
						break
			else:
				RunData.add_ability(shop_item.item_data)
				abilities_container.set_label(get_abilities_label_text())
				
	.on_shop_item_bought(shop_item)


func on_element_pressed(element:InventoryElement)->void :
	if element.item is AbilityData:
		_block_background.show()
	else:
		.on_element_pressed(element)


func on_item_combine_button_pressed(weapon_data:WeaponData, is_upgrade:bool = false)->void :
	if not weapon_data is WeaponData: # preventing from getting into the AbilityData to event handler
		return

	.on_item_combine_button_pressed(weapon_data, is_upgrade)


func on_item_discard_button_pressed(weapon_data:WeaponData)->void :
	if not weapon_data is WeaponData: # preventing from getting into the AbilityData to event handler
		return

	.on_item_discard_button_pressed(weapon_data)


func on_item_cancel_button_pressed(weapon_data:WeaponData)->void :
	if not weapon_data is WeaponData: # preventing from getting into the AbilityData to event handler
		return

	.on_item_cancel_button_pressed(weapon_data)


func on_ability_item_discard_button_pressed(ability_data:ItemParentData) -> void:
	if ability_data is WeaponData: # preventing from getting into the WeaponData to event handler
		return

	# code below is taken from on_item_discard_button_pressed(weapon_data:WeaponData) but changed for AbilityData
	_focus_manager.reset_focus()
	abilities_container._elements.remove_element(ability_data)
	RunData.remove_ability(ability_data)
	RunData.add_gold(ItemService.get_recycling_value(RunData.current_wave, ability_data.value, true))
	
	reset_item_popup_focus()
	_shop_items_container.update_buttons_color()
	_reroll_button.set_color_from_currency(RunData.gold)
	SoundManager.play(Utils.get_rand_element(recycle_sounds), 0, 0.1, true)

	# end
		
		
func on_ability_item_combine_button_pressed(ability_data:ItemParentData, is_upgrade:bool = false) -> void:
	if ability_data is WeaponData: # preventing from getting into the WeaponData to event handler
		return

	# code below is taken from on_item_combine_button_pressed(weapon_data:WeaponData) but changed for AbilityData
	_focus_manager.reset_focus()

	var nb_to_remove = 2
	
	if is_upgrade:
		nb_to_remove = 1
	
	abilities_container._elements.remove_element(ability_data, nb_to_remove)
	RunData.remove_ability(ability_data)
	
	if not is_upgrade:
		RunData.remove_ability(ability_data)
	
	reset_item_popup_focus()
	
	var new_ability = RunData.add_ability(ability_data.upgrades_into)
	
	_stats_container.update_stats()
	
	abilities_container._elements.add_element(new_ability)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_HIDDEN:
		abilities_container._elements.focus_element(new_ability)
	
	SoundManager.play(Utils.get_rand_element(combine_sounds), 0, 0.1, true)
	abilities_container.set_label(get_abilities_label_text())

	# end


func on_ability_item_cancel_button_pressed(ability_data:ItemParentData)->void :
	if ability_data is WeaponData: # preventing from getting into the WeaponData to event handler
		return

	# code below is taken from on_item_cancel_button_pressed(weapon_data:WeaponData) but changed for AbilityData
	_focus_manager.reset_focus()
	_block_background.hide()
	if $Content.visible:
		abilities_container._elements.focus_element(ability_data)

	# end
