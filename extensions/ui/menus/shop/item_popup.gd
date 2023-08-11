extends "res://ui/menus/shop/item_popup.gd"

var AbilityData = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/ability_data.gd")

func display_element(element:InventoryElement)->void :
    .display_element(element)
    
    if element.item is AbilityData and buttons_active:
        _combine_button.show()
        if not RunData.can_combine_ability(element.item):
            _combine_button.hide()
        _discard_button.show()
        _cancel_button.show()
