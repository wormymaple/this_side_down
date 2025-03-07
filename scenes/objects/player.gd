extends RigidBody2D

# Movement constants
const move_speed = 50000
const jump_speed = 500
const water_jump_multiplier = 1.5
const ladder_climb_speed = 40000
const arm_move_speed = 5
const grab_speed = 20
const arm_length = 150
const drop_threshold = 100

# States
var is_in_water: bool
var on_ground = false
var things_standing_on = []
var grab_did_collide = false
var unmovable = false # The player can't move, either because they are being grabbed or they hit a directional spring
var standing_in_ladder = 0
var original_grav_scale = 1 # This is literally 1. Grav scale gets changed when being held or climbing ladders

# Player detail
@export var wiggle_curve: Curve # What is wiggle? The player jiggling while moving?
var wiggle_time = .5
var wiggle_current_time = 0.0
@export var holding_hand: Texture2D
@export var empty_hand: Texture2D
@export var player_colors: Array[Color]
const footstep_interval = 0.4 # This is the amount of time before footsteps can play again
var time_since_last_footstep = 0.0

# Parts of the body that the script needs
@onready var legs = $Legs
@onready var head = $Head
@onready var hand_sprite = $HandMeta/Hand
@onready var hand_meta = $HandMeta
@onready var arm = $Arm
# Sound effects
@onready var BoxPickup = $BoxPickup
@onready var BoxDrop = $BoxDrop
@onready var Jump = $Jump
@onready var Footsteps = $Footstep

var body_state: PhysicsDirectBodyState2D # I am not sure how this is used

# Coyote time variables
var jump_buffer_time = 0.0 # Current time left for jumping
var running_buffer = false # This is whether or not the jump buffer is being used

# These get set and used while playing
var target_body: Node2D
var grabbed_body: Node2D
var playerID = "p1"
var right_stick = Vector2.ZERO

#func _ready():
	#hand_meta.position = Vector2.UP * arm_length # Why?
	#arm.set_point_position(1, hand_meta.position) # Why?

func _physics_process(delta):
	## First, do ladder physics
	if standing_in_ladder: # Ladder physics
		gravity_scale = 0
		unmovable = false
		if Input.is_action_pressed("LS_up_" + playerID): # The player will climb up
			#print("Climbing up the ladder!")
			linear_velocity = Vector2.UP * ladder_climb_speed * delta
		
		elif Input.is_action_pressed("LS_down_" + playerID):
			linear_velocity = Vector2.DOWN * ladder_climb_speed * delta # Since the vector is down, I don't need to invert it
		else:
			linear_velocity.y = 0
	elif gravity_scale == 0 or gravity_scale == 0.5:
		gravity_scale = original_grav_scale ## This shouldn't need to be here. Does this account for if the player is being held?
	
	## Update the jump buffer
	if running_buffer: # Jump buffer
		jump_buffer_time -= delta
		if jump_buffer_time <= 0:
			running_buffer = false
			on_ground = false
	
	## Move the player's arm
	right_stick = Input.get_vector("RS_left_" + playerID, "RS_right_" + playerID, "RS_up_" + playerID, "RS_down_" + playerID)
	if right_stick.length() != 0:
		hand_meta.position += (right_stick * arm_length - hand_meta.position) * arm_move_speed * delta
		#hand_meta.position = hand_meta.position.normalized() * arm_length <- FOR FIXED PENDULUM
	elif grabbed_body == null:
		hand_meta.position -= hand_meta.position * arm_move_speed * delta
		
	arm.set_point_position(1, hand_meta.position)
	var dir_to_hand = hand_meta.position.angle()
	hand_sprite.rotation = dir_to_hand + (PI / 2)
	
	var box_collides = get_collision_mask_value(4)
	if target_body != null or grabbed_body != null:
		if box_collides:
			set_collision_mask_value(4, false)
	elif !box_collides: # I am not sure what is happening here
		set_collision_mask_value(4, true)
	
	## Rotate grabbed item (Provided it is a box)
	if grabbed_body != null:
		
		# Addinng this code to test being able to rotate held item by button press
		if grabbed_body.is_in_group("Box") and Input.is_action_pressed("rotate_right_" + playerID):
			grabbed_body.global_rotation += 2 * delta
			#print("I am rotating!")
		if grabbed_body.is_in_group("Box") and Input.is_action_pressed("rotate_left_" + playerID):
			grabbed_body.global_rotation -= 2 * delta
			#print("I am rotating!")
			
		
		var body_to_hand_dir = hand_meta.global_position - grabbed_body.global_position
		if body_to_hand_dir.length() > drop_threshold:
			drop_object()
		else: 
			grabbed_body.linear_velocity = body_to_hand_dir * grab_speed
	else:
		hand_sprite.rotation += (PI / 7)
	
	if get_meta("grabbed") == true or unmovable:
		return
	
	## Move left and right
	var left_stick = Input.get_axis("LS_left_" + playerID, "LS_right_" + playerID)
	if left_stick != 0:
		linear_velocity.x = left_stick * move_speed * delta
		
		if on_ground and !running_buffer: # So only if the player is on ground
			wiggle_current_time += delta
			if wiggle_current_time > wiggle_time:
				wiggle_current_time -= wiggle_time # So restart where the wiggling is
			
			var sample = wiggle_curve.sample(wiggle_current_time / wiggle_time) # Put in x, get y out
			legs.position.x = sample
			head.position.y = sample
			
			time_since_last_footstep += delta # Play footstep sound effect when supposed to
			if time_since_last_footstep > footstep_interval:
				Footsteps.play()
				time_since_last_footstep -= footstep_interval
			
	elif on_ground or standing_in_ladder:
		linear_velocity.x = 0

