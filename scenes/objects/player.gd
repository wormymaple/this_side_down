extends RigidBody2D # The player is not a CharacterBody2D because they can't use gravity_scale

# Movement constants
const MAX_SPEED = 60000
const MAX_CLIMB_SPEED = 50000
const ACCELERATION = 2000
var JUMP_POWER = 500
const UNDERWATER_JUMP_MULTIPLIER = 1.3
const LADDER_CLIMB_SPEED = 1500
const ARM_MOVE_SPEED = 5
const CARRY_SPEED = 20
const ARM_LENGTH = 150

const drop_threshold = 100

# States
var is_in_water: bool
var on_ground = false
var things_standing_on = []
var unmovable = false # The player can't move, either because they are being grabbed or they hit a directional spring
var standing_in_ladder = 0
var original_grav_scale = 1 # Grav scale gets changed when being held or climbing ladders, this is used to reset it
var is_ascending = false # If the player is able to hold up to keep going upwards

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
@onready var Legs = $Legs
@onready var Head = $Head
@onready var HandSprite = $HandMeta/Hand
@onready var HandMeta = $HandMeta
@onready var Arm = $Arm
@onready var Particles = $BubbleParticles
# Sound effects
@onready var BoxPickup = $BoxPickup
@onready var BoxDrop = $BoxDrop
@onready var Jump = $Jump
@onready var Footsteps = $Footstep

var body_state: PhysicsDirectBodyState2D # I am not sure how this is used
var player_holding_player: RigidBody2D = null

# Coyote time variables
var jump_buffer_time = 0.0 # Current time left for jumping
var running_buffer = false # This is whether or not the jump buffer is being used

# These get set and used while playing
var target_body: Node2D
var grabbed_body: Node2D
var playerID = "p1"
var right_stick = Vector2.ZERO

func _ready():
	if is_in_water:
		print("The player is underwater!")
		Particles.emitting = true
		JUMP_POWER *= UNDERWATER_JUMP_MULTIPLIER
		original_grav_scale = 0.7
	gravity_scale = original_grav_scale
	
	$PlayerLight.energy /= GlobalVariables.number_of_players

func _physics_process(delta):
	
	## First, do ladder physics
	if standing_in_ladder and not get_meta("grabbed"): # Ladder physics
		gravity_scale = 0
		unmovable = false
		
		var LS_y_axis = Input.get_axis("LS_up_" + playerID, "LS_down_" + playerID)
		
		if LS_y_axis:
			#linear_velocity.y += LS_y_axis * LADDER_CLIMB_SPEED * delta
			if LS_y_axis > 0:
				linear_velocity.y = min(linear_velocity.y + LS_y_axis * LADDER_CLIMB_SPEED * delta, LS_y_axis * MAX_CLIMB_SPEED * delta)
			else: # Going down
				linear_velocity.y = max(linear_velocity.y + LS_y_axis * LADDER_CLIMB_SPEED * delta, LS_y_axis * MAX_CLIMB_SPEED * delta)
		else:
			if abs(linear_velocity.y) - LADDER_CLIMB_SPEED * delta <= 0:
				linear_velocity.y = 0 # move toward 0
				#print("Stopped!")
			else:
				if linear_velocity.y > 0:
					linear_velocity.y -= LADDER_CLIMB_SPEED * delta
				#print("Stopping going right")
				else:
					linear_velocity.y += LADDER_CLIMB_SPEED * delta
			
	elif gravity_scale == 0:
		gravity_scale = original_grav_scale ## This shouldn't need to be here. Does this account for if the player is being held?
	
	## Update the jump buffer
	if running_buffer: # Jump buffer
		jump_buffer_time -= delta
		if jump_buffer_time <= 0:
			running_buffer = false
			on_ground = false
	
	## Move the player's arm
	if playerID != "p0":
		right_stick = Input.get_vector("RS_left_" + playerID, "RS_right_" + playerID, "RS_up_" + playerID, "RS_down_" + playerID)
	else: # Keyboard controls
		right_stick = (Vector2(get_global_mouse_position()) - global_position)
		if right_stick.length() > 1 * ARM_LENGTH:
			#print(right_stick.length())
			right_stick = right_stick.normalized() * ARM_LENGTH
	
	if right_stick.length() != 0:
		if playerID != "p0":
			HandMeta.position += (right_stick * ARM_LENGTH - HandMeta.position) * ARM_MOVE_SPEED * delta # Subtracting the current hand meta position from it will make it slow down when almost reaching it's position
		else:
			HandMeta.position += (right_stick - HandMeta.position) * ARM_MOVE_SPEED * delta
	
	
	elif grabbed_body == null:
		HandMeta.position -= HandMeta.position * ARM_MOVE_SPEED * delta
		
	Arm.set_point_position(1, HandMeta.position)
	$ArmOutline.set_point_position(1, HandMeta.position)
	
	var dir_to_hand = HandMeta.position.angle()
	HandSprite.rotation = dir_to_hand + (PI / 2) # Required because the hand is off by 90 degrees. This could be optimized
	
	
	## Rotate grabbed item (Provided it is a box)
	if grabbed_body != null:
		
		# Addinng this code to test being able to rotate held item by button press
		if grabbed_body.is_in_group("rotateable") and Input.is_action_pressed("rotate_right_" + playerID):
			grabbed_body.global_rotation += 2 * delta
			#grabbed_body.apply_torque(1000000 * delta)
			#print("I am rotating!")
		if grabbed_body.is_in_group("rotateable") and Input.is_action_pressed("rotate_left_" + playerID):
			grabbed_body.global_rotation -= 2 * delta
			#grabbed_body.apply_torque(-1000000 * delta)
			#print("I am rotating!")
			
		
		
		var body_to_hand_dir = HandMeta.global_position - grabbed_body.global_position
		if body_to_hand_dir.length() > drop_threshold:
			drop_object()
		else: 
			grabbed_body.linear_velocity = body_to_hand_dir * CARRY_SPEED
	
	
	if get_meta("grabbed") == true or unmovable:
		return
	
	## Move left and right
	var left_stick = Input.get_axis("LS_left_" + playerID, "LS_right_" + playerID)
	if left_stick != 0:
		if left_stick > 0: # Eventually I should rework this so this doesn't cap player speed when thrown
			linear_velocity.x = min(linear_velocity.x + left_stick * ACCELERATION * delta, left_stick * MAX_SPEED * delta)
		else:
			linear_velocity.x = max(linear_velocity.x + left_stick * ACCELERATION * delta, left_stick * MAX_SPEED * delta)
		
		if on_ground and !running_buffer: # So only if the player is on ground
			wiggle_current_time += delta
			if wiggle_current_time > wiggle_time:
				wiggle_current_time -= wiggle_time # So restart where the wiggling is
			
			var sample = wiggle_curve.sample(wiggle_current_time / wiggle_time) # Put in x, get y out
			Legs.position.x = sample
			Head.position.y = sample
			
			time_since_last_footstep += delta # Play footstep sound effect when supposed to
			if time_since_last_footstep > footstep_interval:
				Footsteps.play()
				time_since_last_footstep -= footstep_interval
			
	elif on_ground or standing_in_ladder:
		if abs(linear_velocity.x) - ACCELERATION * delta <= 0:
			linear_velocity.x = 0 # move toward 0
			#print("Stopped!")
		else:
			if linear_velocity.x > 0:
				linear_velocity.x -= ACCELERATION * delta
				#print("Stopping going right")
			else:
				linear_velocity.x += ACCELERATION * delta
				#print("Stopping going left")

