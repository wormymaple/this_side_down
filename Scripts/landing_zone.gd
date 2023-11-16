extends Node2D

@export var handler_script: NodePath
@onready var handler = get_node(handler_script)

@export var particles: GPUParticles2D

func body_collide(body):
	handler._on_zone_body_body_entered(body)
	
func play_particles():
	particles.emitting = true
