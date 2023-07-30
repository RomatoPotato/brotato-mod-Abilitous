extends "res://ui/menus/shop/shop.gd"

onready var container = $"Content/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3"
onready var empty_space = $"Content/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/EmptySpace"


func _ready():
	if GameModeManager.current_gamemode() == GameMode.ABILITY:
		var abilities_container = load("res://mods-unpacked/RomatoPotato-Abilitato/resources/ui/menus/shop/abilities_container.tscn").instance()

		container.add_child_below_node(empty_space, abilities_container)
		container.set("custom_constants/separation", 50)
		
		abilities_container.set_data(get_abilities_label_text(), 4, RunData.abilities)
		abilities_container._elements.columns = 2
		_items_container._elements.columns = 6
		
		_focus_manager.init_abilities_container(abilities_container)


func get_abilities_label_text()->String:
	return tr("ABILITIES") + " (" + str(RunData.abilities.size()) + "/" + str(RunData.mod_effects["ability_slot"]) + ")"
	