func _input(event):
	# jump
	if event.is_action_pressed("jump_" + playerID) and (on_ground or player_holding_player != null):
		#print(on_ground)
		linear_velocity.y = -JUMP_POWER
		if is_in_water:
			linear_velocity.y *= UNDERWATER_JUMP_MULTIPLIER
		Jump.play()
	#elif event.is_action_pressed("jump_" + playerID) and player_holding_player != null:
		if player_holding_player != null:
			#print("Player struggled")
			player_holding_player.drop_object()
			player_holding_player = null
		
	
	## grab
	if event.is_action_pressed("grab_" + playerID):
		#print("Local: ", Vector2i(get_local_mouse_position())) # Gives you where the mouse is on the screen coordinates 
		#print("Global: ", Vector2i(get_global_mouse_position()))
		
		if grabbed_body == null && target_body != null: # Try grab if they aren't already holding something
			# Am I being grabbed by a player?
			if target_body.is_in_group("Player") && check_player_linkage(target_body):
				return
			
			grabbed_body = target_body
			grabbed_body.gravity_scale = 0
			grabbed_body.set_meta("grabbed", true)
			if grabbed_body.is_in_group("Player"):
				grabbed_body.player_holding_player = self
				if GlobalVariables.controller_rumble:
					
					Input.start_joy_vibration(int(grabbed_body.playerID.right(1)) - 1, 1, 1, 0.3)
			
			
			if grabbed_body.is_in_group("rotateable"):
				grabbed_body.set_collision_mask_value(2, false)
				grabbed_body.set_collision_layer_value(3, false) # Don't refresh a player's jump
				grabbed_body.set_collision_layer_value(4, false) # Don't move players anymore
			HandSprite.texture = holding_hand
			
			if GlobalVariables.controller_rumble:
				Input.stop_joy_vibration(int(playerID.right(1)) - 1)
				Input.start_joy_vibration(int(playerID.right(1)) - 1, 0, 1, 0.2)
			BoxPickup.play()
			#set_collision_mask_value(4, false)
			
	elif event.is_action_released("grab_" + playerID) && grabbed_body != null:
		drop_object()
		
	

func set_color(player_index):
	modulate = player_colors[player_index]

func _integrate_forces(state):
	body_state = state

func drop_object():
	grabbed_body.gravity_scale = original_grav_scale
	grabbed_body.set_meta("grabbed", false)
	
	if grabbed_body.is_in_group("rotateable"):
		grabbed_body.set_collision_mask_value(2, true) 
		grabbed_body.set_collision_layer_value(4, true) # Boxes can hit players again
		grabbed_body.set_collision_layer_value(3, true) # Objects can refresh jumps again
	elif grabbed_body.is_in_group("Player"):
		grabbed_body.player_holding_player = null
	
	grabbed_body = null
	
	HandSprite.texture = empty_hand
	
	if GlobalVariables.controller_rumble:
		Input.stop_joy_vibration(int(playerID.right(1)))
		Input.start_joy_vibration(int(playerID.right(1)) - 1, 1, 0, 0.2)
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
	#print(things_standing_on)

func _on_jump_area_body_exited(body: Node2D) -> void:
	if things_standing_on.find(body) != -1:
		things_standing_on.remove_at(things_standing_on.find(body))
	if things_standing_on.size() < 1:
		running_buffer = true
