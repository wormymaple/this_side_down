extends RigidBody2D

enum Themes {NORMAL, SHIP, UNDERWATER}
@export var theme: Themes = Themes.NORMAL
@export var size: float = 1
@onready var sprite = $BoxSprite
@onready var collision = $CollisionShape2D
#@onready var arrow = $ArrowSprite

func _ready():
	if theme == Themes.NORMAL:
		sprite.texture = load("res://Art/Area1/Crate.png")
	elif theme == Themes.SHIP:
		sprite.texture = load("res://Art/Area2/Crate.png")
	elif theme == Themes.UNDERWATER:
		sprite.texture = load("res://Art/Area4/Crate.png")
	
	sprite.scale *= Vector2(size, size) # Uses *= instead of just = because the starting sprite size is 0.145 
	collision.scale *= Vector2(size, size)
	
	#if size >= 2: # i think this moves the arrow closer to the center if the box is big
	#	arrow.position.x -= 20
	#	arrow.position.y -= 20
