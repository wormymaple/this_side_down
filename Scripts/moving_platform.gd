extends StaticBody2D

var direction = "up"
@export var speed = 1

func _ready():
	_platform_move()



func _process(delta):
	if direction == "up":
		position.y -= speed
	elif direction == "down":
		position.y += speed

func _platform_move():
	direction = "up"
	await get_tree().create_timer(5).timeout
	direction = "down"
	await get_tree().create_timer(5).timeout
	_platform_move()
