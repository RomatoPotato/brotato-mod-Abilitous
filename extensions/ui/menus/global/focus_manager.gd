extends "res://ui/menus/global/focus_manager.gd"

var AbilityData = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/ability_data.gd")

func init_abilities_container(abilities_container:InventoryContainer = null) -> void :
    if abilities_container:
        connect_inventory_signals(abilities_container._elements)


func on_element_pressed(element:InventoryElement)->void :
    if element.item is AbilityData and _item_popup and _item_popup.buttons_active:
        emit_signal("element_pressed", element)
        
        _element_hovered = element
        _element_focused = element
        _element_pressed = element
        _item_popup.display_element(element)
        _item_popup.focus()
        return

    .on_element_pressed(element)