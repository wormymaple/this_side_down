extends Path2D

@export var player = Node2D
@export var speed = 0.0
@export var path_behavior = "Stop"
# The path behavior allows for 3 different options:

# One Way, which makes the platform turn around when it reaches the end
# Looping, which makes the platform loop. Make sure the loop is complete
# Stop, which will make the platform not move at all.


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	$Collision.position = $PathFollow2D.position
	$Sprite2D.position = $PathFollow2D.position
	
	#print("Player pos: ", player.position.y, ". Platform pos: ", position.y + $Platform.position.y - 35)
	if player.position.y < $Collision.position.y + position.y - 35: # If player y is smaller than the platform's y, the player is above the platform
		$Collision.set_collision_layer_value(1, true)
		#print("You are above the platform")
	else:
		$Collision.set_collision_layer_value(1, false)
		#print("You are below the platform")
	
	if path_behavior == "Stop": # The platform does nothing
		return
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
	
