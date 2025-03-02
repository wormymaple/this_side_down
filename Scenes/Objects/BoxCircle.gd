extends RigidBody2D

enum Themes {NORMAL, SHIP, UNDERWATER}
@export var theme: Themes = Themes.NORMAL
@export var size: float
@onready var sprite = $BoxSprite
@onready var collision = $CollisionShape2D
#@onready var arrow = $ArrowSprite

func _ready():
	if theme == Themes.NORMAL:
		sprite.texture = load("res://Art/Area1/CrateCircle.png")
	elif theme == Themes.SHIP:
		sprite.texture = load("res://Art/Area2/CrateCircle.png")
	elif theme == Themes.UNDERWATER:
		sprite.texture = load("res://Art/Area4/CrateCircle.png")
	
	sprite.scale *= Vector2(size, size)
	collision.scale *= Vector2(size, size)
