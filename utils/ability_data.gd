extends ItemParentData

export (String) var ability_id = ""
export (PackedScene) var scene = null
export (Resource) var stats = null
export (Resource) var upgrades_into
export (String) var description = ""

var ModCategory = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/mod_category.gd")
var AbilityService = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/ability_service.gd")


func get_category()->int:
	return ModCategory.ABILITY


func get_ability_stats_text() -> String :
	var current_stats = AbilityService.new().init_stats(stats, effects)

	return current_stats.get_text(stats)


func get_ability_desc_text() -> String :
	return stats.col_desc_a + tr(description) + stats.col_b


func get_effects_text():
	return .get_effects_text()
