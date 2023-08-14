extends "res://singletons/progress_data.gd"

var cursor_pos

var CURSOR_POS_PATH

var ability_actions = {
	"ability1": KEY_UP,
	"ability2": KEY_RIGHT,
	"ability3": KEY_DOWN,
	"ability4": KEY_LEFT
}


func init_save_paths()->void :
	.init_save_paths()

	CURSOR_POS_PATH = "user://" + get_user_id() + "/cursor_pos.txt"


func save(path:String = SAVE_PATH)->void :
	.save(path)

	#var save_file = File.new()
	#var error = save_file.open(path, File.READ_WRITE)
#
	#if error != OK:
	#	return
#
	#save_file.seek_end(0)
#
	#cursor_pos = save_file.get_position()
#
	#save_file.store_line("SMTH")
	#save_file.close()
#
	#ModLoaderLog.info(str(cursor_pos), "POS_SET")
#
	#var cursor_pos_file = File.new()
	#cursor_pos_file.open(CURSOR_POS_PATH, File.WRITE)
	#cursor_pos_file.store_line(str(cursor_pos))
	#cursor_pos_file.close()



func load_game_file(path:String = SAVE_PATH)->void :
	.load_game_file(path)
	
	#var cursor_pos_file = File.new()
	#cursor_pos_file.open(CURSOR_POS_PATH, File.READ)
#
	#cursor_pos = int(cursor_pos_file.get_line())
#
	#cursor_pos_file.close()
#
	#ModLoaderLog.info(str(cursor_pos), "POS_GET")
#
	#if cursor_pos != 0:
	#	var save_file = File.new()
	#	
	#	if not save_file.file_exists(path) or DebugService.reinitialize_save:
	#		print("No save loaded, create new.")
	#		save()
	#		return 
	#	
	#	save_file.open(path, File.READ)
	#	save_file.seek(cursor_pos)
	#	var strget = save_file.get_line()
	#	ModLoaderLog.info(str(strget), "GET")


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
		"ability_actions": ability_actions
	})


func apply_settings()->void :
	ability_actions = settings.ability_actions

	.apply_settings()
