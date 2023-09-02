extends "res://main.gd"

var abilities_selector
var selector_default = true

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/gamemode_manager.gd")
var hud_size
var ability_screen_indicator


func _ready():
	if GameModeManager.current_gamemode_is_ability():
		ability_screen_indicator = load("res://mods-unpacked/RomatoPotato-Abilitato/ui/ability_screen_indicator/ability_screen_indicator.tscn").instance()
		$"UI".add_child_below_node(_damage_vignette, ability_screen_indicator)
		
		hud_size = _hud.rect_size.y
		_hud.rect_size.y = 1080
		
		init_abilities_selector()

		_pause_menu._menus.get_node("AbilitiesControlsOptions").connect("abilities_controls_changed", self, "on_abilities_controls_changed")


func init_abilities_selector():
	if abilities_selector:
		_hud.remove_child(abilities_selector)

	match ProgressData.current_selector_appearance:
		1:
			abilities_selector = load("res://mods-unpacked/RomatoPotato-Abilitato/ui/abilities_selector/variants/abilities_selector_2.tscn").instance()
		_:
			abilities_selector = load("res://mods-unpacked/RomatoPotato-Abilitato/ui/abilities_selector/variants/abilities_selector.tscn").instance()

	_hud.add_child(abilities_selector)

	for ability in RunData.abilities:
		abilities_selector.add_ability(ability, _player)

	for container in abilities_selector.current_abilities:
		if abilities_selector.current_abilities[container]:
			abilities_selector.current_abilities[container].connect("temp_effect_applied", self, "on_temp_effect_applied")
			abilities_selector.current_abilities[container].connect("temp_effect_unapplied", self, "on_temp_effect_unapplied")

	abilities_selector.load_cooldowns(RunData.abilities_cooldowns)


func on_temp_effect_applied(ability_id:String):
	match ability_id:
		"bloodlust":
			ability_screen_indicator.color = "#c30707"
	
	ability_screen_indicator.darkening()


func on_temp_effect_unapplied(_ability_id:String):
	ability_screen_indicator.lightening()


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

	
func on_consumable_picked_up(consumable:Node)->void :
	_player.on_consumable_picked_up()
	.on_consumable_picked_up(consumable)


func _on_player_died(_p_player:Player)->void :
	if GameModeManager.current_gamemode_is_ability():
		abilities_selector.free_all_containers()
		abilities_selector.hide()
	
	._on_player_died(_p_player)

	
func _on_enemy_died(enemy:Enemy)->void :
	if GameModeManager.current_gamemode_is_ability():
		if not _cleaning_up:
			_player.emit_signal("enemy_died")

	._on_enemy_died(enemy)


func _on_WaveTimer_timeout()->void :
	if GameModeManager.current_gamemode_is_ability():
		abilities_selector.stop_timers()

	._on_WaveTimer_timeout()


func _on_EndWaveTimer_timeout() -> void:
	if GameModeManager.current_gamemode_is_ability():
		_hud.rect_size.y = hud_size
		abilities_selector.hide()

	._on_EndWaveTimer_timeout()


func clean_up_room(is_last_wave:bool = false, is_run_lost:bool = false, is_run_won:bool = false)->void :
	.clean_up_room(is_last_wave, is_run_lost, is_run_won)

	if GameModeManager.current_gamemode_is_ability():
		RunData.abilities_cooldowns = abilities_selector.save_cooldowns()
