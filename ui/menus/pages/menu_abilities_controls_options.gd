extends Control

signal back_button_pressed
signal abilities_controls_changed

onready var ability_1 = $"Options/GridContainer/Ability1"
onready var ability_2 = $"Options/GridContainer/Ability2"
onready var ability_3 = $"Options/GridContainer/Ability3"
onready var ability_4 = $"Options/GridContainer/Ability4"

onready var appearances_option_button = $"Options/ChangeAppearanceContainer/AppearanceOptionButton"
onready var appearance_image = $"Options/ChangeAppearanceContainer/AppearanceContainer/AppearanceImage"
onready var apperance_tier_indicator_check_button = $"Options/ChangeAppearanceContainer/TierIndicatorCheckButton"
onready var apperance_ability_charged_indicator_check_button = $"Options/ChangeAppearanceContainer/AbilityChargeIndicatorCheckButton"

var appearances_variants = []

var ready_for_assign = false
var assigned_key
var assignable_btn
var assignable_ability

var texture_hovered
var texture_chosed

var allowed_keys = [
	KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9, KEY_0, KEY_MINUS, KEY_EQUAL, KEY_UP, KEY_RIGHT, KEY_DOWN, KEY_LEFT,
	KEY_Q, KEY_W, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_U, KEY_I, KEY_O, KEY_P, KEY_BRACKETLEFT, KEY_BRACKETRIGHT, KEY_BACKSLASH,
	KEY_A, KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K, KEY_L, KEY_SEMICOLON, KEY_APOSTROPHE,
	KEY_Z, KEY_X, KEY_C, KEY_V, KEY_B, KEY_N, KEY_M, KEY_COMMA, KEY_PERIOD, KEY_SLASH,
	KEY_KP_0, KEY_KP_1, KEY_KP_2, KEY_KP_3, KEY_KP_4, KEY_KP_5, KEY_KP_6, KEY_KP_7, KEY_KP_8, KEY_KP_9, KEY_KP_0,
	KEY_KP_PERIOD, KEY_KP_ADD, KEY_KP_SUBTRACT, KEY_KP_DIVIDE, KEY_KP_MULTIPLY
]

var not_allowed_mouse_keys = [
	BUTTON_WHEEL_DOWN, BUTTON_WHEEL_LEFT, BUTTON_WHEEL_RIGHT, BUTTON_WHEEL_UP
]


func _ready():
	texture_hovered = load("res://mods-unpacked/RomatoPotato-Abilitious/ui/menus/pages/ability_settings_section_hovered.png")
	texture_chosed = load("res://mods-unpacked/RomatoPotato-Abilitious/ui/menus/pages/ability_settings_section_chosed.png")

	for appearance in ProgressData.abilities_selector_appearances:
		appearances_variants.push_back(ProgressData.abilities_selector_appearances[appearance])

	apperance_tier_indicator_check_button.pressed = ProgressData.tier_indicator
	apperance_ability_charged_indicator_check_button.pressed = ProgressData.ability_charged_indicator

	init_apperarance_options()


func init_apperarance_options():
	appearances_option_button.clear()
	for appearance in ProgressData.abilities_selector_appearances:
		appearances_option_button.add_item(tr(appearance))
	appearances_option_button.select(ProgressData.current_selector_appearance)

	_on_OptionButton_item_selected(ProgressData.current_selector_appearance)


func init() -> void:
	$BackButton.grab_focus()

	var ability1_code = int(ProgressData.ability_actions["ability1"])
	var ability2_code = int(ProgressData.ability_actions["ability2"])
	var ability3_code = int(ProgressData.ability_actions["ability3"])
	var ability4_code = int(ProgressData.ability_actions["ability4"])

	ability_1.get_node("Label").text = get_name_by_keycode(ability1_code) if allowed_keys.has(ability1_code) else get_name_by_btn_mouse_code(ability1_code)
	ability_2.get_node("Label").text = get_name_by_keycode(ability2_code) if allowed_keys.has(ability2_code) else get_name_by_btn_mouse_code(ability2_code)
	ability_3.get_node("Label").text = get_name_by_keycode(ability3_code) if allowed_keys.has(ability3_code) else get_name_by_btn_mouse_code(ability3_code)
	ability_4.get_node("Label").text = get_name_by_keycode(ability4_code) if allowed_keys.has(ability4_code) else get_name_by_btn_mouse_code(ability4_code)


func _input(event):
	if event is InputEventKey && ready_for_assign:
		assigned_key = event.scancode
		
		if assigned_key == KEY_ESCAPE:
			ready_for_assign = false
			switch_all_buttons()
			return

		if allowed_keys.has(assigned_key):
			assignable_btn.get_node("Label").text = get_name_by_keycode(assigned_key)
		else: return
	elif event is InputEventMouseButton && ready_for_assign:
		assigned_key = event.button_index

		if not not_allowed_mouse_keys.has(assigned_key):
			assignable_btn.get_node("Label").text = get_name_by_btn_mouse_code(assigned_key)
		else: return
	else:
		return
		
	ProgressData.ability_actions[assignable_ability] = assigned_key 
	ready_for_assign = false
	switch_all_buttons()


func _on_AbilitiesControlOptions_hide():
	emit_signal("abilities_controls_changed") # for check if the arrows (which are responsible for the player's movement) are busy

	ProgressData.settings.current_selector_appearance = ProgressData.current_selector_appearance
	ProgressData.settings.tier_indicator = ProgressData.tier_indicator
	ProgressData.settings.ability_charged_indicator = ProgressData.ability_charged_indicator

	ProgressData.save()


