extends "res://main.gd"

const DEFAULT_PROJECTILE_SCENE = preload("res://projectiles/bullet/bullet_projectile.tscn")
var ability_image = TextureRect.new()
var label = Label.new()
var rot = 0

var cd = 1

var bullet_data = WeaponData.new() as WeaponData

func _ready():
	._ready()
	
	var life_container = $"UI/HUD/LifeContainer"
	
	ability_image.texture = load("res://mods-unpacked/RomatoPotato-Abilitato/resources/icons/fire.png")
	
	label.add_font_override("font", load("res://resources/fonts/actual/base/font_biggest.tres"))
	label.text = str(cd)
	
	life_container.add_child_below_node(_ui_bonus_gold, ability_image)
	life_container.add_child_below_node(ability_image, label)
	
	bullet_data = load("res://mods-unpacked/RomatoPotato-Abilitato/resources/abilities/bullet_shot/bullet_shot_data.tres")
	
func _process(delta):	
	if Input.is_key_pressed(KEY_SPACE) && cd <= 0:
		for n in range(20):
			var pos = _player.transform.origin
			var projectile = Utils.instance_scene_on_main(bullet_data.stats.projectile_scene, pos)
			var rotation = rot
			var weapon_stats = bullet_data.stats
			var damage_tracking_key = ""
			var knockback_direction = Vector2.ONE.rotated(rotation)
			
			projectile.spawn_position = pos
			projectile.set_effects([])
			projectile.velocity = Vector2.RIGHT.rotated(rotation) * weapon_stats.projectile_speed
			projectile.rotation = projectile.velocity.angle()
			projectile.set_damage_tracking_key(damage_tracking_key)
			projectile.weapon_stats = weapon_stats.duplicate()
			projectile.set_damage(weapon_stats.damage, weapon_stats.accuracy, weapon_stats.crit_chance, weapon_stats.crit_damage, weapon_stats.burning_data, weapon_stats.is_healing)
			projectile.set_knockback_vector(knockback_direction, weapon_stats.knockback)
			projectile.set_effect_scale(weapon_stats.effect_scale)
			rot += deg2rad(360 / 20)
		rot = 0
		cd = 1
	cd -= 0.01
	
	label.text = str(cd)

func reload_stats()->void :
	.reload_stats()
	
	if is_instance_valid(bullet_data):
		var base_stats = bullet_data.stats.duplicate()
		var new_stats = RangedWeaponStats.new()
		
		new_stats.projectile_scene = base_stats.projectile_scene
		new_stats.max_range = base_stats.max_range
		new_stats.damage = base_stats.damage
		new_stats.damage = max(1, round(new_stats.damage * (1 + (Utils.get_stat("stat_percent_damage") / 100))))
		
		bullet_data.stats = new_stats
