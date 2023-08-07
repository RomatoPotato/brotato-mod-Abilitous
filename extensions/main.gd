extends "res://main.gd"

var abilities_selector

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")
var hud_size


func _ready():
	if GameModeManager.current_gamemode_is_ability():
		abilities_selector = load("res://mods-unpacked/RomatoPotato-Abilitato/resources/ui/abilities_selector.tscn").instance()

		hud_size = _hud.rect_size.y
		_hud.rect_size.y = 1080
		_hud.add_child(abilities_selector)

		for ability in RunData.abilities:
			abilities_selector.add_ability(ability, _player)

		abilities_selector.load_cooldowns(RunData.abilities_cooldowns)


func _process(_delta):
	if GameModeManager.current_gamemode_is_ability():
		abilities_selector.display_cooldown()


func _on_player_died(_p_player:Player)->void :
	if GameModeManager.current_gamemode_is_ability():
		abilities_selector.free_all_containers()
	
	._on_player_died(_p_player)


func _on_EndWaveTimer_timeout()->void :
	if GameModeManager.current_gamemode_is_ability():
		_hud.rect_size.y = hud_size
		abilities_selector.hide()

	._on_EndWaveTimer_timeout()


func _physics_process(_delta):
	if GameModeManager.current_gamemode_is_ability() and not _cleaning_up:
		abilities_selector.activate_ability()


func clean_up_room(is_last_wave:bool = false, is_run_lost:bool = false, is_run_won:bool = false)->void :
	.clean_up_room(is_last_wave, is_run_lost, is_run_won)

	RunData.abilities_cooldowns = abilities_selector.save_cooldowns()
