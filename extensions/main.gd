extends "res://main.gd"

var bullet_shot

var t1
var t2

func _ready():
	if GameModeManager.current_gamemode() == GameMode.ABILITY:
		bullet_shot = RunData.holding_ability

	var a = $"UI/HUD/LifeContainer"
	t1 = $"UI/HUD/LifeContainer/UIGold/GoldLabel".duplicate()
	t2 = t1.duplicate()
	
	a.add_child_below_node(_ui_bonus_gold, t1)
	a.add_child_below_node(t1, t2)


func _process(_delta):
	t1.text = "Melee kills: " + str(_player.killed_by_melee)
	t2.text = "Ranged kills: " + str(_player.killed_by_ranged)

	
func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		if GameModeManager.current_gamemode() == GameMode.ABILITY and not _cleaning_up:
			bullet_shot.set_position(_player.position)
			bullet_shot.shoot()
