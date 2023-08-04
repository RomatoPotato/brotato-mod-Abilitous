extends Node

enum GameMode {
	DEFAULT,
	ABILITY
}


static func change_gamemode(gamemode:int) -> void:
	match gamemode:
		GameMode.DEFAULT:
			MenuData.difficulty_selection_scene = MenuData.current_difficulty_selection_scene
			pass
		GameMode.ABILITY:
			MenuData.difficulty_selection_scene = MenuData.ability_selection_scene
			pass


static func current_gamemode_is_ability() -> bool:
	return MenuData.difficulty_selection_scene == MenuData.ability_selection_scene
