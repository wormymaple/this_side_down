extends Path2D

@export var player = Node2D
@export var speed = 0.0
@export var path_behavior = "Stop"

#@onready var player = get_tree().get_nodes_in_group("Player")
# The path behavior allows for 3 different options:

# One Way, which makes the platform turn around when it reaches the end
# Looping, which makes the platform loop. Make sure the loop is complete
# Stop, which will make the platform not move at all.

@export var sprite: Texture

var moving_body = null
@onready var previous_position = $PathFollow2D.position
@onready var previous_previous_position: Vector2 = $PathFollow2D.position
var movement = 0.0

func _ready():
	#previous_position = position
	$Sprite2D.texture = sprite
	pass

func _physics_process(_delta):
	$Collision.position = $PathFollow2D.position
	$Sprite2D.position = $PathFollow2D.position
	$Area2D.position = $PathFollow2D.position
	
	#if name == "Platform":
	#	print("Player pos: ", int(player.position.y), ". Platform pos: ", int(position.y + $Collision.position.y))
	#if player.position.y < $Collision.position.y + position.y - 30: # If player y is smaller than the platform's y, the player is above the platform
#		$Collision.set_collision_layer_value(2, true) # -55
#		$Area2D.set_collision_mask_value(2, true)
#		if name == "Platform":
#			print("You are above platform #1")
#	else:
#		$Collision.set_collision_layer_value(2, false)
#		$Area2D.set_collision_mask_value(2, false)
		#print("You are below the platform")
	
	if path_behavior == "Stop": # The platform does nothing
		pass
		# return
	elif path_behavior == "One Way":
		if $PathFollow2D.progress_ratio < 0.99:
			$PathFollow2D.progress += speed
		else:
			path_behavior = "One Way Back" # Looping reuses the path_behavior variable to know when the platform needs to reverse
	elif path_behavior == "One Way Back":
		if $PathFollow2D.progress_ratio > 0.01:
			$PathFollow2D.progress -= speed
		else:
			path_behavior = "One Way"
	elif path_behavior == "Looping":
		$PathFollow2D.progress += speed
	
	
	movement = $PathFollow2D.position - previous_position
	# Check for any change in position since last frame
	previous_position = $PathFollow2D.position
	# Update last position
	
	if moving_body != null and moving_body.on_ground:
		#print("moving something on a platform!")
		#moving_body.position.x += movement * 1.55
		moving_body.position += movement * 1.55
		#print(movement)


func _on_area_2d_body_entered(body):
	#print(body)
	if body.is_in_group("Player"):
		#print("The body that entered was the player!")
		#moving_player = false
		moving_body = body

func _on_area_2d_body_exited(body):
	if body == player:
		#moving_player = false
		moving_body = null
