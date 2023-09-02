class_name Ability
extends Node2D

signal temp_effect_applied(ability_id)
signal temp_effect_unapplied(ability_id)

var stats:Resource
var ability_id:String
var tier:int
var effects:Array = []

var player:Player

var current_stats

onready var activate_behavior:Behavior = $AbilityActivateBehavior
onready var cooldown_timer = $"CooldownTimer"

var current_cooldown:int = -1

var AbilityService = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/ability_service.gd")
var entity_spawner


func _ready():
	var _behavior = activate_behavior.init(self)

	for _sign in _behavior.get_signal_list():
		if _sign["name"] == "temp_effect_applied":
			_behavior.connect("temp_effect_applied", self, "on_temp_effect_applied")
			_behavior.connect("temp_effect_unapplied", self, "on_temp_effect_unapplied")

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
	if entity_spawner:
		if entity_spawner.get_all_enemies().size() >= current_stats.additional_stat && cooldown_timer.is_stopped():
			cooldown_timer.start()
		elif entity_spawner.get_all_enemies().size() < current_stats.additional_stat && !cooldown_timer.is_stopped():
			cooldown_timer.stop()


func init_stats():
	current_stats = AbilityService.new().init_stats(stats, effects)


func set_player(_player:Player):
	player = _player


func on_cooldown_changed():
	current_cooldown -= 1 if current_cooldown > 0 else 0

	if current_cooldown == 0:
		if cooldown_timer:
			cooldown_timer.stop()


func _on_player_took_damage(_unit:Unit, _value:int, _knockback_direction:Vector2, _knockback_amount:float, _is_crit:bool, _is_miss:bool, _is_dodge:bool, _is_protected:bool, _effect_scale:float, _hit_type:int)->void :
	on_cooldown_changed()


func ability_is_charged() -> bool:
	return current_cooldown <= 0


func shoot():
	if !ability_is_charged():
		return

	activate_behavior.initial_position = player.position
	activate_behavior.activate()

	current_cooldown = current_stats.cooldown

	if cooldown_timer:
		cooldown_timer.start()


func on_temp_effect_applied():
	emit_signal("temp_effect_applied", ability_id)


func on_temp_effect_unapplied():
	emit_signal("temp_effect_unapplied", ability_id)
