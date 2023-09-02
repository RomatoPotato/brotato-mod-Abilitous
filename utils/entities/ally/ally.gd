extends Unit
class_name Ally

var _current_attack_behavior:AttackBehavior

onready var _attack_behavior = $AttackBehavior
onready var _weapons_container = $WeaponsContainer


func _ready()->void :
	_current_attack_behavior = _attack_behavior


func init(zone_min_pos:Vector2, zone_max_pos:Vector2, player_ref:Node2D = null, entity_spawner_ref:EntitySpawner = null)->void :
	.init(zone_min_pos, zone_max_pos, player_ref, entity_spawner_ref)

	init_current_stats()
	
	_attack_behavior.init(self)


func _physics_process(delta):
	if dead:
		return
	
	_current_attack_behavior.physics_process(delta)


func start_shoot()->void :
	_current_attack_behavior.start_shoot()


func shoot()->void :
	_current_attack_behavior.shoot()

	
func die(knockback_vector:Vector2 = Vector2.ZERO, p_cleaning_up:bool = false)->void :
	.die(knockback_vector, p_cleaning_up)
	_weapons_container.queue_free()


func _on_hit_something(_thing_hit:Node, _damage_dealt:int)->void :
	add_decaying_speed( - 200)


func get_nb_weapons():
	return 1
