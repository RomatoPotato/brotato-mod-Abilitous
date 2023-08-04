extends "res://singletons/run_data.gd"

var abilities:Array
var mod_effects:Dictionary = {
	"ability_slot": 4
}


func add_ability(ability:ItemParentData) -> void:
	var new_ability = ability.duplicate()

	abilities.push_back(new_ability)


func reset(restart:bool = false)->void :
	abilities = []

	.reset(restart)


func has_ability_slot_available()->bool:
	return abilities.size() < mod_effects["ability_slot"]
