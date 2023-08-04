extends "res://entities/units/movement_behaviors/player_movement_behavior.gd"


func get_movement()->Vector2:
    if !ProgressData.settings.mouse_only:
        if !InputService.using_gamepad:
            var left:Vector2 = Vector2.LEFT if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_Q) else Vector2.ZERO
            var right:Vector2 = Vector2.RIGHT if Input.is_key_pressed(KEY_D) else Vector2.ZERO
            var up:Vector2 = Vector2.UP if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_Z) else Vector2.ZERO
            var down:Vector2 = Vector2.DOWN if Input.is_key_pressed(KEY_S) else Vector2.ZERO

            return (left + right + up + down).normalized()

    return .get_movement()