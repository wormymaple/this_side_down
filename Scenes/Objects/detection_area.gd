extends Area2D

@export var box : RigidBody2D
var move_box_state = "move"
var timer_started_yet = "no"

func _on_ready():
	
	#box.linear_velocity += Vector2(1, 0)
	pass

func _physics_process(_delta):
	pass
	#box.set_physics_process(false) # Does not move box
	##box.set_use_custom_integrator(true)
	#box.custom_integrator = true # does not move
#	box.freeze = true # Works but I can't unfreeze
	#box.sleeping = true # Does not move box
	
	#print(move_box_state)
#	if move_box_state == "move":
#		box.position += Vector2(2, 0)
#		if timer_started_yet == "no":
#			timer_started_yet = "yes"
#			await get_tree().create_timer(1).timeout
#			box.freeze = false
#			box.custom_integrator = false
#			box.sleeping = false
#			print("Box is still now")
#			move_box_state = "still"
	

#func move box

func _integrate_forces():
	pass
	#print("I am running")
	#box.linear_velocity += Vector2(1, 0)
	#linear_velocity
	#constant_force
	#position
	
	# Methods
	#add_constant_force
	#apply_central_force
	#apply_force
	
	#_integrate_forces

