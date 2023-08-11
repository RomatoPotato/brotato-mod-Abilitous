extends Node

const MOD_DIR = "RomatoPotato-Abilitato/"

var dir = ""
var ext_dir = ""
var trans_dir = ""

func _init(_modLoader = ModLoader):
	dir = ModLoaderMod.get_unpacked_dir() + MOD_DIR
	ext_dir = dir + "extensions/"
	trans_dir = dir + "translations/"

	# Add extensions
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/pages/main_menu.gd")
	ModLoaderMod.install_script_extension(ext_dir + "main.gd")
	ModLoaderMod.install_script_extension(ext_dir + "entities/units/player/player.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/run_data.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/ingame/ingame_main_menu.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/run/end_run.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/menu_data.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/item_service.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/run/difficulty_selection/difficulty_selection.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/shop/item_description.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/global/focus_manager.gd")
	ModLoaderMod.install_script_extension(ext_dir + "entities/units/movement_behaviors/player_movement_behavior.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/progress_data.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/shop/item_popup.gd")
	
	ModLoaderMod.new().call_deferred("install_script_extension", ext_dir + "ui/menus/shop/shop.gd")

	# Add translations
	ModLoaderMod.add_translation(trans_dir + "abilitato.en.translation")
	ModLoaderMod.add_translation(trans_dir + "abilitato.ru.translation")


func _ready():
	ItemService.abilities.push_back(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/bullet_shot/1/bullet_shot_data.tres"))
	ItemService.abilities.push_back(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/bullet_shot/2/bullet_shot_data_2.tres"))
	ItemService.abilities.push_back(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/bullet_shot/3/bullet_shot_data_3.tres"))
	ItemService.abilities.push_back(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/bullet_shot/4/bullet_shot_data_4.tres"))
	ItemService.abilities.push_back(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/fire_shot/1/fire_shot_data.tres"))
	ItemService.abilities.push_back(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/fire_shot/2/fire_shot_data_2.tres"))
	ItemService.abilities.push_back(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/fire_shot/3/fire_shot_data_3.tres"))
	ItemService.abilities.push_back(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/fire_shot/4/fire_shot_data_4.tres"))
