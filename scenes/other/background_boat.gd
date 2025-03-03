extends ParallaxBackground

@export var bad_weather = false

func _ready():
	if bad_weather:
		$Wayback/Ship.texture = load("res://art/area_3/ship_background_stormy.png")
		for child in self.get_children():
			child.modulate = Color(.5, .5, .5) # Darken everything else
