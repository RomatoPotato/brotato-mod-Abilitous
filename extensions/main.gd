extends "res://main.gd"

var abilities_selector
var selector_default = true

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")
var hud_size


func _ready():
	if GameModeManager.current_gamemode_is_ability():
		hud_size = _hud.rect_size.y
		_hud.rect_size.y = 1080
		
		init_abilities_selector()

		_pause_menu._menus.get_node("AbilitiesControlsOptions").connect("abilities_controls_changed", self, "on_abilities_controls_changed")


func init_abilities_selector():
	if _hud.get_child_count() > 0:
		_hud.remove_child(abilities_selector)

	match ProgressData.current_selector_appearance:
		1:
			abilities_selector = load("res://mods-unpacked/RomatoPotato-Abilitato/ui/abilities_selector/variants/abilities_selector_2.tscn").instance()
		_:
			abilities_selector = load("res://mods-unpacked/RomatoPotato-Abilitato/ui/abilities_selector/variants/abilities_selector.tscn").instance()


	_hud.add_child(abilities_selector)

	for ability in RunData.abilities:
		abilities_selector.add_ability(ability, _player)

	abilities_selector.load_cooldowns(RunData.abilities_cooldowns)


func on_abilities_controls_changed():
	RunData.abilities_cooldowns = abilities_selector.save_cooldowns()
	init_abilities_selector()
	_player._movement_behavior.disable_busy_arrows()


func _process(_delta):
	if GameModeManager.current_gamemode_is_ability():
		abilities_selector.display_cooldown()


func _physics_process(_delta):
	if GameModeManager.current_gamemode_is_ability() and not _cleaning_up:
		abilities_selector.activate_ability()


func reload_stats()->void :
	if GameModeManager.current_gamemode_is_ability():
		abilities_selector.reload_stats()

	.reload_stats()


func _on_player_died(_p_player:Player)->void :
	if GameModeManager.current_gamemode_is_ability():
		abilities_selector.free_all_containers()
		abilities_selector.hide()
	
	._on_player_died(_p_player)


func _on_WaveTimer_timeout()->void :
	if GameModeManager.current_gamemode_is_ability():
		_hud.rect_size.y = hud_size
		abilities_selector.hide()

	._on_WaveTimer_timeout()


func clean_up_room(is_last_wave:bool = false, is_run_lost:bool = false, is_run_won:bool = false)->void :
	.clean_up_room(is_last_wave, is_run_lost, is_run_won)

	if GameModeManager.current_gamemode_is_ability():
		RunData.abilities_cooldowns = abilities_selector.save_cooldowns()
