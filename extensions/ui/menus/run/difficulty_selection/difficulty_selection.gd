extends "res://ui/menus/run/difficulty_selection/difficulty_selection.gd"

onready var description_container = $"MarginContainer/VBoxContainer/DescriptionContainer"

func _ready():
	if GameModeManager.current_gamemode() == GameMode.ABILITY:
		var ability_panel = _character_panel.duplicate()
		ability_panel._item_description = _character_panel._item_description

		_character_panel.set_data(RunData.abilities[0]) # if i set the data to ability_panel it doesn't work, don't understand why

		description_container.add_child(ability_panel)
		description_container.move_child(ability_panel, 0)

func manage_back(event:InputEvent)->void :
	if GameModeManager.current_gamemode() == GameMode.ABILITY:
		if event.is_action_pressed("ui_cancel") and not cancelled: # Brotato's code from difficulty_selection.gd
			cancelled = true # Brotato's code from difficulty_selection.gd
			RunData.is_endless_run = false # Brotato's code from difficulty_selection.gd

			Utils.last_elt_selected = RunData.abilities[0] # my change
			RunData.abilities = [] # my code
		
			var _error = get_tree().change_scene(MenuData.ability_selection_scene)  # my change
	else:
		.manage_back(event)
