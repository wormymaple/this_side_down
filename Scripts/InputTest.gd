extends RigidBody2D

@export var move_speed: float

@export var playerID: String
@export var ring_path: NodePath
var ring: Node2D

func _ready():
	ring = get_node(ring_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var right_stick = Input.get_vector("right_left_" + playerID, "right_right_" + playerID, "right_up_" + playerID, "right_down_" + playerID)
	if right_stick.length() != 0:
		if !ring.visible:
			ring.visible = true
		ring.position = right_stick * 100
	elif ring.visible:
		ring.visible = false
	
	var left_stick = Input.get_axis("left_left_" + playerID, "left_right_" + playerID)
	if left_stick != 0:
		linear_velocity.x = left_stick * move_speed
	else:
		linear_velocity.x = 0

func _input(event):
	if event.is_action_pressed("left_trigger_" + playerID):
		linear_velocity.y = -1000
	
