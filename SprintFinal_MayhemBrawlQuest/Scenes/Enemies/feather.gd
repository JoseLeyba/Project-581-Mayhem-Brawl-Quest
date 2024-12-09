'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 12/7/2024
Last modified: 12/7/2024
Purpose: Feather Script for The Duck Enemy attack
'''
extends RigidBody2D
@onready var game_manager: Node = get_parent().get_parent().get_parent().get_node("GameManager")
@export var speed: float = 800.0  # Feather speed
var direction: Vector2 = Vector2.ZERO  # Direction of movement
@onready var fireball_timer: Timer = $Timer
func _ready():
	# Not affected by gravity
	gravity_scale = 0.0

func _physics_process(delta):
	# Move in the direction set by the dragon
	linear_velocity = direction * speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	#Checks if the body entered is Player1
	if body.name == "Player1":
		#Decrease the health of the player using the decrease_health function in game_manageer
		game_manager.decrease_health(1, 2, false, 0)
		queue_free()
	#Checks if the body entered is Player2
	elif body.name == "Player2":
		#Decrease the health of the player using the decrease_health function in game_manageer
		game_manager.decrease_health(2, 2, false, 0)
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
