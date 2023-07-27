extends "res://singletons/run_data.gd"

var abilities:Array
var mod_effects:Dictionary = {
	"ability_slot": 4
}

var holding_ability


func add_ability(ability:WeaponData)->WeaponData:
	var new_ability = ability.duplicate()

	abilities.push_back(new_ability)

	return new_ability

# this func for prevent an error because abilities are weapons (abilities haven't pos)
func add_weapon_dmg_dealt(pos:int, dmg_dealt:int)->void :
	if pos == -1:
		return
	
	.add_weapon_dmg_dealt(pos, dmg_dealt)


func reset(restart:bool = false)->void :
	abilities = []

	.reset(restart)
