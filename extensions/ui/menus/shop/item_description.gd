extends "res://ui/menus/shop/item_description.gd"

var AbilityData = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/ability_data.gd")


func set_item(item_data:ItemParentData)->void :
	get_effects().show()

	if item_data is AbilityData:
		_category.text = "Ability"
		
		var tier_number = ItemService.get_tier_number(item_data.tier)
		_name.text = tr(item_data.name) + (" " + tier_number if tier_number != "" else "")
		_name.modulate = ItemService.get_color_from_tier(item_data.tier)
		
		_icon.texture = item_data.icon
		
		get_weapon_stats().show()
		get_weapon_stats().bbcode_text = item_data.get_ability_stats_text()
		get_effects().bbcode_text = item_data.get_ability_desc_text()
		
		return

	.set_item(item_data)
