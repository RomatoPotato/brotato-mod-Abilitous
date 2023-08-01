class_name Ability
extends Node2D

var stats:Resource
var ability_id:int
var tier:int
var effects:Array = []

var player:Player

var current_stats: = AbilityStats.new()

onready var _shooting_behavior:WeaponShootingBehavior = $AbilityShootingBehavior

var reload_track:int
var reload_condition:int

enum ReloadCondition{
	RANGED_KILLS,
	MELEE_KILLS,
}

func _ready():
	var _behavior = _shooting_behavior.init(self)
	init_stats()


func init_stats():
	current_stats = stats

	for effect in effects:
		if effect is BurningEffect:
			current_stats.burning_data = BurningData.new(effect.burning_data.chance, effect.burning_data.damage, effect.burning_data.duration, 0)
		else:
			if effect.key == "reload_by_ranged_kills":
				reload_condition = ReloadCondition.RANGED_KILLS
			if effect.key == "reload_by_melee_kills":
				reload_condition = ReloadCondition.MELEE_KILLS


func set_player(_player:Player):
	player = _player


func set_position(initial_position:Vector2):
	_shooting_behavior.initial_position = initial_position


func shoot():
	if !should_shoot():
		return

	_shooting_behavior.shoot(current_stats.max_range)

	match reload_condition:
		ReloadCondition.RANGED_KILLS:
			player.killed_by_ranged = 0
		ReloadCondition.MELEE_KILLS:
			player.killed_by_melee = 0


func should_shoot():
	match reload_condition:
		ReloadCondition.RANGED_KILLS:
			return player.killed_by_ranged >= current_stats.cooldown
		ReloadCondition.MELEE_KILLS:
			return player.killed_by_melee >= current_stats.cooldown
