extends MovementBehavior

const MIN_DISTANCE_TO_ENEMY = 150

var entity_spawner

var current_target:Enemy


func _ready():
	entity_spawner = get_tree().current_scene.get_node("EntitySpawner")


func get_movement()->Vector2:
	current_target = get_new_target()
	
	if current_target == null or not is_instance_valid(current_target) or current_target.dead:	
		return Vector2.ZERO
	
	# code below is taken from stay_in_range_from_player_movement_behavior.gd
	var dir = (_parent.global_position - current_target.global_position).normalized()
	
	var target_position = current_target.global_position + MIN_DISTANCE_TO_ENEMY * dir
	
	if Utils.vectors_approx_equal(target_position, _parent.global_position, EQUALITY_PRECISION):
		return Vector2.ZERO
	else :
		return target_position - _parent.global_position
	#end


func get_new_target() -> Enemy:
	if not is_instance_valid(entity_spawner):
		return null

	var nearest_pos:float = 1000000
	var nearest_enemy:Enemy = null

	for enemy in entity_spawner.get_all_enemies():
		if is_instance_valid(enemy):
			var distance = enemy.global_position.distance_to(_parent.global_position)

			if distance < nearest_pos:
				nearest_pos = distance
				nearest_enemy = enemy

	return nearest_enemy