func _on_OptionButton_item_selected(index):
	var i = 0
	
	for key in ProgressData.abilities_selector_appearances:
		if i == index:
			ProgressData.current_selector_appearance = i
			appearance_image.texture = load(appearances_variants[i])
			break
		i += 1


func _on_CheckButton_toggled(button_pressed:bool):
	ProgressData.tier_indicator = button_pressed
	

func _on_AbilityChargeIndicatorCheckButton_toggled(button_pressed):
	ProgressData.ability_charged_indicator = button_pressed


func _on_AbilitiesControlOptions_visibility_changed():
	init_apperarance_options()	


func _on_BackButton_pressed():
	emit_signal("back_button_pressed")


func _on_Ability1_pressed():
	if ready_for_assign:
		return
	
	ready_for_assign = true
	assignable_btn = ability_1
	assignable_ability = "ability1"
	switch_all_buttons()


func _on_Ability2_pressed():
	if ready_for_assign:
		return

	ready_for_assign = true
	assignable_btn = ability_2
	assignable_ability = "ability2"
	switch_all_buttons()


func _on_Ability3_pressed():
	if ready_for_assign:
		return

	ready_for_assign = true
	assignable_btn = ability_3
	assignable_ability = "ability3"
	switch_all_buttons()


func _on_Ability4_pressed():
	if ready_for_assign:
		return

	ready_for_assign = true
	assignable_btn = ability_4
	assignable_ability = "ability4"
	switch_all_buttons()


func change_cell_color():
	if !assignable_btn: return

	if ready_for_assign:
		assignable_btn.texture_hover = texture_chosed
		assignable_btn.texture_focused = texture_chosed
	else:
		assignable_btn.texture_hover = texture_hovered
		assignable_btn.texture_focused = texture_hovered


func switch_all_buttons():
	if ready_for_assign:
		ability_1.focus_mode = FOCUS_NONE if assignable_btn != ability_1 else FOCUS_ALL
		ability_1.disabled = true if assignable_btn != ability_1 else false
		ability_2.focus_mode = FOCUS_NONE if assignable_btn != ability_2 else FOCUS_ALL
		ability_2.disabled = true if assignable_btn != ability_2 else false
		ability_3.focus_mode = FOCUS_NONE if assignable_btn != ability_3 else FOCUS_ALL
		ability_3.disabled = true if assignable_btn != ability_3 else false
		ability_4.focus_mode = FOCUS_NONE if assignable_btn != ability_4 else FOCUS_ALL
		ability_4.disabled = true if assignable_btn != ability_4 else false
	else:
		ability_1.focus_mode = FOCUS_ALL
		ability_1.disabled = false
		ability_2.focus_mode = FOCUS_ALL
		ability_2.disabled = false
		ability_3.focus_mode = FOCUS_ALL
		ability_3.disabled = false
		ability_4.focus_mode = FOCUS_ALL
		ability_4.disabled = false

	change_cell_color()


func get_name_by_keycode(code:int) -> String:
	var key_str = ""

	match code:
		KEY_MINUS:
			key_str = "-"
		KEY_EQUAL:
			key_str = "+"
		KEY_UP:
			key_str = "/\\"
		KEY_RIGHT:
			key_str = ">"
		KEY_DOWN:
			key_str = "\\/"
		KEY_LEFT:
			key_str = "<"
		KEY_BRACKETLEFT:
			key_str = "{"
		KEY_BRACKETRIGHT:
			key_str = "}"
		KEY_BACKSLASH:
			key_str = "\\"
		KEY_SEMICOLON:
			key_str = ";"
		KEY_APOSTROPHE:
			key_str = "'"
		KEY_COMMA:
			key_str = ","
		KEY_PERIOD:
			key_str = "."
		KEY_SLASH:
			key_str = "/"
		KEY_KP_0:
			key_str = "0 [N]"
		KEY_KP_1:
			key_str = "1 [N]"
		KEY_KP_2:
			key_str = "2 [N]"
		KEY_KP_3:
			key_str = "3 [N]"
		KEY_KP_4:
			key_str = "4 [N]"
		KEY_KP_5:
			key_str = "5 [N]"
		KEY_KP_6:
			key_str = "6 [N]"
		KEY_KP_7:
			key_str = "7 [N]"
		KEY_KP_8:
			key_str = "8 [N]"
		KEY_KP_9:
			key_str = "9 [N]"
		KEY_KP_ADD:
			key_str = "+ [N]"
		KEY_KP_DIVIDE:
			key_str = "/ [N]"
		KEY_KP_MULTIPLY:
			key_str = "* [N]"
		KEY_KP_PERIOD:
			key_str = ", [N]"
		KEY_KP_SUBTRACT:
			key_str = "- [N]"
		_:
			key_str = OS.get_scancode_string(code)

	return key_str


func get_name_by_btn_mouse_code(code:int) -> String:
	var key_str = ""

	match code:
		BUTTON_LEFT:
			key_str = tr("LMB")
		BUTTON_MIDDLE:
			key_str = tr("MMB")
		BUTTON_RIGHT:
			key_str = tr("RMB")
		BUTTON_XBUTTON1:
			key_str = tr("EMB1")
		BUTTON_XBUTTON2:
			key_str = tr("EMB2")
		_:
			key_str = "[M] " + str(code)

	return key_str
