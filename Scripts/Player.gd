extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -400.0
var ACCELERATION = 0 # 1 is 100 percent
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") # Gets what gravity was set to in the project settings


func _physics_process(delta):
	# Add the gravity if on the ground
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Somebody please replace the UI actions with the buttons we want.
	var direction = Input.get_axis("ui_left", "ui_right") # Gets the resultant direction
	if direction:
		velocity.x = ACCELERATION * direction * SPEED
		if ACCELERATION < 1: 
			ACCELERATION += .02
	else:
		velocity.x = move_toward(velocity.x, 0, 10 * (1 - ACCELERATION))
		if ACCELERATION > 0: # Makes player deaccelerate when not pressing anything. The if statement prevents deaccelerating backwards infinitely 
			ACCELERATION -= .05
	
	move_and_slide()


func _on_detection_area_body_entered(body): # This isn't "sus." I don't want to hear it, guys.
	$"../CanvasLayer/VideoStreamPlayer".play()
