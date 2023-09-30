class_name Ability
extends Node2D

signal cooldown_changed(ability)
signal duration_changed(ability)
signal ability_charged(ability)
signal ability_activated(ability)
signal duration_timer_started(ability)
signal duration_timer_ended(ability)

var stats:Resource
var ability_id:String
var tier:int
var effects:Array = []

var player:Player

var current_stats

onready var activate_behavior:Behavior = $AbilityActivateBehavior
onready var cooldown_timer = $"CooldownTimer"
onready var duration_timer = $"DurationTimer"

var current_cooldown:int = -1
var current_duration:int = -1
var charged_flag = false

var AbilityService = load("res://mods-unpacked/RomatoPotato-Abilitious/utils/ability_service.gd")
var entity_spawner


func _ready():
	var _behavior = activate_behavior.init(self)

	init_stats()
	
	match current_stats.reload_condition:
		current_stats.ReloadCondition.RANGED_KILLS:
			var _tracker = player.connect("killed_by_ranged", self, "on_cooldown_changed")
		current_stats.ReloadCondition.MELEE_KILLS:
			var _tracker = player.connect("killed_by_melee", self, "on_cooldown_changed")
		current_stats.ReloadCondition.TIME:
			cooldown_timer.connect("timeout", self, "on_cooldown_changed")
			cooldown_timer.start()
		current_stats.ReloadCondition.NOT_MOVING:
			var _tracker = player.not_moving_timer_for_ability.connect("timeout", self, "on_cooldown_changed")
		current_stats.ReloadCondition.TAKE_DAMAGE:
			var _tracker = player.connect("took_damage", self, "_on_player_took_damage")
		current_stats.ReloadCondition.PICK_UP:
			var _tracker = player.connect("consumable_picked_up", self, "on_cooldown_changed")
		current_stats.ReloadCondition.ANY_KILLS:
			var _tracker = player.connect("enemy_died", self, "on_cooldown_changed")
		current_stats.ReloadCondition.ENEMIES_COUNT:
			entity_spawner = get_tree().current_scene.get_node("EntitySpawner")
			cooldown_timer.connect("timeout", self, "on_cooldown_changed")

	if current_cooldown == -1:
		current_cooldown = current_stats.cooldown


func _process(_delta):
	if current_stats.reload_condition == current_stats.ReloadCondition.ENEMIES_COUNT:
		if entity_spawner.get_all_enemies().size() >= current_stats.additional_stat && cooldown_timer.is_stopped():
			cooldown_timer.start()
		elif entity_spawner.get_all_enemies().size() < current_stats.additional_stat && !cooldown_timer.is_stopped():
			cooldown_timer.stop()


func init_stats():
	current_stats = AbilityService.new().init_stats(stats, effects)


func set_player(_player:Player):
	player = _player


func on_cooldown_changed():
	if current_duration > 0 || current_cooldown <= 0:
		return

	if current_cooldown > 0:
		current_cooldown -= 1
		emit_signal("cooldown_changed", self)

	if ability_charged() && !charged_flag:
		charged_flag = true
		emit_signal("ability_charged", self)

	if current_cooldown == 0:
		if cooldown_timer:
			cooldown_timer.stop()


func _on_player_took_damage(_unit:Unit, _value:int, _knockback_direction:Vector2, _knockback_amount:float, _is_crit:bool, _is_miss:bool, _is_dodge:bool, _is_protected:bool, _effect_scale:float, _hit_type:int)->void :
	on_cooldown_changed()


func ability_charged():
	return current_cooldown <= 0


func shoot():
	if !ability_charged():
		return

	if current_stats.reload_condition == current_stats.ReloadCondition.TIME:
		cooldown_timer.start()

	charged_flag = false

	activate_behavior.initial_position = player.position
	activate_behavior.activate()

	current_cooldown = current_stats.cooldown
	emit_signal("ability_activated", self)

	if current_stats.duration != -1:
		current_duration = current_stats.duration
		duration_timer.start()
		emit_signal("duration_timer_started", self)
		emit_signal("duration_changed", self)


func _on_DurationTimer_timeout():
	if current_duration > 0:
		current_duration -= 1
		emit_signal("duration_changed", self)

	if current_duration == 0:
		current_duration = -1

		if cooldown_timer:
			cooldown_timer.start()
		
		emit_signal("duration_timer_ended", self)
		emit_signal("cooldown_changed", self)
