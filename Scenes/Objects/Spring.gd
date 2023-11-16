extends Node2D

var is_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_pressed:
		if scale.y < 2:
			scale.y += .1
			position.y -= 6
		else: is_pressed = false
	else:
		if scale.y > 1:
			scale.y -= .1
			position.y += 6


# When something enters the body, this will play a spring animation

func _on_area_2d_body_entered(_body):
	is_pressed = true
