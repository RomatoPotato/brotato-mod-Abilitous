class_name Debuff
extends Resource

export (String) var key: = ""
export (String) var text_key: = ""
export (int) var value: = 0
export (float, -1, 1, 0.01) var percent_value: = 0.0


func apply():
	RunData.effects[key] += RunData.effects[key] * percent_value
	RunData.effects[key] += value
