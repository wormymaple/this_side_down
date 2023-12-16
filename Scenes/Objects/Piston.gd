extends StaticBody2D

@export var sprite: Texture
@export var time_interval: int = 5
@export var landing_zone: RigidBody2D

enum State {WAIT, PUSH, RETRACT}
var mode: State# = State.WAIT

@onready var head_texture = $PistonHead
@onready var hitbox = $Deleter
@onready var collider = $AnimatableBody2D

func _ready():
	$Timer.wait_time = time_interval
	print("Piston is ready")
	mode = State.WAIT
	#set_process(true)

#func _process_delta():
func _process(_delta):
	#print("Hello from process delta")
	if mode == State.WAIT:
		#print("Am waiting")
		return
	
	elif mode == State.PUSH: # Stretches the piston
		if head_texture.scale.y < .5:
			head_texture.scale.y += 0.02
			head_texture.position.y -= 3
			hitbox.position.y -= 12
			collider.position.y -= 12
		else:
			mode = State.RETRACT
	
	elif mode == State.RETRACT: # Retracts the piston
		if head_texture.scale.y > 0.065: # 0.078
			head_texture.scale.y -= 0.02
			head_texture.position.y += 3
			hitbox.position.y += 12
			collider.position.y += 12
		else:
			mode = State.WAIT
	



func _on_timer_timeout():
	print("Timer timed out")
	mode = State.PUSH


func _on_area_2d_input_event(_viewport, event, shape_idx):
	print("Input event!: ", event, ", ", shape_idx)


func _on_deleter_body_entered(body):
	if body.is_in_group("Box") or body.is_in_group("Player"):
		#print(body.name)
		body.queue_free()
		landing_zone._on_void_out_area_body_entered(body)


#func _on_deleter_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	if body.is_in_group("Player") or body.is_in_group("Box"):
#		print(body.name)
#		body.queue_free()
