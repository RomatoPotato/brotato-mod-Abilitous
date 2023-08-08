class_name Ability
extends Node2D

var stats:Resource
var ability_id:int
var tier:int
var effects:Array = []

var player:Player

var current_stats

onready var _shooting_behavior:WeaponShootingBehavior = $AbilityShootingBehavior

var reload_track:int = -1

func _ready():
	var _behavior = _shooting_behavior.init(self)
	init_stats()

	if reload_track == -1:
		reload_track = current_stats.cooldown


func init_stats():
	current_stats = stats

	for effect in effects:
		if effect is BurningEffect:
			current_stats.burning_data = BurningData.new(effect.burning_data.chance, effect.burning_data.damage, effect.burning_data.duration, 0)

	match stats.reload_condition:
		stats.ReloadCondition.RANGED_KILLS:
			var _tracker = player.connect("killed_by_ranged", self, "kill_tracker")
		stats.ReloadCondition.MELEE_KILLS:
			var _tracker = player.connect("killed_by_melee", self, "kill_tracker")


func set_player(_player:Player):
	player = _player


func kill_tracker():
	reload_track -= 1 if reload_track > 0 else 0


func ability_is_charged() -> bool:
	return reload_track <= 0


func shoot():
	if !ability_is_charged():
		return

	_shooting_behavior.initial_position = player.position
	_shooting_behavior.shoot(current_stats.max_range)

	reload_track = current_stats.cooldown
