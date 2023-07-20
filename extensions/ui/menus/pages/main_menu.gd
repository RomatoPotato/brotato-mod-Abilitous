extends "res://ui/menus/pages/main_menu.gd"

func _ready():
	var buttons_left = $"HBoxContainer/ButtonsLeft"
	
	var ability_mod_button = start_button.duplicate()
	
	ability_mod_button.text = "Abilities Mod"
	
	buttons_left.add_child_below_node(start_button, ability_mod_button)
	
	start_button.focus_neighbour_bottom = ability_mod_button.get_path()
	options_button.focus_neighbour_top = ability_mod_button.get_path()
	ability_mod_button.focus_neighbour_top = start_button.get_path()
	
	ability_mod_button.connect("pressed", self, "_on_AbilitiesModButton_pressed")
	ability_mod_button.disconnect("pressed", self, "_on_StartButton_pressed")
	
func _on_AbilitiesModButton_pressed():
	pass
