extends RigidBody2D

enum Themes {NORMAL, BOAT, UNDERWATER}
@export var theme: Themes = Themes.NORMAL
@export var size: float = 1
@onready var sprite = $BoxSprite
@onready var collision = $Hitbox # It is a Collision Polygon 2D now


func _ready():
	if theme == Themes.NORMAL:
		sprite.texture = load("res://Art/Area1/CrateTriangle.png")
	elif theme == Themes.BOAT:
		sprite.texture = load("res://Art/Area2/CrateTriangle.png")
	elif theme == Themes.UNDERWATER:
		sprite.texture = load("res://Art/Area4/CrateTriangle.png")
	
	sprite.scale *= Vector2(size, size)
	collision.scale *= Vector2(size, size)
