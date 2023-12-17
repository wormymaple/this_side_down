extends StaticBody2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE}
@export var theme: Themes = Themes.YELLOW
@onready var sprite = $Sprite2D

func _ready():
	if theme == Themes.YELLOW:
		sprite.texture = load("res://Art/First Level/UI_SpringAnimation.png")
	elif theme == Themes.BLUE:
		sprite.texture = load("res://Art/third level/UI_SpringAnimation.png")
	elif theme == Themes.GREEN:
		sprite.texture = load("res://Art/second level/UI_SpringAnimation.png")
	elif theme == Themes.PURPLE:
		sprite.texture = load("res://Art/Fourth Level/UI_SpringAnimation.png")
