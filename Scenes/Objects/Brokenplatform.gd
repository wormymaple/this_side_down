extends StaticBody2D

@export var player = Node2D
@export var path = Path2D

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#print(str(position.y - player.position.y))
	if player.position.y < position.y - 68:
		self.set_collision_layer_value(1, true)
	else:
		self.set_collision_layer_value(1, false)
		#print("platform is passable")
	
	if path != null: # Commence pathfinding
		for 
