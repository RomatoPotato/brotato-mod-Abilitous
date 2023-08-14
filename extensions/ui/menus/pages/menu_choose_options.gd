extends "res://ui/menus/pages/menu_choose_options.gd"

signal abilities_controls_button_pressed

func _ready():
	var buttons_container = $"Buttons"
	var gameplay_button = $"Buttons/GameplayButton"
	var abilities_controls_button = load("res://mods-unpacked/RomatoPotato-Abilitato/ui/menus/pages/button_abilities_controls.tscn").instance()

	buttons_container.add_child_below_node(gameplay_button, abilities_controls_button)

	abilities_controls_button.disconnect("pressed", self, "_on_GameplayButton_pressed")
	abilities_controls_button.connect("pressed", self, "_on_AbilitiesControlsButton_pressed")


func _on_AbilitiesControlsButton_pressed():
	emit_signal("abilities_controls_button_pressed")
