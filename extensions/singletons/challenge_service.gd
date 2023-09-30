extends "res://singletons/challenge_service.gd"

var GameModeManager = load("res://mods-unpacked/RomatoPotato-Abilitious/utils/gamemode_manager.gd")


func complete_challenge(chal_id:String)->void :
    if GameModeManager.current_gamemode_is_ability():
        return

    .complete_challenge(chal_id)