extends Node

const MOD_DIR = "RomatoPotato-Abilitious/"

var dir = ""
var ext_dir = ""
var trans_dir = ""
var abilities_dir = ""

func _init(_modLoader = ModLoader):
	dir = ModLoaderMod.get_unpacked_dir() + MOD_DIR
	ext_dir = dir + "extensions/"
	trans_dir = dir + "translations/"
	abilities_dir = dir + "abilities/all/"

	# Add extensions
	ModLoaderMod.install_script_extension(ext_dir + "main.gd")
	
	ModLoaderMod.install_script_extension(ext_dir + "singletons/run_data.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/menu_data.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/item_service.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/progress_data.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/challenge_service.gd")

	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/menus.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/pages/main_menu.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/ingame/ingame_main_menu.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/run/end_run.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/run/difficulty_selection/difficulty_selection.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/shop/item_description.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/global/focus_manager.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/shop/item_popup.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/pages/menu_choose_options.gd")
	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/shop/shop_items_container.gd")

	ModLoaderMod.install_script_extension(ext_dir + "entities/units/player/player.gd")
	ModLoaderMod.install_script_extension(ext_dir + "entities/units/movement_behaviors/player_movement_behavior.gd")

	ModLoaderMod.new().call_deferred("install_script_extension", ext_dir + "global/entity_spawner.gd")
	
	ModLoaderMod.new().call_deferred("install_script_extension", ext_dir + "ui/menus/shop/shop.gd")

	# Add translations
	ModLoaderMod.add_translation(trans_dir + "abilitious.en.translation")
	ModLoaderMod.add_translation(trans_dir + "abilitious.ru.translation")


func _ready():
	ItemService.abilities.push_back(load(abilities_dir + "bullet_shot/1/bullet_shot_data.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "bullet_shot/2/bullet_shot_data_2.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "bullet_shot/3/bullet_shot_data_3.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "bullet_shot/4/bullet_shot_data_4.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "fire_shot/1/fire_shot_data.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "fire_shot/2/fire_shot_data_2.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "fire_shot/3/fire_shot_data_3.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "fire_shot/4/fire_shot_data_4.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "sociophobe/1/sociofobe_data.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "sociophobe/2/sociofobe_data_2.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "sociophobe/3/sociofobe_data_3.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "sociophobe/4/sociofobe_data_4.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "friend_of_the_forest/1/friend_of_the_forest_data.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "friend_of_the_forest/2/friend_of_the_forest_data_2.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "friend_of_the_forest/3/friend_of_the_forest_data_3.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "friend_of_the_forest/4/friend_of_the_forest_data_4.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "bubblegum/2/bubblegum_data_2.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "bubblegum/3/bubblegum_data_3.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "bubblegum/4/bubblegum_data_4.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "first_aid_kit/1/first_aid_kit_data.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "first_aid_kit/2/first_aid_kit_data_2.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "first_aid_kit/3/first_aid_kit_data_3.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "first_aid_kit/4/first_aid_kit_data_4.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "bloodlust/2/bloodlust_data_2.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "bloodlust/3/bloodlust_data_3.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "bloodlust/4/bloodlust_data_4.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "hourglass/3/hourglass_data_3.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "hourglass/4/hourglass_data_4.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "antisapper/1/antisapper_data.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "antisapper/2/antisapper_data_2.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "antisapper/3/antisapper_data_3.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "antisapper/4/antisapper_data_4.tres"))
	ItemService.abilities.push_back(load(abilities_dir + "emergency_support/4/emergency_support_data_4.tres"))
