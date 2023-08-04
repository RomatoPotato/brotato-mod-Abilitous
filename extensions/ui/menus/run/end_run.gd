extends "res://ui/menus/run/end_run.gd"

onready var container_inner = $"MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/PanelContainer/HBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer"
onready var container = $"MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/PanelContainer/HBoxContainer/MarginContainer2/VBoxContainer"

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")


func _ready():
	if GameModeManager.current_gamemode_is_ability():
		var abilities_container = load("res://mods-unpacked/RomatoPotato-Abilitato/resources/ui/menus/shop/abilities_container_vertical.tscn").instance()

		var newc = HBoxContainer.new()
		newc.set("custom_constants/separation", 50)
		_items_container._elements.columns = 8

		container.add_child(newc)
		container.remove_child(_items_container)
		newc.add_child(_items_container)
		newc.add_child(abilities_container)
		
		abilities_container.set_data(get_abilities_label_text(), 4, RunData.abilities)
		
		_focus_manager.init_abilities_container(abilities_container)


func get_abilities_label_text()->String:
	return tr("ABILITIES") + " (" + str(RunData.abilities.size()) + "/" + str(RunData.mod_effects["ability_slot"]) + ")"
