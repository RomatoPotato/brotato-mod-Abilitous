class_name Ability
extends Node2D

var stats:Resource
var ability_id:int
var tier:int
var effects:Array = []

var current_stats: = AbilityStats.new()

onready var _shooting_behavior:WeaponShootingBehavior = $AbilityShootingBehavior

var need_shoot = false

func _ready():
	var _behavior = _shooting_behavior.init(self)
	init_stats()


func init_stats():
	current_stats = stats

	for effect in effects:
		if effect is BurningEffect:
			current_stats.burning_data = BurningData.new(effect.burning_data.chance, effect.burning_data.damage, effect.burning_data.duration, 0)


func set_position(initial_position:Vector2):
	_shooting_behavior.initial_position = initial_position


func shoot():
	if !should_shoot():
		return

	_shooting_behavior.shoot(current_stats.max_range)
	
	need_shoot = false

func should_shoot():
	return need_shoot
