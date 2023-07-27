extends "res://main.gd"

var ability_image = TextureRect.new()

var bullet_shot

func _ready():
	if GameModeManager.current_gamemode() == GameMode.ABILITY:
		bullet_shot = RunData.holding_ability
	
	var life_container = $"UI/HUD/LifeContainer"
	
	ability_image.texture = load("res://mods-unpacked/RomatoPotato-Abilitato/resources/icons/fire.png")
	
	life_container.add_child_below_node(_ui_bonus_gold, ability_image)
	
func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE and GameModeManager.current_gamemode() == GameMode.ABILITY:
		if bullet_shot._current_cooldown == 0:
			bullet_shot.set_position(_player.position)
			bullet_shot.need_shoot = true
