extends Resource
class_name AbilityStats

enum ReloadCondition{
	RANGED_KILLS,
	MELEE_KILLS,
	TIME,
	NOT_MOVING,
	TAKE_DAMAGE,
	PICK_UP,
	ANY_KILLS,
	ENEMIES_COUNT
}

export (int) var damage: = 1
export (int) var cooldown: = 10
export (int) var duration: = -1
export (int, 0, 10000) var max_range: = 100
export (int, 0, 10000) var knockback: = 0
export (float, 0, 1.0, 0.01) var lifesteal: = 0.0
export (int) var nb_projectiles: = 1
export (int) var piercing: = 0
export (float, 0, 1, 0.05) var piercing_dmg_reduction: = 0.0
export (int) var bounce: = 0
export (float, 0, 1, 0.05) var bounce_dmg_reduction: = 0.0
export (int) var projectile_speed: = 3000
export (float) var additional_stat: = 0.0
export (PackedScene) var projectile_scene = null
export (ReloadCondition) var reload_condition

var burning_data:BurningData = BurningData.new()

var col_a = "[color=#" + Utils.SECONDARY_FONT_COLOR.to_html() + "]"
var col_neutral_a = "[color=white]"
var col_pos_a = "[color=" + Utils.POS_COLOR_STR + "]"
var col_neg_a = "[color=" + Utils.NEG_COLOR_STR + "]"
var col_b = "[/color]"
var init_a = " [color=" + Utils.GRAY_COLOR_STR + "]| "
var col_desc_a = "[color=#008FE9]"


func get_text(base_stats:Resource, ability_id:String) -> String :
	var text = ""

	text += get_reload_text(ability_id)
	text += get_duration_text()
	text += get_damage_text(base_stats)
	text += get_knockback_text()
	text += get_range_text(base_stats)
	text += get_nb_projectiles(ability_id)
	text += get_bouncing_text()
	text += get_piercing_text()
	text += get_add_stats_text(ability_id)
	
	return text


func get_reload_text(ability_id:String) -> String:
	var args = [col_pos_a + str(cooldown) + col_b]

	match ability_id:
		"emergency_support":
			args.append(col_pos_a + str(additional_stat) + col_b)

	return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + tr("RELOADS") + col_b, 
		Text.text(col_neutral_a + tr(ReloadCondition.keys()[reload_condition]) + col_b, args)])


func get_duration_text():
	if duration <= 0: return ""

	return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + tr("DURATION") + col_b, 
		Text.text(col_neutral_a + tr("TIME") + col_b, [str(duration)])])


func get_damage_text(base_stats:Resource)->String:
	if damage <= 0: return ""

	var a = get_col_a(damage, base_stats.damage)
	var damage_text = a + str(damage) + col_b

	if damage != base_stats.damage:
		var initial_damage_text = str(base_stats.damage)
		damage_text += init_a + initial_damage_text + col_b
	
	return "\n" + Text.text("DAMAGE_FORMATTED", [col_a + tr("STAT_DAMAGE") + col_b, damage_text])


func get_knockback_text():
	if knockback <= 0: return ""

	return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + tr("KNOCKBACK") + col_b, str(knockback)])


func get_range_text(base_stats:Resource)->String:
	if max_range <= 0: return ""
	
	var a = get_col_a(max_range, base_stats.max_range)
	var range_text = a + str(max_range) + col_b
	
	if max_range != base_stats.max_range:
		range_text += init_a + str(base_stats.max_range) + col_b

	return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + tr("STAT_RANGE") + col_b, range_text])


func get_nb_projectiles(ability_id:String) -> String:
	if nb_projectiles <= 0: return ""

	var stat_string = tr("PROJECTILES")

	match ability_id:
		"friend_of_the_forest":
			stat_string = tr("TREES_COUNT")
		"antisapper":
			stat_string = tr("LANDMINES_COUNT")
		"emergency_support":
			stat_string = tr("COOL_GUYS_COUNT")

	return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + stat_string + col_b, col_neutral_a + str(nb_projectiles) + col_b])


func get_bouncing_text()->String:
	if bounce <= 0: return ""

	var string_key

	if bounce_dmg_reduction == 0:
		string_key = "ABILITY_DEFAULT_STAT_FORMATTED"
	else:
		string_key = "ABILITY_PIERCING_FORMATTED"
	
	return "\n" + Text.text(string_key, [col_a + tr("BOUNCE") + col_b, col_neutral_a + str(bounce) + col_b, col_neutral_a + str(round(bounce_dmg_reduction * 100.0)) + col_b])


func get_piercing_text()->String:
	if piercing <= 0: return ""

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


func get_add_stats_text(ability_id:String) -> String:
	if additional_stat <= 0: return ""
	
	match ability_id:
		"first_aid_kit":
			return "\n" + Text.text("ABILITY_PERCENT_STAT_FORMATTED", [col_a + tr("STAT_HEAL") + col_b, str(additional_stat)])

	return ""


# code below is taken from weapon_stats.gd
func get_col_a(value:float, base_value:float)->String:
	if value > base_value:return col_pos_a
	elif value == base_value:return col_neutral_a
	else :return col_neg_a