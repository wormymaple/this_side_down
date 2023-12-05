extends RigidBody2D

@export var texture: Texture
@export var size: float
@onready var sprite = $BoxSprite
@onready var collision = $CollisionShape2D
@onready var arrow = $ArrowSprite

func _ready():
	sprite.texture = texture
	sprite.scale *= Vector2(size, size)
	collision.scale *= Vector2(size, size)
