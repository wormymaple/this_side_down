extends Node2D

@export var handler_script: NodePath
@onready var handler = get_node(handler_script)
@export var boxes_required: int

@export var particles: GPUParticles2D

var colliding_bodies: Array[Node2D];

func _process(_delta):
	if len(colliding_bodies) >= boxes_required:
		handler._on_zone_body_body_entered(colliding_bodies)

func body_collide(body):
	if body.is_in_group("Box"):
		colliding_bodies.append(body)

func body_exit(body):
	if body in colliding_bodies:
		colliding_bodies.remove_at(colliding_bodies.find(body))
		
func play_particles():
	particles.emitting = true
