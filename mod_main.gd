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
	ModLoaderMod.install_script_extension("res://mods-unpacked/RomatoPotato-Abilitato/extensions/ui/menus/pages/main_menu.gd")
	ModLoaderMod.install_script_extension("res://mods-unpacked/RomatoPotato-Abilitato/extensions/main.gd")
	ModLoaderMod.install_script_extension("res://mods-unpacked/RomatoPotato-Abilitato/extensions/entities/units/player/player.gd")
	ModLoaderMod.install_script_extension("res://mods-unpacked/RomatoPotato-Abilitato/extensions/singletons/run_data.gd")

	# Add translations
	# modLoader.add_translation_from_resource(trans_dir + "modname_text.en.translation")

func _ready():
	RunData.add_ability(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/bullet_shot/bullet_shot_data.tres"))
	RunData.add_ability(load("res://mods-unpacked/RomatoPotato-Abilitato/abilities/all/fire_shot/fire_shot_data.tres"))