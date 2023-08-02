extends "res://singletons/item_service.gd"

var abilities = []

var spawned_abilities:Array
var spawn_chance = 0.05
var spawn_chance_reduction = 1.5

var starting_spawn_chance = spawn_chance

var TIER_DATA_ABILITIES = TierData.size()

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
		_tiers_data[ability.tier][TIER_DATA_ABILITIES].push_back(ability)
		_tiers_data[ability.tier][TIER_DATA_ABILITIES].push_back(ability)



func get_shop_items(wave:int, number:int = NB_SHOP_ITEMS, shop_items:Array = [], locked_items:Array = [])->Array:
	spawned_abilities = []
	spawn_chance = starting_spawn_chance

	return .get_shop_items(wave, number, shop_items, locked_items)


func get_rand_item_from_wave(wave:int, type:int, shop_items:Array = [], prev_shop_items:Array = [], fixed_tier:int = - 1)->ItemParentData:
	var current_item_to_spawn = .get_rand_item_from_wave(wave, type, shop_items, prev_shop_items, fixed_tier)

	if randf() > (1 - spawn_chance):
		spawn_chance /= spawn_chance_reduction

		var ability_to_spawn = Utils.get_rand_element(_tiers_data[0][TIER_DATA_ABILITIES])

		for ability in spawned_abilities:
			if ability == ability_to_spawn:
				return current_item_to_spawn

		spawned_abilities.push_back(ability_to_spawn)

		return ability_to_spawn
	else:
		return current_item_to_spawn
