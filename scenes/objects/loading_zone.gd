extends Node2D

@export var camera: Camera2D
@export var level: String = "1"
@export var platform_to_attach_to: Path2D = null

@onready var GPUParticles = $GPUParticles2D
@onready var CPUParticles = $CPUParticles2D
@export var upside_down = false
enum BoxTypes {SQUARE, CIRCLE, TRIANGLE}
@export var hints: Array[BoxTypes]
#@export var hints = Array[BoxTypes]

var colliding_bodies: Array[Node2D]
var won_already = false

func _ready() -> void:
	if platform_to_attach_to != null:
		platform_to_attach_to.objects_to_move.push_back(self)
	
	modulate = Color("c9a338") # good ol' yellow
	
	var hint_number = 0
	for hint in hints:
		hint_number += 1
		var hint_scene = load("res://scenes/objects/box_hint.tscn").instantiate()
		match hint:
			BoxTypes.SQUARE:
				hint_scene.texture = load("res://art/general/hint_square.png")
				hint_scene.rotation_degrees = 180
			BoxTypes.CIRCLE:
				hint_scene.texture = load("res://art/general/hint_circle.png")
			BoxTypes.TRIANGLE:
				hint_scene.texture = load("res://art/general/hint_triangle.png")
		
		if hints.size() == 2:
			#print("This is a landing zone with two boxes")
			if hint_number == 1:
				#print("Hint 0")
				hint_scene.position.x -= 50
			else:
				#print("Hint 1")
				hint_scene.position.x += 50
			
		elif hints.size() == 3:
			if hint_number == 1:
				hint_scene.position.x -= 80
			elif hint_number == 2:
				pass
				#hint_scene.position.x += 50
			else:
				hint_scene.position.x += 80
			
		hint_scene.position.y = -123
		add_child(hint_scene)
		#print("Box added!")
		#box_number += 1
	

func _process(_delta): # It would be best if this code only checked itself when a box moves or is dropped
	
	if won_already or len(colliding_bodies) < hints.size(): # Asks if there are enough boxes. This could be indented but activating at every new collision makes a less of a chance or not activating
		return
		
	for body in colliding_bodies:
		if body.get_meta("grabbed"): # Boxes that are being grabbed do not count
			return
			
		#print(abs(body.rotation_degrees))
		if upside_down:
			if abs(body.rotation_degrees) > 45: # More than 135 degrees means it is facing downwards. Works for negative rotation because of the abs(). Also works since if the rotation is more than 180 rotation the sign flips.
				return
		else: # Normal code for if the landing zone is facing up
			if body.rotation_degrees < 135 + rotation_degrees and body.rotation_degrees > -145 - rotation_degrees:
				#print("box rotation is not right")
				return
	
	#print("That passed!")
	won_already = true
	GlobalVariables.win_level(level)
	$Congratulations.play()
	camera.fade_out(true)
	
	if OS.get_name() == "Web":
		CPUParticles.emitting = true
	else:
		GPUParticles.emitting = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Box"):
		#print("New Box!")
		colliding_bodies.append(body)
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in colliding_bodies:
		colliding_bodies.remove_at(colliding_bodies.find(body))
	
