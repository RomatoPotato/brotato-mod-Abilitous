extends "res://ui/menus/global/focus_manager.gd"

func init_abilities_container(abilities_container:InventoryContainer = null) -> void :
    if abilities_container:
        connect_inventory_signals(abilities_container._elements)