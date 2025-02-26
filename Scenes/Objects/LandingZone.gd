extends Node2D

@export var boxes_required: int = 1
@export var camera: Camera2D
@export var level: int = 1

@onready var Particles = $GPUParticles2D

var colliding_bodies: Array[Node2D]
var won_already = false

func _process(_delta):
	if !won_already and len(colliding_bodies) >= boxes_required: # Asks if there are enough boxes. This could be indented but activating at every new collision makes a less of a chance or not activating
		for body in colliding_bodies:
			if body.is_in_group("Box"): # Maybe I should give boxes and the landing zone its own collision layer
				if body.get_meta("grabbed"): # Boxes that are being grabbed do not count
					return
				if abs(body.rotation_degrees) < 180 - 35: # Has to be the facing downwards
					return
		won_already = true
		#print("You Win!")
		GlobalVariables.win_level(level)
		Particles.emitting = true
		camera.fade_out(true)
		

func _on_body_entered(new_body):
	if new_body.is_in_group("Box"):
		print("New Box!")
		colliding_bodies.append(new_body)

func _on_body_exited(body):
	if body in colliding_bodies:
		colliding_bodies.remove_at(colliding_bodies.find(body))
