extends RigidBody2D

enum Themes {NORMAL, UNDERWATER}
@export var theme: Themes = Themes.NORMAL
@export var size: float = 1
@onready var sprite = $BoxSprite
@onready var collision = $Hitbox # It is a Collision Polygon 2D now


func _ready():
	if theme == Themes.NORMAL:
		$Sprite2D.texture = load("res://Art/First Level/UI_HeavyTriangle.png")
	elif theme == Themes.UNDERWATER:
		$Sprite2D.texture = load("res://Art/Fourth Level/UI_Underwater_Triangle_Box.png")
	
	sprite.scale *= Vector2(size, size)
	collision.scale *= Vector2(size, size)
