extends ParallaxBackground

enum Weather {NORMAL, STORMY}
@export var current_weather = Weather.NORMAL

func _ready():
	if current_weather == Weather.NORMAL:
		pass
	else:
		$Wayback/Birds.hide()
		$Wayback/Clouds.show()
		for child in self.get_children():
			child.modulate = Color(.5, .5, .5)