func _input(event):
	# jump
	if event.is_action_pressed("jump_" + playerID) and on_ground: #&& !standing_in_ladder: # Not neccessary
		print(on_ground)
		linear_velocity.y = -jump_speed
		if is_in_water:
			linear_velocity.y *= water_jump_multiplier
		Jump.play()
		
	# grab
	if event.is_action_pressed("grab_" + playerID):
		if grabbed_body == null && target_body != null: # Try grab
			# Am I being grabbed by a player?
			if target_body.is_in_group("Player") && check_player_linkage(target_body):
				return
			
			grabbed_body = target_body
			grabbed_body.gravity_scale = 0
			grabbed_body.set_meta("grabbed", true)
			grab_did_collide = grabbed_body.get_collision_mask_value(2)
			grabbed_body.set_collision_mask_value(2, false)
			hand_sprite.texture = holding_hand
			
			BoxPickup.play()
			
	elif event.is_action_released("grab_" + playerID) && grabbed_body != null:
		drop_object()

func set_color(player_index):
	modulate = player_colors[player_index]

func _integrate_forces(state):
	body_state = state

func drop_object():
	grabbed_body.gravity_scale = 1
	grabbed_body.set_meta("grabbed", false)
	grabbed_body.set_collision_mask_value(2, grab_did_collide) # Also for players?
	grabbed_body = null
	
	hand_sprite.texture = empty_hand
	BoxDrop.play()

func _on_grab_area_body_entered(body):
	if body == self:
		return
	
	var grabbable = body.has_meta("grabbable")
	if grabbable == true and body.get_meta("grabbed") != true:
		target_body = body

func _on_grab_area_body_exited(body):
	if body == target_body:
		target_body = null

func _on_body_entered(_body):
	return

func _on_body_exited(_body): # Is this when the player leaves the ground?
	return

func check_player_linkage(body): # This function is used for knowing if a player can grab another player?
	if body.grabbed_body == null or not body.grabbed_body.is_in_group("Player"):
		return false
	elif body.grabbed_body == self:
		return true
	
	return check_player_linkage(body.grabbed_body)


func _on_area_2d_body_entered(body: Node2D) -> void:
	#var normal = body_state.get_contact_local_normal(0)
	#
	#if abs(normal.x) < 0.4 && normal.y < 0: # If the direction is mostly under the player then they are grounded!
	if things_standing_on.find(body) == -1:
		things_standing_on.append(body)
	on_ground = true
	jump_buffer_time = 0.1 ## This is the jump buffer
	running_buffer = false
	unmovable = false # What if you are being grabbed?
	print(things_standing_on)

func _on_jump_area_body_exited(body: Node2D) -> void:
	if things_standing_on.find(body) != -1:
		things_standing_on.remove_at(things_standing_on.find(body))
	running_buffer = true
