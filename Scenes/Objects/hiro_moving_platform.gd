extends Path2D

enum State {ONEWAY, LOOPING, STOP, ONEWAYBACK}
var objects_to_move = []
var movement = 0.0
@export var speed = 0.0
@onready var previous_position = $PathFollow2D.position
@export var sprite: Texture

@export var path_behavior: State
# The path behavior allows for 3 different options:
# One Way, which makes the platform turn around when it reaches the end
# Looping, which makes the platform loop. Make sure the loop is complete
# Stop, which will make the platform not move at all.
# One Way Back is just One Way but will move in reverse.

func _ready():
	$Sprite2D.texture = sprite

func _physics_process(_delta):
	$Collision.position = $PathFollow2D.position # I set the position instead of making these a child of pathFollow2D because PathFollow2D has unwanted rotations
	$Sprite2D.position = $PathFollow2D.position
	$Area2D.position = $PathFollow2D.position
	
	
	if path_behavior == State.STOP: # The platform does nothing
		#pass
		return
	elif path_behavior == State.ONEWAY:
		if $PathFollow2D.progress_ratio < 0.99:
			$PathFollow2D.progress += speed
		else:
			path_behavior = State.ONEWAYBACK # Looping reuses the path_behavior variable to know when the platform needs to reverse
	elif path_behavior == State.ONEWAYBACK:
		if $PathFollow2D.progress_ratio > 0.01:
			$PathFollow2D.progress -= speed
		else:
			path_behavior = State.ONEWAY
	elif path_behavior == State.LOOPING:
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
				
				object.position += movement
		if object.is_in_group("Box"):
			#print("global pos: ", object.global_position, ". pos: ", object.position)
			#print("there is an object in box group!")
			#object.global_position = $Collision.global_position + Vector2(0, -30)
			object.position += movement
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
