extends StaticBody2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE}
@export var theme: Themes = Themes.YELLOW
@onready var sprite = $Sprite2D

func _ready():
	if theme == Themes.YELLOW:
		sprite.texture = load("res://art/area_1/ramp.png")
	elif theme == Themes.BLUE:
		sprite.texture = load("res://art/area_2/ramp.png")
	elif theme == Themes.GREEN:
		sprite.texture = load("res://art/area_3/ramp.png")
	elif theme == Themes.PURPLE:
		sprite.texture = load("res://art/area_4/ramp.png")
