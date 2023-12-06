extends Node2D

#@export var level_root: Node2D
@onready var level_root = owner
@export var boxes_required: int = 1

@export var particles: GPUParticles2D

var colliding_bodies: Array[Node2D];

func _process(_delta):
	if len(colliding_bodies) >= boxes_required:
		level_root._on_zone_body_body_entered(colliding_bodies)

func play_particles():
	particles.emitting = true


func _on_body_entered(body):
	if body.is_in_group("Box"):
		colliding_bodies.append(body)

func _on_body_exited(body):
	if body in colliding_bodies:
		colliding_bodies.remove_at(colliding_bodies.find(body))
