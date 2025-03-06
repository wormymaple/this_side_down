extends Node2D

@export var boxes_required: int = 1
@export var camera: Camera2D
@export var level: int = 1
@export var platform_to_attach_to: Path2D = null

@onready var Particles = $GPUParticles2D
@export var upside_down = false

var colliding_bodies: Array[Node2D]
var won_already = false

func _ready() -> void:
	if platform_to_attach_to != null:
		platform_to_attach_to.objects_to_move.push_back(self)

func _process(_delta): # It would be best if this code only checked itself when a box moves or is dropped
	
	if won_already or len(colliding_bodies) < boxes_required: # Asks if there are enough boxes. This could be indented but activating at every new collision makes a less of a chance or not activating
		return
		
	for body in colliding_bodies:
		if body.get_meta("grabbed"): # Boxes that are being grabbed do not count
			return
			
		if upside_down:
			if abs(body.rotation_degrees) > 45: # More than 135 degrees means it is facing downwards. Works for negative rotation because of the abs(). Also works since if the rotation is more than 180 rotation the sign flips.
				return
		else: # Normal code for if the landing zone is facing up
			if abs(body.rotation_degrees) < 135:
				#print("box rotation is not right")
				return
	
	#print("That passed!")
	won_already = true
	GlobalVariables.win_level(level)
	Particles.emitting = true
	camera.fade_out(true)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Box"):
		#print("New Box!")
		colliding_bodies.append(body)
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in colliding_bodies:
		colliding_bodies.remove_at(colliding_bodies.find(body))
	
