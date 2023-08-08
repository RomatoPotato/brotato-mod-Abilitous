extends Resource

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

var weapon_stats_for_color = WeaponStats.new()
var col_a = weapon_stats_for_color.col_a
var col_neutral_a = weapon_stats_for_color.col_neutral_a
var col_pos_a = weapon_stats_for_color.col_pos_a
var col_neg_a = weapon_stats_for_color.col_neg_a
var col_b = weapon_stats_for_color.col_b

var col_desc_a = "[color=#008FE9]"


func get_text() -> String :
    var text = "\n"

    text += Text.text("DAMAGE_FORMATTED", [col_a + tr("STAT_DAMAGE") + col_b, get_damage_text()])

    text += get_range_text()
    text += get_bouncing_text()
    text += get_piercing_text()
    text += get_reload_text()
    
    return text


func get_damage_text()->String:
	return str(damage)


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


func get_range_text()->String:
    return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + tr("STAT_RANGE") + col_b, col_neutral_a + str(max_range) + col_b])


func get_reload_text() -> String:
    return "\n" + Text.text("ABILITY_DEFAULT_STAT_FORMATTED", [col_a + tr("RELOADS") + col_b, col_neutral_a + tr(ReloadCondition.keys()[reload_condition]) + col_b])