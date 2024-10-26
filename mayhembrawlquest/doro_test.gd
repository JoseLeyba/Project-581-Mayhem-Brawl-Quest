extends KinematicBody2D
extends KinematicBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var sword = $Sword # Assume Sword is a child node

func _physics_process(delta):
    velocity.x = 0
    if Input.is_key_pressed(KEY_D):
        velocity.x = SPEED
    elif Input.is_key_pressed(KEY_A):
        velocity.x = -SPEED

    if not is_on_floor():
        velocity.y += gravity * delta

    if Input.is_key_pressed(KEY_W) and is_on_floor():
        velocity.y = JUMP_VELOCITY

    move_and_slide(velocity, Vector2.UP)

    # Trigger attack on button press
    if Input.is_action_just_pressed("attack_p1"):
        sword.attack()
