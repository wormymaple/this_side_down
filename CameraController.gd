extends Camera2D

var players: Array

@export var min_dist: float
@export var min_scale: float
@export var scale_rate: float
@export var max_scale: float

@export var no_controller_path: NodePath
@export var no_controller_button: NodePath
@onready var button = get_node(no_controller_button)
@onready var no_controller = get_node(no_controller_path)
@export var background: Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(players) < 1: 
		if !no_controller.visible:
			no_controller.visible = true
			button.visible = true
			background.visible = true
		return
	
	if Input.is_action_just_pressed("cancel"):
		if !button.visible:
			button.visible = true
			background.visible = true
	
	if Input.is_action_just_pressed("confirm") and button.visible:
		button._on_button_down()
	
	var pos = Vector2.ZERO;
	for player in players:
		pos += player.global_position
	pos /= len(players)
	
	global_position = pos	
	
	var furthest_player = players[0]
	var furthest_dist = (position - furthest_player.global_position).length()
	for player in players: # dist check
		var dist = (position - player.global_position).length()
		if dist > furthest_dist:
			furthest_player = player
			furthest_dist = dist
		
	if furthest_dist > min_dist:
		var target_zoom = (furthest_dist - min_dist) * scale_rate + min_scale
		if target_zoom < max_scale:
			target_zoom = max_scale
			
		zoom = target_zoom * Vector2.ONE
	else:
		zoom = min_scale * Vector2.ONE
