extends Resource
class_name AbilityStats

enum ReloadCondition{
	RANGED_KILLS,
	MELEE_KILLS,
}

export (int) var damage: = 1
export (int) var cooldown: = 10
export (int, 0, 10000) var max_range: = 100
export (int, 0, 10000) var knockback: = 0
export (float, 0, 1.0, 0.01) var lifesteal: = 0.0
export (Array, Resource) var shooting_sounds
export (int) var sound_db_mod = - 5
export (int) var nb_projectiles: = 1
export (int) var piercing: = 0
export (float, 0, 1, 0.05) var piercing_dmg_reduction: = 0.0
export (int) var bounce: = 0
export (float, 0, 1, 0.05) var bounce_dmg_reduction: = 0.0
export (int) var projectile_speed: = 3000
export (PackedScene) var projectile_scene = null
export (ReloadCondition) var reload_condition

var burning_data:BurningData = BurningData.new()

var weapon_stats = WeaponStats.new()
var col_a = weapon_stats.col_a
var col_neutral_a = weapon_stats.col_neutral_a
var col_pos_a = weapon_stats.col_pos_a
var col_neg_a = weapon_stats.col_neg_a
var col_b = weapon_stats.col_b
var init_a = weapon_stats.init_a

var col_desc_a = "[color=#008FE9]"


func get_text(base_stats:Resource) -> String :
	var text = ""

	text += get_damage_text(base_stats)
	text += get_nb_projectiles()
	text += get_range_text(base_stats)
	text += get_bouncing_text()
	text += get_piercing_text()
	text += get_reload_text()
	
	return text


func get_damage_text(base_stats:Resource)->String:
	var a = weapon_stats.get_col_a(damage, base_stats.damage)
	var damage_text = a + str(damage) + col_b

	if damage != base_stats.damage:
		var initial_damage_text = str(base_stats.damage)
		damage_text += init_a + initial_damage_text + col_b
	
	return "\n" + Text.text("DAMAGE_FORMATTED", [col_a + tr("STAT_DAMAGE") + col_b, damage_text])


func get_nb_projectiles() -> String:
	if nb_projectiles == 0:
		return ""

	return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + tr("PROJECTILES") + col_b, col_neutral_a + str(nb_projectiles) + col_b])


func get_bouncing_text()->String:
	if bounce <= 0:return ""

	var string_key

	if bounce_dmg_reduction == 0:
		string_key = "ABILITY_DEFAULT_STAT_FORMATTED"
	else:
		string_key = "ABILITY_PIERCING_FORMATTED"
	
	return "\n" + Text.text(string_key, [col_a + tr("BOUNCE") + col_b, col_neutral_a + str(bounce) + col_b, col_neutral_a + str(round(bounce_dmg_reduction * 100.0)) + col_b])


func get_piercing_text()->String:
	if piercing <= 0:return ""

	var string_key

	if piercing_dmg_reduction == 0 && piercing <= 1000:
		string_key = "ABILITY_DEFAULT_STAT_FORMATTED"
	elif piercing_dmg_reduction == 0 && piercing > 1000:
		string_key = "ABILITY_PIERCING_MUCH_FORMATTED"
	elif piercing_dmg_reduction != 0 && piercing > 1000:
		string_key = "ABILITY_PIERCING_MUCH_AND_REDUCTION_FORMATTED"
	else:
		string_key = "ABILITY_PIERCING_FORMATTED"
	
	return "\n" + Text.text(string_key, [col_a + tr("PIERCING") + col_b, col_neutral_a + str(piercing) + col_b, col_neutral_a + str(round(piercing_dmg_reduction * 100.0)) + col_b])


func get_range_text(base_stats:Resource)->String:
	var a = weapon_stats.get_col_a(max_range, base_stats.max_range)
	var range_text = a + str(max_range) + col_b
	
	if max_range != base_stats.max_range:
		range_text += init_a + str(base_stats.max_range) + col_b

	return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + tr("STAT_RANGE") + col_b, range_text])


func get_reload_text() -> String:
	return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + tr("RELOADS") + col_b, col_neutral_a + tr(ReloadCondition.keys()[reload_condition]) + col_b])
