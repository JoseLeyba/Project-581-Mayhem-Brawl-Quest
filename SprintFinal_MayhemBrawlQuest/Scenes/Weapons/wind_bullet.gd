'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 11/7/2024
Last modified: 11/7/2024
Purpose: Wind Bullet Script
'''
extends RigidBody2D
#Has a speed and a timer so they bullets dissapear after a certain time
@export var speed: float = 400.0
@onready var despawn_timer: Timer = $Timer
@onready var wind_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D  

#When they spawn by the player shoot them linearly and start the timer
func _ready():
	linear_velocity = Vector2(speed, 0).rotated(rotation)
	despawn_timer.start()
	gravity_scale = 0.0
	wind_sound.play()

#When they enter an enemy body, if they are part of the enemies call their function of taking damage and dissapear
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.take_damage(80,5)
		queue_free() 

#When the timer ends make the bullets dissapear
func _on_timer_timeout() -> void:
	queue_free() 
