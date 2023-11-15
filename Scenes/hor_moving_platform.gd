extends StaticBody2D

var direction = "left"
@export var speed = 1

func _ready():
	_platform_move()



func _process(delta):
	if direction == "left":
		position.x -= speed
	elif direction == "right":
		position.x += speed

func _platform_move():
	direction = "left"
	await get_tree().create_timer(5).timeout
	direction = "right"
	await get_tree().create_timer(5).timeout
	_platform_move()
