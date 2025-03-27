extends StaticBody2D

enum Themes {YELLOW, GREEN, BLUE, PURPLE}
@export var theme: Themes = Themes.YELLOW
@export var time_interval: int = 5
@export var landing_zone: RigidBody2D
@export var ReleaseCurve: Curve

enum State {WAIT, PUSH, RETRACT}
var mode: State# = State.WAIT

@onready var TextureHead = $PistonHead
@onready var TextureBase = $PistonBase
@onready var DeleteHitbox = $Deleter
@onready var Collider = $AnimatableBody2D
@onready var ReleaseTimer = $Timer

func _ready():
	$Timer.wait_time = time_interval
	#print("Piston is ready")
	mode = State.WAIT
	#set_process(true)
	
	match theme:
		Themes.YELLOW:
			modulate = Color("c9a338")
		Themes.BLUE:
			modulate = Color("377abd")
		Themes.GREEN:
			modulate = Color("008a5e")
		Themes.PURPLE:
			modulate = Color("000000")

func _process(_delta):
	if mode == State.WAIT:
		#print("Am waiting")
		return
	
	elif mode == State.PUSH: # Stretches the piston
		if TextureHead.scale.y < .5:
			TextureHead.scale.y += 0.02
			TextureHead.position.y -= 3
			DeleteHitbox.position.y -= 12
			Collider.position.y -= 12
		else:
			mode = State.RETRACT
	
	elif mode == State.RETRACT: # Retracts the piston
		if TextureHead.scale.y > 0.065: # 0.078
			TextureHead.scale.y -= 0.02
			TextureHead.position.y += 3
			DeleteHitbox.position.y += 12
			Collider.position.y += 12
		else:
			mode = State.WAIT
	
	#print((ReleaseTimer.time_left))
	var height = -ReleaseCurve.sample(1 - ReleaseTimer.time_left)
	
	Top.position.y = height # I am technically doing this backwards, but that's okay since the curve is identical both sides
	$Line2D.points[0].y = height + 10
	$Line2D.points[5].y = height + 10
	
	$Line2D.points[1].y = (16 + $Line2D.points[0].y) / 2
	$Line2D.points[4].y = (16 + $Line2D.points[0].y) / 2
	
	
	

func _on_timer_timeout():
	#print("Timer timed out")
	mode = State.PUSH

func _on_area_2d_input_event(_viewport, event, shape_idx): # I don't know what this does, maybe I was just testing what this did for the first time?
	print("Input event!: ", event, ", ", shape_idx)


func _on_deleter_body_entered(body):
	#print(body.name)
	if body.is_in_group("Box") or body.is_in_group("Player"):
		body.call_deferred("queue_free")
		get_tree().reload_current_scene()
	
