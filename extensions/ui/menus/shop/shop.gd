extends "res://ui/menus/shop/shop.gd"

onready var container = $"Content/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3"
onready var empty_space = $"Content/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/EmptySpace"

var abilities_container

func _ready():
	if GameModeManager.current_gamemode() == GameMode.ABILITY:
		abilities_container = load("res://mods-unpacked/RomatoPotato-Abilitato/resources/ui/menus/shop/abilities_container.tscn").instance()

		container.add_child_below_node(empty_space, abilities_container)
		container.set("custom_constants/separation", 50)
		
		abilities_container.set_data(get_abilities_label_text(), ModCategory.ABILITY, RunData.abilities)
		_items_container._elements.columns = 6
		
		_focus_manager.init_abilities_container(abilities_container)
		var _error_abilities_item_bought = connect("item_bought", abilities_container._elements, "on_item_bought")


func get_abilities_label_text()->String:
	return tr("ABILITIES") + " (" + str(RunData.abilities.size()) + "/" + str(RunData.mod_effects["ability_slot"]) + ")"
	

func on_shop_item_bought(shop_item:ShopItem)->void :
	.on_shop_item_bought(shop_item)

	if GameModeManager.current_gamemode() == GameMode.ABILITY:
		if shop_item.item_data is AbilityData:
			RunData.add_ability(shop_item.item_data)
			abilities_container.set_label(get_abilities_label_text())