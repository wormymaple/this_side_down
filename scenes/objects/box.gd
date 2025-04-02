extends RigidBody2D

enum Themes {NORMAL, SHIP, UNDERWATER}
@export var theme: Themes = Themes.NORMAL
@export var size: float = 1
@onready var sprite = $BoxSprite
@onready var collision = $Collision
#@onready var arrow = $ArrowSprite

func _ready():
	if self.is_in_group("square"):
		if theme == Themes.NORMAL:
			sprite.texture = load("res://art/area_1/crate_square.png")
		elif theme == Themes.SHIP:
			sprite.texture = load("res://art/area_2/crate_square.png")
		elif theme == Themes.UNDERWATER:
			sprite.texture = load("res://art/area_4/crate_square.png")
	elif self.is_in_group("circle"):
		if theme == Themes.NORMAL:
			sprite.texture = load("res://art/area_1/crate_circle.png")
		elif theme == Themes.SHIP:
			sprite.texture = load("res://art/area_2/crate_circle.png")
		elif theme == Themes.UNDERWATER:
			sprite.texture = load("res://art/area_4/crate_circle.png")
	else:
		if theme == Themes.NORMAL:
			sprite.texture = load("res://art/area_1/crate_triangle.png")
		elif theme == Themes.SHIP:
			sprite.texture = load("res://art/area_2/crate_triangle.png")
		elif theme == Themes.UNDERWATER:
			sprite.texture = load("res://art/area_4/crate_triangle.png")
		
	sprite.scale *= Vector2(size, size) # Uses *= instead of just = because the starting sprite size is 0.145 
	collision.scale *= Vector2(size, size)
	
	#print("Inverse inertia: ", PhysicsServer2D.body_get_direct_state(self.get_rid()).inverse_inertia)
	#print(inertia)
	
	#if size >= 2: # i think this moves the arrow closer to the center if the box is big
	#	arrow.position.x -= 20
	#	arrow.position.y -= 20
