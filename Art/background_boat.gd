extends ParallaxBackground

@export var bad_weather = false

func _ready():
	if bad_weather:
		$Wayback/Ship.sprite = load("res://Art/Area3/NewShipStormy.png")
		for child in self.get_children():
			child.modulate = Color(.5, .5, .5) # Darken everything else
