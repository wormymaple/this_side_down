extends Node2D

@export var handler_script: NodePath
@onready var handler = get_node(handler_script)

@export var particles: GPUParticles2D

var colliding_body;

func _process(_delta):
	if colliding_body != null:
		handler._on_zone_body_body_entered(colliding_body)

func body_collide(body):
	if body.is_in_group("Box"):
		colliding_body = body

func body_exit(body):
	if body == colliding_body:
		colliding_body = null
		
func play_particles():
	particles.emitting = true
