extends RigidBody2D

@export var move_speed: float
@export var jump_speed: float
@export var arm_move_speed: float
@export var grab_speed: float
@export var arm_length: float
@export var drop_threshold: float

@export var wiggle_curve: Curve
@export var wiggle_intensity: float
@export var wiggle_time: float
var wiggle_current_time = 0.0
@export var legs_path: NodePath
@onready var legs = get_node(legs_path)
@export var head_path: NodePath
@onready var head = get_node(head_path)
@export var head_bob: float

@export var playerID: String
@export var hand_path: NodePath
@export var arm_path: NodePath
@onready var hand = get_node(hand_path)
@onready var arm = get_node(arm_path)
var target_body: Node2D
var grabbed_body: Node2D
var on_ground = false

@export var box_pickup: AudioStreamPlayer
@export var box_drop: AudioStreamPlayer
@export var jump: AudioStreamPlayer


var body_state: PhysicsDirectBodyState2D

func _ready():
	hand.position = Vector2.UP * arm_length
	arm.set_point_position(1, hand.position)
	
	add_to_group("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var right_stick = Input.get_vector("right_left_" + playerID, "right_right_" + playerID, "right_up_" + playerID, "right_down_" + playerID).normalized()
	if right_stick.length() != 0:
		hand.position += (right_stick * arm_length - hand.position) * arm_move_speed * delta
		hand.position = hand.position.normalized() * arm_length
		arm.set_point_position(1, hand.position)
	
	if grabbed_body != null:
		var dir = hand.global_position - grabbed_body.global_position
		if dir.length() > drop_threshold:
			drop_object()
		else: 
			grabbed_body.linear_velocity = dir * grab_speed
	
	if get_meta("grabbed") == true:
		return
	
	var left_stick = Input.get_axis("left_left_" + playerID, "left_right_" + playerID)
	if left_stick != 0:
		linear_velocity.x = left_stick * move_speed
		
		if on_ground: # Player anim.
			wiggle_current_time += delta
			if wiggle_current_time > wiggle_time:
				wiggle_current_time -= wiggle_time
			
			var sample = wiggle_curve.sample(wiggle_current_time / wiggle_time)
			legs.position = Vector2(sample * wiggle_intensity, legs.position.y)
			head.position = Vector2(0, sin(wiggle_current_time / wiggle_time * PI) * head_bob)
	else:
		linear_velocity.x = 0
		
func _input(event):
	# jump
	if event.is_action_pressed("left_trigger_" + playerID) && on_ground:
		linear_velocity.y = -jump_speed
		jump.play()
		
	# grab
	if event.is_action_pressed("right_trigger_" + playerID):
		if grabbed_body == null && target_body != null: # Try grab
			# Am I being grabbed by a player?
			if target_body.is_in_group("Player") && target_body.grabbed_body == self:
				return
			
			grabbed_body = target_body
			grabbed_body.gravity_scale = 0
			grabbed_body.set_meta("grabbed", true)
			box_pickup.play()
		elif grabbed_body != null:
			drop_object()

func set_color(color):
	modulate = color
		
func _integrate_forces(state):
	body_state = state

func drop_object():
	grabbed_body.gravity_scale = 1
	grabbed_body.set_meta("grabbed", false)
			
	grabbed_body = null
	
	box_drop.play()

func _on_grab_area_body_entered(body):
	if body == self:
		return
	
	var grabbable = body.has_meta("grabbable")
	if grabbable == true and body.get_meta("grabbed") != true:
		target_body = body


func _on_grab_area_body_exited(body):
	if body == target_body:
		target_body = null


func _on_body_entered(body):
	var normal = body_state.get_contact_local_normal(0)
	if abs(normal.x) < 0.2 && normal.y < 0:
		on_ground = true

func _on_body_exited(body):
	on_ground = false
