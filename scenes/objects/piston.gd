extends StaticBody2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE}
@export var theme: Themes = Themes.YELLOW
@export var time_interval: int = 5
@export var landing_zone: RigidBody2D

enum State {WAIT, PUSH, RETRACT}
var mode: State# = State.WAIT

@onready var TextureHead = $PistonHead
@onready var TextureBase = $PistonBase
@onready var hitbox = $Deleter
@onready var collider = $AnimatableBody2D

func _ready():
	$Timer.wait_time = time_interval
	print("Piston is ready")
	mode = State.WAIT
	#set_process(true)
	
	if theme == Themes.YELLOW:
		TextureHead.texture = load("res://art/area_1/PistonTop.png")
		TextureBase.texture = load("res://art/area_1/piston_base.png")
	elif theme == Themes.BLUE:
		TextureHead.texture = load("res://art/area_2/piston_top.png")
		TextureBase.texture = load("res://art/area_2/piston_base.png")
	elif theme == Themes.GREEN:
		TextureHead.texture = load("res://art/area_3/piston_top.png")
		TextureBase.texture = load("res://art/area_3/piston_base.png")
	elif theme == Themes.PURPLE:
		TextureHead.texture = load("res://art/area_4/piston_top.png")
		TextureBase.texture = load("res://art/area_4/piston_base.png")

func _process(_delta):
	if mode == State.WAIT:
		#print("Am waiting")
		return
	
	elif mode == State.PUSH: # Stretches the piston
		if TextureHead.scale.y < .5:
			TextureHead.scale.y += 0.02
			TextureHead.position.y -= 3
			hitbox.position.y -= 12
			collider.position.y -= 12
		else:
			mode = State.RETRACT
	
	elif mode == State.RETRACT: # Retracts the piston
		if TextureHead.scale.y > 0.065: # 0.078
			TextureHead.scale.y -= 0.02
			TextureHead.position.y += 3
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
