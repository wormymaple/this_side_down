extends RigidBody2D

@export var texture: Texture
@export var size: float = 1
@onready var sprite = $BoxSprite
@onready var collision = $Hitbox # It is a Collision Polygon 2D now


func _ready():
	sprite.texture = texture
	
	sprite.scale *= Vector2(size, size)
	collision.scale *= Vector2(size, size)
