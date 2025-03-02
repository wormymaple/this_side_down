extends StaticBody2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE}
@export var theme: Themes = Themes.YELLOW
@onready var sprite = $Sprite2D

func _ready():
	if theme == Themes.YELLOW:
		sprite.texture = load("res://Art/Area1/Ramp.png")
	elif theme == Themes.BLUE:
		sprite.texture = load("res://Art/Area2/Ramp.png")
	elif theme == Themes.GREEN:
		sprite.texture = load("res://Art/Area3/Ramp.png")
	elif theme == Themes.PURPLE:
		sprite.texture = load("res://Art/Area4/Ramp.png")
