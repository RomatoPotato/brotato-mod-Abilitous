class_name AbilityStats
extends Resource

export (int) var damage: = 1
export (int, 0, 10000) var max_range: = 100
export (int, 0, 10000) var knockback: = 0
export (float, 0, 1.0, 0.01) var lifesteal: = 0.0
export (Array, Resource) var shooting_sounds
export (int) var sound_db_mod = - 5
export (int) var nb_projectiles: = 1
export (int) var piercing: = 0
export (int) var bounce: = 0
export (int) var projectile_speed: = 3000
export (PackedScene) var projectile_scene = null

var burning_data:BurningData = BurningData.new()

var weapon_stats_for_color = WeaponStats.new()
var col_a = weapon_stats_for_color.col_a
var col_neutral_a = weapon_stats_for_color.col_neutral_a
var col_pos_a = weapon_stats_for_color.col_pos_a
var col_neg_a = weapon_stats_for_color.col_neg_a
var col_b = weapon_stats_for_color.col_b
var init_a = weapon_stats_for_color.init_a

func get_text() -> String :
    var text = ""

    text += Text.text("DAMAGE_FORMATTED", [col_a + tr("STAT_DAMAGE") + col_b, get_damage_text()])
    
    return text

func get_damage_text()->String:
	return str(damage)