extends StaticBody2D

@export var sprite: Texture
@export var time_interval: float = 5

enum State {WAIT, PUSH, RETRACT}
var mode: State = State.WAIT

@onready var texture = $Sprite2D
@onready var crusher = $Area2D


func _ready():
	$Timer.wait_time = time_interval


func _process(delta):
	if mode == State.WAIT:
		return
	
	elif mode == State.PUSH:
		if texture.scale.y < .324:
			texture.scale.y += 0.02
			texture.position.y -= 8.5
			crusher.position.y -= 16
		else:
			mode = State.RETRACT
	
	elif mode == State.RETRACT:
		if texture.scale.y > 0.081:
			texture.scale.y -= 0.02
			texture.position.y += 8.5
			crusher.position.y += 16
		else:
			mode = State.WAIT
	


func _on_timer_timeout():
	mode = State.PUSH
