extends "res://ui/menus/shop/shop_items_container.gd"


func on_shop_item_buy_button_pressed(shop_item:ShopItem)->void :
    var player_has_ability = false
	
    for ability in RunData.abilities:
        if ability.my_id == shop_item.item_data.my_id:
            player_has_ability = true
            break

    if (shop_item.item_data.get_category() == 10
        and not RunData.has_ability_slot_available()
        and (
            not player_has_ability
            or shop_item.item_data.upgrades_into == null
            or (RunData.mod_effects["max_ability_tier"] < shop_item.item_data.upgrades_into.tier)
           )
       ):
       return 

    .on_shop_item_buy_button_pressed(shop_item)