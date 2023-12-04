extends RigidBody2D

@export var texture: Texture
@export var size: float = 1
@onready var sprite = $BoxSprite
@onready var collision = $CollisionShape2D
@onready var arrow = $ArrowSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = texture
	
	sprite.scale *= Vector2(size, size) # Uses *= instead of just = because the starting sprite size is 0.145 
	collision.scale *= Vector2(size, size)
	
	if size >= 2: # i think this moves the arrow closer to the center if the box is big
		arrow.position.x -= 20
		arrow.position.y -= 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
