extends "res://singletons/progress_data.gd"

var cursor_pos

var CURSOR_POS_PATH

var ability_actions = {
	"ability1": KEY_UP,
	"ability2": KEY_RIGHT,
	"ability3": KEY_DOWN,
	"ability4": KEY_LEFT
}

var current_selector_appearance = 0
var tier_indicator = true
var ability_charged_indicator = true

var abilities_selector_appearances = {
	"DEFAULT": "res://mods-unpacked/RomatoPotato-Abilitious/ui/abilities_selector/variants/variant_1.png",
	"SEPARATE_COOLDOWN": "res://mods-unpacked/RomatoPotato-Abilitious/ui/abilities_selector/variants/variant_2.png"
}


func serialize_run_state()->Dictionary:
	var serialized_run_state = .serialize_run_state()

	serialized_run_state.abilities = []

	for ability in current_run_state.abilities:
		serialized_run_state.abilities.push_back(ability.my_id)

	return serialized_run_state


func deserialize_run_state(state:Dictionary)->Dictionary:
	var deserialized_run_state = .deserialize_run_state(state)
	
	deserialized_run_state.abilities = []

	if state.has("abilities"):
		for ability_id in state.abilities:
			var ability_data = ItemService.get_element(ItemService.abilities, ability_id)
			deserialized_run_state.abilities.push_back(ability_data)

	return deserialized_run_state


func init_settings()->void :
	.init_settings()

	settings.merge({
		"ability_actions": ability_actions,
		"current_selector_appearance": current_selector_appearance,
		"tier_indicator": tier_indicator,
		"ability_charged_indicator": ability_charged_indicator
	})


func apply_settings()->void :
	ability_actions = settings.ability_actions
	current_selector_appearance = settings.current_selector_appearance
	tier_indicator = settings.tier_indicator
	ability_charged_indicator = settings.ability_charged_indicator

	.apply_settings()
