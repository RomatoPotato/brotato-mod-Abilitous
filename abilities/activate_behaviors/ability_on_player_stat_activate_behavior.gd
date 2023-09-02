extends "res://mods-unpacked/RomatoPotato-Abilitato/abilities/activate_behaviors/ability_activate_behavior.gd"

enum enum_stats {
	HEALTH,
	SPEED,
	DAMAGE,
	ARMOR,
	DODGE
}

enum enum_apply_type {
	PERCENT,
	NUMERICAL
}

export (enum_stats) var stat
export (enum_apply_type) var apply_type


func activate() -> void:
	match apply_type:
		enum_apply_type.NUMERICAL:
			pass
		enum_apply_type.PERCENT:
			var curr_stat = _parent.player.current_stats.get(str(enum_stats.keys()[stat]).to_lower())
			var max_stat = _parent.player.max_stats.get(str(enum_stats.keys()[stat]).to_lower())
			var changed_stat = min(max(1, curr_stat + (float(_parent.current_stats.additional_stat) / 100) * max_stat), max_stat)

			_parent.player.current_stats.set(str(enum_stats.keys()[stat]).to_lower(), changed_stat)

			var effect_manager = get_tree().current_scene.get_node("EffectsManager")

			match stat:
				enum_stats.HEALTH:
					_parent.player.emit_signal("health_updated", _parent.player.current_stats.health, max_stat)

					for _i in range(5):
						effect_manager.play_boost_particles(_parent.player.global_position, effect_manager.heal_particles)
