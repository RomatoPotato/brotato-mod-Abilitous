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