extends "res://singletons/item_service.gd"

var abilities = []

var spawned_abilities:Array
var spawn_chance = 0.05
var spawn_chance_reduction = 1.5

var starting_spawn_chance = spawn_chance

var TIER_DATA_ABILITIES = TierData.size()

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")
var AbilityData = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/ability_data.gd")


func reset_tiers_data()->void :
	.reset_tiers_data()

	# this code from item_service.gd, i just added ability_to_spawn arrays to _tiers_data array
	_tiers_data = [
		[[], [], [], [], [], 0, 1.0, 0.0, 1.0, []], 
		[[], [], [], [], [], 0, 0.0, 0.06, 0.6, []], 
		[[], [], [], [], [], 2, 0.0, 0.02, 0.25, []], 
		[[], [], [], [], [], 6, 0.0, 0.0023, 0.08, []]
	]


func init_unlocked_pool()->void :
	.init_unlocked_pool()
	
	for ability in abilities:
		_tiers_data[ability.tier][TierData.ALL_ITEMS].push_back(ability)
		_tiers_data[ability.tier][TIER_DATA_ABILITIES].push_back(ability)

	#for i in range(_tiers_data.size()):
	#	for j in range(_tiers_data[i].size()):
	#		if _tiers_data[i][j] is Array and _tiers_data[i][j].size() > 0:
	#			for ability in _tiers_data[i][j]:
	#				if ability is AbilityData:
	#					ModLoaderLog.info(str(ability.my_id), "ID")
	#					ModLoaderLog.info(str(i), "i")
	#					ModLoaderLog.info(str(j), "j")


func get_shop_items(wave:int, number:int = NB_SHOP_ITEMS, shop_items:Array = [], locked_items:Array = [])->Array:
	if GameModeManager.current_gamemode_is_ability():
		spawned_abilities = []
		spawn_chance = starting_spawn_chance

	return .get_shop_items(wave, number, shop_items, locked_items)


func get_rand_item_from_wave(wave:int, type:int, shop_items:Array = [], prev_shop_items:Array = [], fixed_tier:int = - 1)->ItemParentData:
	var current_item_to_spawn = .get_rand_item_from_wave(wave, type, shop_items, prev_shop_items, fixed_tier)

	if GameModeManager.current_gamemode_is_ability():
		if randf() > (1 - spawn_chance):
			var item_tier = clamp(get_tier_from_wave(wave), RunData.effects["min_weapon_tier"], RunData.effects["max_weapon_tier"])
			var pool = get_pool(item_tier, TIER_DATA_ABILITIES)

			spawn_chance /= spawn_chance_reduction

			var ability_to_spawn = Utils.get_rand_element(pool)

			for ability in spawned_abilities:
				if ability == ability_to_spawn:
					return current_item_to_spawn

			spawned_abilities.push_back(ability_to_spawn)

			return ability_to_spawn
	
	return current_item_to_spawn


func process_item_box(wave:int, _consumable_data:ConsumableData, fixed_tier:int = - 1)->ItemParentData:
	# code below to prevent abilities from dropping out of crates
	if GameModeManager.current_gamemode_is_ability():
		while true:
			var box_item = .process_item_box(wave, _consumable_data, fixed_tier)

			ModLoaderLog.info(str(box_item.my_id), "ITEM_BOX_ITEM")
			
			if not box_item is AbilityData:
				return box_item

	return .process_item_box(wave, _consumable_data, fixed_tier)
