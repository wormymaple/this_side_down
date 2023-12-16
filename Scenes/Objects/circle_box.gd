extends RigidBody2D

enum Themes {NORMAL, UNDERWATER}
@export var theme: Themes = Themes.NORMAL
@export var size: float
@onready var sprite = $BoxSprite
@onready var collision = $CollisionShape2D
@onready var arrow = $ArrowSprite

func _ready():
	if theme == Themes.NORMAL:
		$Sprite2D.texture = load("res://Art/First Level/UI_HeavyCircle.png")
	elif theme == Themes.UNDERWATER:
		$Sprite2D.texture = load("res://Art/Fourth Level/UI_Underwater_Circle_Box.png")
	
	sprite.scale *= Vector2(size, size)
	collision.scale *= Vector2(size, size)
