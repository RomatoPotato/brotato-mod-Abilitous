extends "res://entities/units/movement_behaviors/player_movement_behavior.gd"

var is_arrow_up_used = true
var is_arrow_right_used = true
var is_arrow_down_used = true
var is_arrow_left_used = true

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")


func _ready():
	disable_busy_arrows()


func get_movement()->Vector2:
	if GameModeManager.current_gamemode_is_ability():
		if !ProgressData.settings.mouse_only && !InputService.using_gamepad:
			var movement = Vector2.ZERO
			
			var left:Vector2 = Vector2.LEFT if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_Q) else Vector2.ZERO
			var right:Vector2 = Vector2.RIGHT if Input.is_key_pressed(KEY_D) else Vector2.ZERO
			var up:Vector2 = Vector2.UP if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_Z) else Vector2.ZERO
			var down:Vector2 = Vector2.DOWN if Input.is_key_pressed(KEY_S) else Vector2.ZERO

			if !is_arrow_up_used:
				up = Vector2.UP if Input.is_key_pressed(KEY_UP) else up
			if !is_arrow_right_used:
				right = Vector2.RIGHT if Input.is_key_pressed(KEY_RIGHT) else right
			if !is_arrow_down_used:
				down = Vector2.DOWN if Input.is_key_pressed(KEY_DOWN) else down
			if !is_arrow_left_used:
				left = Vector2.LEFT if Input.is_key_pressed(KEY_LEFT) else left

			movement = (left + right + up + down).normalized()

			# code below is taken from player_movement_behavior
			if RunData.effects["cant_stop_moving"] and movement == Vector2.ZERO:
				if last_movement == Vector2.ZERO:
					movement = Vector2(rand_range( - PI, PI), rand_range( - PI, PI))
				else :
					movement = last_movement

			last_movement = movement
			# end

			return movement

	return .get_movement()


func disable_busy_arrows():
	is_arrow_up_used = ability_actions_contains_key(KEY_UP)
	is_arrow_right_used = ability_actions_contains_key(KEY_RIGHT)
	is_arrow_down_used = ability_actions_contains_key(KEY_DOWN)
	is_arrow_left_used = ability_actions_contains_key(KEY_LEFT)



func ability_actions_contains_key(key:int) -> bool:
	for item in ProgressData.ability_actions:
		if ProgressData.ability_actions[item] == key:
			return true
	return false
