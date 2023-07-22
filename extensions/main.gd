extends "res://main.gd"

var ability_image = TextureRect.new()
var label = Label.new()

var bullet_shot

func _ready():
	RunData.add_ability(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/bullet_shot/bullet_shot_data.tres"))
	RunData.add_ability(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/fire_shot/fire_shot_data.tres"))
	
	._ready()

	bullet_shot = _player.current_abilities[1]
	
	var life_container = $"UI/HUD/LifeContainer"
	
	ability_image.texture = load("res://mods-unpacked/RomatoPotato-Abilitato/resources/icons/fire.png")
	
	label.add_font_override("font", load("res://resources/fonts/actual/base/font_biggest.tres"))
	label.text = str(bullet_shot.stats.cooldown)
	
	life_container.add_child_below_node(_ui_bonus_gold, ability_image)
	life_container.add_child_below_node(ability_image, label)
	
func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		if bullet_shot._current_cooldown == 0:
			bullet_shot.set_position(_player.position)
			bullet_shot.need_shoot = true

func _process(_delta):
	label.text = str(round(bullet_shot._current_cooldown))
