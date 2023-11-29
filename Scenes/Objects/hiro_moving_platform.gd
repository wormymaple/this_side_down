extends Path2D

enum States {ONEWAY, LOOPING, STOP}
@export var path_behavior: States
@export var player = Node2D
@export var speed = 0.0

#@onready var player = get_tree().get_nodes_in_group("Player")
# The path behavior allows for 3 different options:

# One Way, which makes the platform turn around when it reaches the end
# Looping, which makes the platform loop. Make sure the loop is complete
# Stop, which will make the platform not move at all.

@export var sprite: Texture

var objects_to_move = []
@onready var previous_position = $PathFollow2D.position

var movement = 0.0

func _ready():
	$Sprite2D.texture = sprite

func _physics_process(_delta):
	$Collision.position = $PathFollow2D.position
	$Sprite2D.position = $PathFollow2D.position
	$Area2D.position = $PathFollow2D.position
	
	# This code is commented out because one way collision does all of this automatically
	
	
	
	if path_behavior == "Stop": # The platform does nothing
		pass
		#return
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
	
	#if moving_body != null:
		#print(moving_body.on_ground)
	#if name == "Platform":
		#print($"../Box".on_ground)
	
	for object in objects_to_move:
		if object.is_in_group("Player"):
			if object.on_ground:
				
				object.position += movement * 1.55
		if object.is_in_group("Box"):
			#print("global pos: ", object.global_position, ". pos: ", object.position)
			#print("there is an object in box group!")
			#object.global_position = $Collision.global_position + Vector2(0, -30)
			object.position += movement * 1.55
			#object.position.x += 10
	
	#if object != null and object.on_ground:
		#print("moving something on a platform!")
		#moving_body.position.x += movement * 1.55
	#	moving_body.position += movement * 1.55
		#print(movement)


func _on_area_2d_body_entered(body):
	#print(body.name)
	if body.is_in_group("Player") or body.is_in_group("Box"):
		#print("The body that entered was the player!")
		objects_to_move.push_back(body)
		print(objects_to_move)

func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		if body in objects_to_move:
			objects_to_move.pop_at(objects_to_move.find(body))
			print("Removed ", body.name)
