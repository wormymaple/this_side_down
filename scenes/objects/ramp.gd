extends StaticBody2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE, WHITE}
@export var theme: Themes = Themes.YELLOW
@onready var sprite = $Sprite2D

func _ready():
	match theme:
		Themes.YELLOW:
			modulate = Color("c9a338")
		Themes.BLUE:
			modulate = Color("377abd")
		Themes.GREEN:
			modulate = Color("008a5e")
		Themes.PURPLE:
			modulate = Color("482c84")
		Themes.WHITE:
			pass # Stay as white
