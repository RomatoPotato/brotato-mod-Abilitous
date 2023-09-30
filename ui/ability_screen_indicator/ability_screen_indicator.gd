extends ColorRect

onready var tween = $"Tween"


func darkening():
	tween.interpolate_property(
		self, 
		"color:a", 
		0, 
		0.3, 
		0.5, 
		Tween.TRANS_LINEAR
	)

	tween.start()


func lightening():
	tween.interpolate_property(
		self, 
		"color:a", 
		0.3, 
		0,
		0.5, 
		Tween.TRANS_LINEAR
	)

	tween.start()


func blink():
	tween.interpolate_property(
		self,
		"color:a",
		1,
		0,
		0.5,
		Tween.TRANS_LINEAR
	)

	tween.start()
