extends Control

onready var info_container = $"PanelContainer/VBoxContainer"
onready var label = $"PanelContainer/VBoxContainer/Label"

var col_neutral_a = "[color=white]"
var col_pos_a
var col_neg_a
var col_b = "[/color]"


func _ready():
	col_pos_a = "[color=" + Utils.POS_COLOR_STR + "]"
	col_neg_a = "[color=" + Utils.NEG_COLOR_STR + "]"


func _on_AbilityDebuffInfoContainer_draw():
	write_info()


func write_info():
	var bbcode_text = col_neutral_a + tr("NUMBER_OF_ENEMIES") + col_neg_a + " +15%" + "\n"
	bbcode_text += col_b + col_neutral_a + tr("MAP_SIZE") + " +20%" + col_b + "\n"
	bbcode_text += col_b + col_neutral_a + tr("WAVE_DURATION") + " +20%" + col_b + "\n"
	bbcode_text += col_neutral_a + tr("ENEMY_HEALTH_DESC") + col_neg_a + " +10%" + col_b + "\n"
	bbcode_text += col_neutral_a + tr("ENEMY_DAMAGE_DESC") + col_pos_a + " -10%" + col_b + "\n"
	bbcode_text += col_neg_a + tr("ACHIEVEMENTS_DISABLED") + col_b + "\n"
	bbcode_text += col_pos_a + tr("LOTS_OF_ABILS") + col_b + "\n"
	bbcode_text += col_pos_a + tr("FUN") + col_b

	label.bbcode_text = bbcode_text
