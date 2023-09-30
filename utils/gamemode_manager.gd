extends Node

enum GameMode {
	DEFAULT,
	ABILITY
}


static func change_gamemode(gamemode:int, resume = false) -> void:
	match gamemode:
		GameMode.DEFAULT:
			MenuData.difficulty_selection_scene = MenuData.current_difficulty_selection_scene
			pass
		GameMode.ABILITY:
			if not current_gamemode_is_ability() && !resume:
				RunData.effects["number_of_enemies"] += 15
				RunData.effects["map_size"] += 20
				RunData.effects["enemy_health"] += 10
				RunData.effects["enemy_damage"] -= 10

			MenuData.difficulty_selection_scene = MenuData.ability_selection_scene
			pass


static func current_gamemode_is_ability() -> bool:
	return MenuData.difficulty_selection_scene == MenuData.ability_selection_scene
