extends Node2D

var pressed_state = "Done"
@export var Sprite: Texture

func _ready():
	$Sprite2D.texture = Sprite
func _process(_delta):
	# This makes the spring stretch when something bounces on it
	if pressed_state == "In":
		if scale.y > 0.5:
			scale.y -= .1
			position.y += 4 # 20 pixels down
		else:
			pressed_state = "Out"
	elif pressed_state == "Out":
		if scale.y < 2:
			scale.y += .1
			position.y -= 4 # up 60 pixels
		else: pressed_state = "Done"
	elif pressed_state == "Done":
		if scale.y > 1:
			scale.y -= .1
			position.y += 4 # down 40

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		pressed_state = "In"
		body.linear_velocity.y = - 700
		$AudioStreamPlayer.play() # change for a more springy sound later
