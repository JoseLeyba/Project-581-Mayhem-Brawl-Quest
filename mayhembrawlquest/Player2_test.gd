extends KinematicBody2D  # Make sure this is only declared once

const SPEED = 500.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
onready var sword = $Sword  # Sword node should be a child node

func _ready():
    # Initialize the player's weapon here if needed
    sword = preload("res://Sword.tscn").instance()
    add_child(sword)

func _physics_process(delta):
    velocity.x = 0
    if Input.is_key_pressed(KEY_L):
        velocity.x = SPEED
    elif Input.is_key_pressed(KEY_J):
        velocity.x = -SPEED

    if not is_on_floor():
        velocity.y += gravity * delta

    if Input.is_key_pressed(KEY_I) and is_on_floor():
        velocity.y = JUMP_VELOCITY

    move_and_slide(velocity, Vector2.UP)
    
    # Trigger attack on button press
    if Input.is_action_just_pressed("attack_p2"):
        sword.attack()

func attack():
    if sword:
        sword.attack()  # Call the sword's attack function
