extends StaticBody2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE}
@export var theme: Themes = Themes.YELLOW
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
	
	if theme == Themes.YELLOW:
		head_texture.texture = load("res://Art/First Level/UI_PistonTop.png")
		$PistonBase.texture = load("res://Art/First Level/UI_PistonBase.png")
	elif theme == Themes.BLUE:
		head_texture.texture = load("res://Art/third level/UI_PistonTop.png")
		$PistonBase.texture = load("res://Art/third level/UI_PistonBase.png")
	elif theme == Themes.GREEN:
		head_texture.texture = load("res://Art/second level/UI_PistonTop.png")
		$PistonBase.texture = load("res://Art/second level/UI_PistonBase.png")
	elif theme == Themes.PURPLE:
		head_texture.texture = load("res://Art/Fourth Level/UI_PistonTop.png")
		$PistonBase.texture = load("res://Art/Fourth Level/UI_PistonBase.png")

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
	#print(body.name)
	if body.is_in_group("Box") or body.is_in_group("Player"):
		body.queue_free()
		get_tree().reload_current_scene()


#func _on_deleter_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	if body.is_in_group("Player") or body.is_in_group("Box"):
#		print(body.name)
#		body.queue_free()
