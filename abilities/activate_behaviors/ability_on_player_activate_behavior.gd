extends "res://mods-unpacked/RomatoPotato-Abilitious/abilities/activate_behaviors/ability_activate_behavior.gd"

export (Resource) var entity
var instance


func release_projectile(_angle:float)-> void :
	instance = entity.instance()
	
	instance.get_node("DurationTimer").wait_time = _parent.current_stats.duration

	_parent.player.add_child(instance)

	instance.get_node("AnimationPlayer").connect("animation_finished", self, "on_animation_finished")
	instance.get_node("DurationTimer").connect("timeout", self, "on_DurationTimer_timeout")


func on_animation_finished(name:String):
	match name:
		"show":
			instance.get_node("AnimationPlayer").play("idle")
		"destroy":
			_parent.player.remove_child(instance)


func on_DurationTimer_timeout():
	instance.get_node("AnimationPlayer").play("destroy")
