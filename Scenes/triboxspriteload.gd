extends RigidBody2D

@export var sprites: Array[Texture2D]
@export var sizes: Array[int]
@onready var sprite = $BoxSprite
@onready var collision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.01).timeout
	var current_level = GlobalVariables.levelrn
	print(current_level)
	sprite.texture = sprites[int(current_level) - 1]
	sprite.scale.x *= sizes[int(current_level) - 1]
	sprite.scale.y *= sizes[int(current_level) - 1]
	collision.scale.x *= sizes[int(current_level) - 1]
	collision.scale.y *= sizes[int(current_level) - 1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
