extends "res://ui/menus/ingame/ingame_main_menu.gd"

onready var container = $"Content/MarginContainer/HBoxContainer/VBoxContainer"

func _ready():
	if GameModeManager.current_gamemode() == GameMode.ABILITY:
		var abilities_container = load("res://mods-unpacked/RomatoPotato-Abilitato/resources/ui/menus/shop/abilities_container.tscn").instance()
		container.add_child_below_node(_weapons_container, abilities_container)
		abilities_container.set_data(get_abilities_label_text(), 4, RunData.abilities)


func get_abilities_label_text()->String:
	return tr("ABILITIES") + " (" + str(RunData.abilities.size()) + "/" + str(RunData.mod_effects["ability_slot"]) + ")"
