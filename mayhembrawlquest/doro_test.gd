extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	# if no key is pressed for left or right, x velocity is zero
	velocity.x = 0
	if Input.is_key_pressed(KEY_D):
		velocity.x = SPEED
	elif Input.is_key_pressed(KEY_A):
		velocity.x = -SPEED
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.w
	if Input.is_key_pressed(KEY_W) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()
