extends "res://ui/menus/shop/shop_items_container.gd"

var ModCategory = load("res://mods-unpacked/RomatoPotato-Abilitato/utils/mod_category.gd")


func on_shop_item_buy_button_pressed(shop_item:ShopItem)->void :
	if shop_item.item_data.get_category() == ModCategory.ABILITY and not RunData.has_ability_slot_available():
		return

	.on_shop_item_buy_button_pressed(shop_item)
