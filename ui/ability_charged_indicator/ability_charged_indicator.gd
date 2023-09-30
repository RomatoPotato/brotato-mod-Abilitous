extends Control

onready var ability_texture = $"CenterContainer/TextureRect"
onready var animation_player = $"AnimationPlayer"

var abilities_selector


func init(_abilities_selector):
	abilities_selector = _abilities_selector


func trigger(ability:Node2D):
	if animation_player.is_playing():
		animation_player.stop(true)

	ability_texture.texture = abilities_selector.get_ability_data(ability).icon
	animation_player.play("ability_charged")

