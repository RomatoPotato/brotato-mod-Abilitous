extends "res://ui/menus/shop/item_description.gd"

func set_item(item_data:ItemParentData)->void :

    if item_data is AbilityData:
        _category.text = "Ability"
        var tier_number = ItemService.get_tier_number(item_data.tier)
        _name.text = tr(item_data.name) + (" " + tier_number if tier_number != "" else "")
        _icon.texture = item_data.icon
        return

    .set_item(item_data)