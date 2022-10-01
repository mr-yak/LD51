extends RigidBody

var power = 4
var velocity = Vector3.ZERO

func _ready():
	add_central_force(Vector3(0,-9.81,0))

func _process(_delta):
	velocity = linear_velocity
	if Input.is_action_just_pressed("forward"):
		velocity += Vector3.FORWARD
	elif Input.is_action_just_released("forward"):
		velocity -= Vector3.FORWARD
	if Input.is_action_just_pressed("back"):
		velocity += Vector3.BACK
	elif Input.is_action_just_released("back"):
		velocity -= Vector3.BACK
	if Input.is_action_just_pressed("left"):
		velocity += Vector3.LEFT
	elif Input.is_action_just_released("left"):
		velocity -= Vector3.LEFT
	if Input.is_action_just_pressed("right"):
		velocity += Vector3.RIGHT
	elif Input.is_action_just_released("right"):
		velocity -= Vector3.RIGHT

func _physics_process(_delta):

	if Input.is_action_just_pressed("jump") && get_colliding_bodies().size()>=1:
		apply_central_impulse(Vector3.UP*power)
	linear_velocity = velocity
	
