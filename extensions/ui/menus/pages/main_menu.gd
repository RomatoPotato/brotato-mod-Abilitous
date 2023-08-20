extends "res://ui/menus/pages/main_menu.gd"

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")
var ability_mode_button
var ability_mode_button_normal_style
var ability_mode_button_hover_style
var ability_mode_button_pressed_style


func _ready():
	var buttons_left = $"HBoxContainer/ButtonsLeft"
	
	ability_mode_button = load("res://mods-unpacked/RomatoPotato-Abilitato/ui/button_abilities_mode/button_abilities_mode.tscn").instance()
	
	ability_mode_button_normal_style = ability_mode_button.get_stylebox("normal")
	ability_mode_button_hover_style = ability_mode_button.get_stylebox("hover")
	ability_mode_button_pressed_style = ability_mode_button.get_stylebox("pressed")
	
	ability_mode_button_normal_style.border_color = Color.from_hsv(randf(), 0.8, 0.5)
	
	buttons_left.add_child_below_node(start_button, ability_mode_button)
	
	start_button.focus_neighbour_bottom = ability_mode_button.get_path()
	options_button.focus_neighbour_top = ability_mode_button.get_path()
	ability_mode_button.focus_neighbour_top = start_button.get_path()
	
	ability_mode_button.connect("pressed", self, "_on_AbilitiesModButton_pressed")


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