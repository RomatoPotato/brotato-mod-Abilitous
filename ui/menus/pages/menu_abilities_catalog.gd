extends MarginContainer

signal back_button_pressed

onready var abilities = $"VBoxContainer/HBoxContainer/ScrollContainer/MarginContainer/Inventory"
onready var ability_panel = $"VBoxContainer/HBoxContainer/AbilityData/VBoxContainer/ItemPanelUI"
onready var meme = $"VBoxContainer/HBoxContainer/AbilityData/VBoxContainer/MemeContainer"


func _ready():
	var all_abilities = get_min_tier_abilities()

	abilities.set_elements(all_abilities)
	abilities.add_special_element(load("res://items/global/random_icon.png"))
	
	var _error_focused = abilities.connect("element_focused", self, "on_element_focused")
	var _error_hovered = abilities.connect("element_hovered", self, "on_element_focused")

	for cell in abilities.get_children():
		cell.set_custom_minimum_size(cell.get_size() * 1.2)


func init() -> void:
	abilities.focus_element_index(0)


func get_min_tier_abilities() -> Array:
	var min_tier_abilities = []
	var added_abilities_ids = []

	for ability in ItemService.abilities:
		var has_id = false

		for ability_id in added_abilities_ids:
			if ability_id == ability.ability_id:
				has_id = true
				break

		if !has_id:
			min_tier_abilities.push_back(ability)
			added_abilities_ids.push_back(ability.ability_id)

	min_tier_abilities.sort_custom(self, "sort_by_tier_comparison")	

	return min_tier_abilities


func sort_by_tier_comparison(a, b):
	return a.tier < b.tier


func _on_BackButton_pressed():
	emit_signal("back_button_pressed")


func on_element_focused(element:InventoryElement)->void :
	if element.item == null:
		ability_panel.hide()
		meme.show()
	else:
		ability_panel.show()
		meme.hide()
		ability_panel.set_data(element.item)

