extends "res://ui/menus/pages/main_menu.gd"

signal abilities_catalog_button_pressed

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitious/utils/gamemode_manager.gd")
var ability_debuff_info_container

var ability_mode_button
var ability_mode_button_normal_style
var ability_mode_button_hover_style
var ability_mode_button_pressed_style


func _ready():
	var buttons_left = $"HBoxContainer/ButtonsLeft"
	
	# adding the ability mode button
	var ability_mode_container = HBoxContainer.new()
	ability_mode_container.set("custom_constants/separation", 15)

	ability_mode_button = load("res://mods-unpacked/RomatoPotato-Abilitious/ui/button_abilities_mode/button_abilities_mode.tscn").instance()
	ability_mode_button.connect("pressed", self, "_on_AbilitiesModButton_pressed")
	
	ability_mode_button_normal_style = ability_mode_button.get_stylebox("normal")
	ability_mode_button_hover_style = ability_mode_button.get_stylebox("hover")
	ability_mode_button_pressed_style = ability_mode_button.get_stylebox("pressed")
	
	ability_mode_button_normal_style.border_color = Color.from_hsv(randf(), 0.8, 0.5)
	
	ability_mode_container.add_child(ability_mode_button)
	buttons_left.add_child_below_node(start_button, ability_mode_container)
	
	start_button.focus_neighbour_bottom = ability_mode_button.get_path()
	options_button.focus_neighbour_top = ability_mode_button.get_path()
	ability_mode_button.focus_neighbour_top = start_button.get_path()
	ability_mode_button.focus_neighbour_left = more_games_button.get_path()
	more_games_button.focus_neighbour_right = ability_mode_button.get_path()
	# end

	# adding the ability info button
	var ability_info_button = start_button.duplicate()
	ability_info_button.text = "?"
	ability_info_button.disconnect("pressed", self, "_on_StartButton_pressed")
	ability_info_button.connect("mouse_entered", self, "_on_AbilityInfoButton_mouse_entered")
	ability_info_button.connect("focus_entered", self, "_on_AbilityInfoButton_mouse_entered")
	ability_info_button.connect("mouse_exited", self, "_on_AbilityInfoButton_mouse_exited")
	ability_info_button.connect("focus_exited", self, "_on_AbilityInfoButton_mouse_exited")

	ability_mode_container.add_child_below_node(ability_mode_button, ability_info_button)

	ability_info_button.focus_neighbour_left = ability_mode_button.get_path()
	ability_info_button.focus_neighbour_right = more_games_button.get_path()
	ability_info_button.focus_neighbour_top = start_button.get_path()
	ability_info_button.focus_neighbour_bottom = options_button.get_path()
	more_games_button.focus_neighbour_left = ability_info_button.get_path()
	# end

	# adding ability debuff info container
	ability_debuff_info_container = load("res://mods-unpacked/RomatoPotato-Abilitious/ui/menus/pages/ability_debuff_info_container.tscn").instance()
	ability_mode_container.add_child(ability_debuff_info_container)
	# end

	# adding the abilities catalog button
	var abilities_catalog_button = load("res://mods-unpacked/RomatoPotato-Abilitious/ui/menus/pages/buttons/button_abilities_catalog.tscn").instance()
	abilities_catalog_button.connect("pressed", self, "_on_AbilitiesCatalogButton_pressed")

	buttons_left.remove_child(progress_button)

	var h_container = HBoxContainer.new()
	h_container.set("custom_constants/separation", 25)
	h_container.add_child(progress_button)
	h_container.add_child(abilities_catalog_button)

	buttons_left.add_child_below_node(options_button, h_container)

	progress_button.focus_neighbour_right = abilities_catalog_button.get_path()
	progress_button.focus_neighbour_left = community_button.get_path()
	abilities_catalog_button.focus_neighbour_right = community_button.get_path()
	community_button.focus_neighbour_left = abilities_catalog_button.get_path()
	community_button.focus_neighbour_right = progress_button.get_path()
	abilities_catalog_button.focus_neighbour_left = progress_button.get_path()
	# end

	# adding Abilitious logo
	var abilitious_logo = load("res://mods-unpacked/RomatoPotato-Abilitious/ui/menus/pages/abilitious_logo.tscn").instance()
	$"Logo".add_child(abilitious_logo)
	# end


func _process(_delta):
	# ability button animation
	ability_mode_button_normal_style.border_color.h += 0.001
	ability_mode_button_hover_style.bg_color = ability_mode_button_normal_style.border_color
	ability_mode_button_hover_style.border_color.h = ability_mode_button_normal_style.border_color.h
	ability_mode_button_pressed_style.border_color.h = ability_mode_button_normal_style.border_color.h
	

func _on_AbilitiesModButton_pressed():
	GameModeManager.change_gamemode(GameModeManager.GameMode.ABILITY)
	._on_StartButton_pressed()
	

func _on_StartButton_pressed()->void :
	GameModeManager.change_gamemode(GameModeManager.GameMode.DEFAULT)
	._on_StartButton_pressed()


func _on_AbilitiesCatalogButton_pressed():
	emit_signal("abilities_catalog_button_pressed")


func _on_AbilityInfoButton_mouse_entered():
	ability_debuff_info_container.show()
	
	
func _on_AbilityInfoButton_mouse_exited():
	ability_debuff_info_container.hide()
