extends RigidBody2D

enum Themes {BOX, CRATE, SHIP, UNDERWATER}
@export var theme: Themes = Themes.BOX
@export var size: float = 1
@onready var sprite = $BoxSprite
@onready var collision = $Collision
#@onready var arrow = $ArrowSprite
var rng = RandomNumberGenerator.new()
# Not box sprites have a scale of 0.145
# boxes should have a scale of 0.346
var can_play_sound = false

func _ready():
	if self.is_in_group("square"):
		match theme:
			Themes.BOX:
				sprite.texture = load("res://art/area_1/box_square.png")
				sprite.scale = Vector2(0.346, 0.346)
			Themes.CRATE:
				sprite.texture = load("res://art/area_2/crate_square.png")
			Themes.SHIP:
				sprite.texture = load("res://art/area_3/crate_square.png")
			Themes.UNDERWATER:
				sprite.texture = load("res://art/area_4/crate_square.png")
	elif self.is_in_group("circle"):
		match theme:
			Themes.BOX:
				sprite.texture = load("res://art/area_1/box_circle.png")
				sprite.scale = Vector2(0.34, 0.34)
			Themes.CRATE:
				sprite.texture = load("res://art/area_2/crate_circle.png")
			Themes.SHIP:
				sprite.texture = load("res://art/area_3/crate_circle.png")
			Themes.UNDERWATER:
				sprite.texture = load("res://art/area_4/crate_circle.png")
	else:
		match theme:
			Themes.BOX:
				sprite.texture = load("res://art/area_1/box_triangle.png")
				sprite.scale = Vector2(0.37, 0.37)
			Themes.CRATE:
				sprite.texture = load("res://art/area_2/crate_triangle.png")
				sprite.rotation_degrees = 179.4
			Themes.SHIP:
				sprite.texture = load("res://art/area_3/crate_triangle.png")
				sprite.rotation_degrees = 179.4
			Themes.UNDERWATER:
				sprite.texture = load("res://art/area_4/crate_triangle.png")
				sprite.rotation_degrees = 179.4
		
	sprite.scale *= Vector2(size, size) # Uses *= instead of just = because the starting sprite size is 0.145 
	collision.scale *= Vector2(size, size)
	
	#print("Inverse inertia: ", PhysicsServer2D.body_get_direct_state(self.get_rid()).inverse_inertia)
	#print(inertia)
	
	#if size >= 2: # i think this moves the arrow closer to the center if the box is big
	#	arrow.position.x -= 20
	#	arrow.position.y -= 20


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		return
		#print(body.tile_set.get_physics_layer_collision_layer(0))
	#print("Collision layer values: ", body.get_collision_layer_value())
	#
	if not can_play_sound:
		return
	print("Velocity length: ", linear_velocity.length())
	#print("Velocity length: (", linear_velocity.x, "")
	#print("Velocity length: ", abs(int(linear_velocity.x)), ", ", abs(int(linear_velocity.y)))
	match rng.randi_range(1, 2):
		1:
			if abs(rotation_degrees) > 135 and abs(rotation_degrees) < 225:
				$GlassSound1.play()
			else:
				$BoxSound1.play()
		2:
			if abs(rotation_degrees) > 135 and abs(rotation_degrees) < 225:
				$GlassSound2.play()
			else:
				$BoxSound2.play()
	
	can_play_sound = false
	$Timer.start()


func _on_timer_timeout() -> void:
	can_play_sound = true
