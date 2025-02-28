extends Path2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE}
@export var theme: Themes = Themes.YELLOW
enum State {ONEWAY, LOOPING, STOP, ONEWAYBACK}
var objects_to_move = []
var movement = 0.0
@export var speed = 0.2
@onready var previous_position = $PathFollow2D.position
@onready var sprite = $Sprite2D

@export var path_behavior: State
# The path behavior allows for 3 different options:
# One Way, which makes the platform turn around when it reaches the end
# Looping, which makes the platform loop. Make sure the loop is complete
# Stop, which will make the platform not move at all.
# One Way Back is just One Way but will move in reverse.

func _ready():
	if theme == Themes.YELLOW:
		sprite.texture = load("res://Art/Area1/FloatingPlatform.png")
	elif theme == Themes.GREEN:
		sprite.texture = load("res://Art/Area2/FloatingPlatform.png")
	elif theme == Themes.BLUE:
		sprite.texture = load("res://Art/Area3/FloatingPlatform.png")
	
	elif theme == Themes.PURPLE:
		sprite.texture = load("res://Art/Area4/FloatingPlatform.png")

func _physics_process(_delta):
	if path_behavior == State.STOP: # The platform does nothing
		return
	
	$Collision.position = $PathFollow2D.position # Sets positions instead of being a child of PathFollow2D because it rotates weirdly
	sprite.position = $PathFollow2D.position
	$Area2D.position = $PathFollow2D.position
	
	if path_behavior == State.ONEWAY:
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
	
	
	for object in objects_to_move:
		if object.is_in_group("Player"):
			if object.on_ground:
				object.position += movement * scale
		if object.is_in_group("Box"):
			#object.global_position += movement * scale # This works for some reason
			object.global_transform.origin += movement * scale # For some reason this works while setting the position will not


func _on_area_2d_body_entered(body):
	if path_behavior != State.STOP:
		if body.is_in_group("Player") or body.is_in_group("Box"):
			objects_to_move.push_back(body)
		#	var objects_in_array = ""
		#	for object in objects_to_move:
		#		objects_in_array += object.name + " "
		#	print(objects_in_array)

func _on_area_2d_body_exited(body):
	if path_behavior != State.STOP:
		if body.is_in_group("Player") or body.is_in_group("Box"):
			if body in objects_to_move:
				objects_to_move.pop_at(objects_to_move.find(body))
			#print("Removed ", body.name)
