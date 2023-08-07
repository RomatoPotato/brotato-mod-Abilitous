extends "res://singletons/run_data.gd"

var abilities:Array
var mod_effects:Dictionary = {
	"ability_slot": 4
}

var starting_ability
var abilities_cooldowns = []

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")


func add_ability(ability:ItemParentData) -> void:
	var new_ability = ability.duplicate()

	abilities.push_back(new_ability)


func reset(restart:bool = false)->void :
	abilities = []
	abilities_cooldowns = []

	if restart:
		abilities.push_back(starting_ability)

	.reset(restart)


func has_ability_slot_available()->bool:
	return abilities.size() < mod_effects["ability_slot"]


func get_state(
		reset:bool = false, 
		shop_items:Array = [], 
		reroll_price:int = 0, 
		last_reroll_price:int = 0, 
		initial_free_rerolls:int = 0, 
		free_rerolls:int = 0
	)->Dictionary:

	var mod_state = {
		"abilities": abilities.duplicate(),
		"starting_ability": starting_ability.my_id if starting_ability != null else "",
		"abilities_cooldowns": abilities_cooldowns
	}

	var curr_state = .get_state(reset, shop_items, reroll_price, last_reroll_price, initial_free_rerolls, free_rerolls)
	curr_state.merge(mod_state)
	
	return curr_state


func resume_from_state(state:Dictionary)->void :
	.resume_from_state(state)

	if state.has("abilities"):
		if state.abilities.size() > 0:
			GameModeManager.change_gamemode(GameModeManager.GameMode.ABILITY)
		
		abilities = state.abilities

	if state.has("starting_ability"):
		starting_ability = ItemService.get_element(ItemService.abilities, state.starting_ability)

	if state.has("abilities_cooldowns"):
		abilities_cooldowns = state.abilities_cooldowns
