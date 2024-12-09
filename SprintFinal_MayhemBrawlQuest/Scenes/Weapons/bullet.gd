'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 11/10/2024
Purpose: Bullet Script
'''
extends RigidBody2D
#Has a speed and a timer so they bullets dissapear after a certain time
@export var speed: float = 400.0
@onready var despawn_timer: Timer = $Timer

#When they spawn by the player shoot them linearly and start the timer
func _ready():
	var direction = Vector2.RIGHT.rotated(rotation)
	linear_velocity = direction * speed
	despawn_timer.start()

#When they enter an enemy body, if they are part of the enemies call their function of taking damage and dissapear
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.take_damage(10,3)
		queue_free() 

#When the timer ends make the bullets dissapear
func _on_timer_timeout() -> void:
	queue_free() 
