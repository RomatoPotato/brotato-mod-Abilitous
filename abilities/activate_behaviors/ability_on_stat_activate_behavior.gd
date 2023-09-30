extends "res://mods-unpacked/RomatoPotato-Abilitious/abilities/activate_behaviors/ability_activate_behavior.gd"

signal temp_effect_applied
signal temp_effect_unapplied

enum enum_stats {
	MAX_HP,
	ARMOR,
	CRIT_CHANCE,
	LUCK,
	ATTACK_SPEED,
	ELEMENTAL_DAMAGE,
	HP_REGENERATION,
	LIFESTEAL,
	MELEE_DAMAGE,
	PERCENT_DAMAGE,
	DODGE,
	ENGINEERING,
	RANGE,
	RANGED_DAMAGE,
	SPEED,
	HARVESTING
}

enum enum_using_type {
	TEMPORARY,
	PERMANENT
}

var stats = {
	enum_stats.MAX_HP:"stat_max_hp",
	enum_stats.ARMOR:"stat_armor",
	enum_stats.CRIT_CHANCE:"stat_crit_chance",
	enum_stats.LUCK:"stat_luck",
	enum_stats.ATTACK_SPEED:"stat_attack_speed",
	enum_stats.ELEMENTAL_DAMAGE:"stat_elemental_damage",
	enum_stats.HP_REGENERATION:"stat_hp_regeneration",
	enum_stats.LIFESTEAL:"stat_lifesteal",
	enum_stats.MELEE_DAMAGE:"stat_melee_damage",
	enum_stats.PERCENT_DAMAGE:"stat_percent_damage",
	enum_stats.DODGE:"stat_dodge",
	enum_stats.ENGINEERING:"stat_engineering",
	enum_stats.RANGE:"stat_range",
	enum_stats.RANGED_DAMAGE:"stat_ranged_damage",
	enum_stats.SPEED:"stat_speed",
	enum_stats.HARVESTING:"stat_harvesting"
}

export (enum_stats) var affected_stat
export (enum_using_type) var using_type

onready var cooldown_timer = $"BehaviorCooldownTimer"


func _ready():
	var _wave_timer = get_tree().current_scene.get_node("WaveTimer").connect("timeout", self, "_on_WaveTimer_timeout")


func release_projectile(_angle:float) -> void:
	if using_type == enum_using_type.TEMPORARY:
		cooldown_timer.wait_time = _parent.current_stats.duration
		cooldown_timer.start()

	apply_effect()


func apply_effect():
	RunData.effects[stats.get(affected_stat)] += _parent.current_stats.additional_stat
	RunData.emit_signal("stat_added", stats.get(affected_stat), _parent.current_stats.additional_stat)

	if using_type == enum_using_type.TEMPORARY:
		emit_signal("temp_effect_applied", _parent.ability_id)
	
	
func unapply_effect():
	RunData.effects[stats.get(affected_stat)] -= _parent.current_stats.additional_stat
	RunData.emit_signal("stat_removed", stats.get(affected_stat), _parent.current_stats.additional_stat)

	if using_type == enum_using_type.TEMPORARY:
		emit_signal("temp_effect_unapplied", _parent.ability_id)


func _on_WaveTimer_timeout():
	remove_child(cooldown_timer)

	if cooldown_timer.time_left > 0:
		unapply_effect()


func _on_BehaviorCooldownTimer_timeout():
	unapply_effect()
