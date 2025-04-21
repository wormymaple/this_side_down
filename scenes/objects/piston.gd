extends StaticBody2D


enum Themes {YELLOW, GREEN, BLUE, PURPLE}
@export var theme: Themes = Themes.YELLOW
@export var time_interval: int = 5
@export var landing_zone: RigidBody2D
@export var ReleaseCurve: Curve
@export var WiggleCurve: Curve
@export_range(0, 500, 1) var deploy_length = 300

enum States {WAIT, MOVING}
var mode = States.WAIT

@onready var TextureHead = $PistonHead
@onready var TextureBase = $PistonBase
@onready var DeleteHitbox = $Deleter
@onready var Collider = $AnimatableBody2D
@onready var ReleaseTimer = $ReleaseTimer
@onready var IntervalTimer = $IntervalTimer
@onready var OuterShaft = $OuterShaft
@onready var InnerShaft = $InnerShaft

func _ready():
	IntervalTimer.wait_time = time_interval # And then this timer autostarts
	mode = States.WAIT
	#IntervalTimer.start()
	
	match theme:
		Themes.YELLOW:
			modulate = Color("c9a338")
		Themes.BLUE:
			modulate = Color("377abd")
		Themes.GREEN:
			modulate = Color("008a5e")
		Themes.PURPLE:
			modulate = Color("#482c84")

func _process(_delta):
	if mode == States.WAIT:
		#print("Am waiting")
		return
	
	#print((ReleaseTimer.time_left))
	var height = deploy_length * -ReleaseCurve.sample((2 - ReleaseTimer.time_left ) / 2) - 25 # Multiply it by a multiplier
	
	TextureHead.position.y = height
	Collider.position.y = height
	DeleteHitbox.position.y = height
	OuterShaft.points[1].y = height
	InnerShaft.points[1].y = height
	
	TextureHead.position.x = WiggleCurve.sample(2 - ReleaseTimer.time_left) # Shake back and forth to indicate for the player
	

func _on_deleter_body_entered(body):
	#print(body.name)
	if body.is_in_group("Player"): # or body.is_in_group("Box")
		if body.on_ground:
			body.call_deferred("queue_free")
			get_tree().call_deferred("reload_current_scene")
			if GlobalVariables.controller_rumble:
				Input.start_joy_vibration(int(body.playerID.right(1)) - 1, 1, 1, 0.2)
	


func _on_interval_timer_timeout() -> void:
	print("Release started")
	mode = States.MOVING
	ReleaseTimer.start()
	
func _on_deploy_timer_timeout() -> void:
	mode = States.WAIT
	IntervalTimer.start()
