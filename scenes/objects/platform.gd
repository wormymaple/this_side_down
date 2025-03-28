extends Path2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE, WHITE}
@export var theme: Themes = Themes.YELLOW

@onready var previous_position = $PathFollow2D.position
@onready var sprite = $Sprite2D

enum State {ONEWAY, LOOPING, STOP, ONEWAYBACK}
var objects_to_move = []
var movement = 0.0
@export var speed = 0.2
@export var path_behavior: State
@export var SpinCurve: Curve
@export var BobCurve: Curve

var follow_position = Vector2.ZERO

# The path behavior allows for 3 different options:
# One Way, which makes the platform turn around when it reaches the end
# Looping, which makes the platform loop. Make sure the loop is complete
# Stop, which will make the platform not move at all.
# One Way Back is just One Way but will move in reverse. (Tells the platform to invert it's progress)

func _ready():
	match theme:
		Themes.YELLOW:
			modulate = Color("c9a338")
		Themes.BLUE:
			modulate = Color("377abd")
		Themes.GREEN:
			modulate = Color("008a5e")
		Themes.PURPLE:
			modulate = Color("482c84")
		Themes.WHITE:
			pass # Stay as white

func _physics_process(_delta):
	if path_behavior == State.STOP: # The platform does nothing
		return
	
	if objects_to_move:
		follow_position = $PathFollow2D.position
	else:
		follow_position = $PathFollow2D.position + Vector2(0, BobCurve.sample($BobTimer.time_left / $BobTimer.wait_time) * 2)
	
	$Collision.position = follow_position # Sets positions instead of being a child of PathFollow2D because it rotates weirdly
	sprite.position = follow_position
	$Area2D.position = follow_position
	$Line2D.position = follow_position
	
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
		elif object.is_in_group("Box"):
			#object.global_position += movement * scale # This works for some reason
			object.global_transform.origin += movement * scale # For some reason this works while setting the position will not
		elif object.is_in_group("LandingZone"):
			object.position += movement * scale
		elif object.is_in_group("Spring"):
			object.position += movement * scale
	

func _process(_delta: float) -> void:
	$Line2D.scale.x = SpinCurve.sample($Timer.time_left / $Timer.wait_time) # This should make it look like there is a spinning propeller

func _on_area_2d_body_entered(body):
	if path_behavior != State.STOP:
		if body.is_in_group("Player") or body.is_in_group("Box"):
			objects_to_move.push_back(body)


func _on_area_2d_body_exited(body):
	if path_behavior != State.STOP:
		if body.is_in_group("Player") or body.is_in_group("Box"):
			if body in objects_to_move:
				objects_to_move.pop_at(objects_to_move.find(body))
