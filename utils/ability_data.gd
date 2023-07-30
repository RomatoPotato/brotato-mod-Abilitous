class_name AbilityData
extends ItemParentData

export (String) var ability_id = ""
export (PackedScene) var scene = null
export (Resource) var stats = null
export (Resource) var upgrades_into
export (String) var description = ""

func get_ability_stats_text() -> String :
	return stats.get_text()


func get_ability_desc_text() -> String :
	var text = ""

	text += description

	return text