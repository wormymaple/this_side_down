extends ParallaxBackground

@export var bad_weather = false

func _ready():
	if bad_weather:
		$Wayback/Ship.texture = load("res://art/area_3/ship_background_stormy.png")
		#for child in self.get_children():
		#	child.modulate = Color(child.modulate.r + .5, child.modulate.r + .5, child.modulate.r + .5) # Darken everything else
	
	## I need to fix the clouds appearing in front of the deck but behind the ship
