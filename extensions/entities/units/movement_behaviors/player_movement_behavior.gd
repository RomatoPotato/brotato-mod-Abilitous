extends "res://entities/units/movement_behaviors/player_movement_behavior.gd"


func get_movement()->Vector2:
    if !ProgressData.settings.mouse_only:
        if !InputService.using_gamepad:
            # now the arrows are not for moving, but for activating abilities
            var left:Vector2 = Vector2.LEFT if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_Q) else Vector2.ZERO
            var right:Vector2 = Vector2.RIGHT if Input.is_key_pressed(KEY_D) else Vector2.ZERO
            var up:Vector2 = Vector2.UP if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_Z) else Vector2.ZERO
            var down:Vector2 = Vector2.DOWN if Input.is_key_pressed(KEY_S) else Vector2.ZERO

            if !ability_actions_contains_key(KEY_UP):
                up = Vector2.UP if Input.is_key_pressed(KEY_UP) else up
            if !ability_actions_contains_key(KEY_RIGHT):
                right = Vector2.RIGHT if Input.is_key_pressed(KEY_RIGHT) else right
            if !ability_actions_contains_key(KEY_DOWN):
                down = Vector2.DOWN if Input.is_key_pressed(KEY_DOWN) else down
            if !ability_actions_contains_key(KEY_LEFT):
                left = Vector2.LEFT if Input.is_key_pressed(KEY_LEFT) else left

            return (left + right + up + down).normalized()

    return .get_movement()


func ability_actions_contains_key(key:int) -> bool:
    for item in ProgressData.ability_actions:
        if ProgressData.ability_actions[item] == key:
            return true
    return false