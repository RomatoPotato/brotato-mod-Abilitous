extends KinematicBody2D


func _on_Hurtbox_area_entered(hitbox):
	hitbox.hit_something(self, 0)
