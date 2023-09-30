extends "res://ui/menus/menus.gd"

var menu_abilities_controls_options
var menu_abilities_catalog


func _ready():
	menu_abilities_controls_options = load("res://mods-unpacked/RomatoPotato-Abilitious/ui/menus/pages/menu_abilities_controls_options.tscn").instance()
	menu_abilities_controls_options.name = "AbilitiesControlsOptions"
	menu_abilities_controls_options.hide()

	menu_abilities_catalog = load("res://mods-unpacked/RomatoPotato-Abilitious/ui/menus/pages/menu_abilities_catalog.tscn").instance()
	menu_abilities_catalog.name = "AbilitiesCatalog"
	menu_abilities_catalog.hide()

	add_child(menu_abilities_controls_options)
	add_child(menu_abilities_catalog)

	var _error_back_abilities_controls_options = menu_abilities_controls_options.connect("back_button_pressed", self, "on_optionsAbilitiesControlsBackButton_pressed")
	var _error_abilities_controls_choose_options = _menu_choose_options.connect("abilities_controls_button_pressed", self, "on_abilitiesControlsButton_pressed")

	var _error_back_abilities_catalog = menu_abilities_catalog.connect("back_button_pressed", self, "on_abilitiesCatalogBackButton_pressed")
	var _error_abilities_catalog = _main_menu.connect("abilities_catalog_button_pressed", self, "on_abilitiesCatalogButton_pressed")


func on_optionsAbilitiesControlsBackButton_pressed():
	switch(menu_abilities_controls_options, _menu_choose_options)


func on_abilitiesControlsButton_pressed():
	switch(_menu_choose_options, menu_abilities_controls_options)


func on_abilitiesCatalogBackButton_pressed():
	switch(menu_abilities_catalog, _main_menu)


func on_abilitiesCatalogButton_pressed():
	switch(_main_menu, menu_abilities_catalog)
