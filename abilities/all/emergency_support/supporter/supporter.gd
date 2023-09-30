extends "res://mods-unpacked/RomatoPotato-Abilitious/utils/entities/ally/ally.gd"

onready var _running_smoke:Particles2D = $RunningSmoke
onready var _shadow:Sprite = $Animation/Shadow
onready var _legs:Node2D = $Animation/Legs


func _ready():
	var weapon = load("res://weapons/ranged/rocket_launcher/4/rocket_launcher_4_data.tres")
	var instance = weapon.scene.instance()

	instance.weapon_pos = RunData.max_weapons + 1 # to prevent this weapon from being considered a player's weapon
	instance.stats = weapon.stats.duplicate()
	instance.weapon_id = weapon.weapon_id
	
	for effect in weapon.effects:
		instance.effects.push_back(effect.duplicate())

	_weapons_container.add_child(instance)
	instance.global_position = global_position


func update_animation(movement:Vector2)->void:
	.update_animation(movement)

	# code below is taken from player.gd
	if _animation_player.current_animation == "idle" and movement != Vector2.ZERO:
		_animation_player.play("move")
		_running_smoke.emit()
	elif _animation_player.current_animation == "move" and movement == Vector2.ZERO:
		_animation_player.play("idle")
		_running_smoke.stop()
	# end


func die(knockback_vector:Vector2 = Vector2.ZERO, p_cleaning_up:bool = false)->void :
	.die(knockback_vector, p_cleaning_up)
	_legs.queue_free()
	_shadow.queue_free()
	_running_smoke.queue_free()
