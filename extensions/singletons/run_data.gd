extends "res://singletons/run_data.gd"

var abilities:Array

func add_ability(ability:WeaponData)->WeaponData:
	var new_ability = ability.duplicate()

	abilities.push_back(new_ability)

	return new_ability


func add_weapon_dmg_dealt(pos:int, dmg_dealt:int)->void :
	if pos == -1:
		return
	
	.add_weapon_dmg_dealt(pos, dmg_dealt)