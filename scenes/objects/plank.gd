extends StaticBody2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE}
@export var theme: Themes = Themes.YELLOW
@onready var sprite = $Sprite2D

func _ready():
	if theme == Themes.YELLOW:
		sprite.texture = load("res://Art/Area1/Plank1.png")
	elif theme == Themes.BLUE:
		sprite.texture = load("res://Art/Unused/Plank2.png")
	elif theme == Themes.GREEN:
		sprite.texture = load("res://Art/Unused/Plank3.png")
	elif theme == Themes.PURPLE:
		sprite.texture = load("res://Art/Unused/Plank4.png")
