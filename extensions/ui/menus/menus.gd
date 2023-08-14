extends "res://ui/menus/menus.gd"

var menu_abilities_controls_options


func _ready():
	menu_abilities_controls_options = load("res://mods-unpacked/RomatoPotato-Abilitato/ui/menus/pages/menu_abilities_controls_options.tscn").instance()
	menu_abilities_controls_options.name = "AbilitiesControlsOptions"
	menu_abilities_controls_options.hide()

	add_child(menu_abilities_controls_options)

	var _error_back_abilities_controls_options = menu_abilities_controls_options.connect("back_button_pressed", self, "on_options_abilities_controls_back_button_pressed")
	var _error_abilities_controls_choose_options = _menu_choose_options.connect("abilities_controls_button_pressed", self, "on_abilities_controls_button_pressed")

	._ready()


func on_options_abilities_controls_back_button_pressed():
	switch(menu_abilities_controls_options, _menu_choose_options)


func on_abilities_controls_button_pressed():
	switch(_menu_choose_options, menu_abilities_controls_options)
