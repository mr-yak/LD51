extends RigidBody

var power = 10
func _physics_process(delta):
	if Input.is_action_pressed("jump"):
		if(get_colliding_bodies() != []):
			add_central_impulse(Vector3.UP*power)
		
