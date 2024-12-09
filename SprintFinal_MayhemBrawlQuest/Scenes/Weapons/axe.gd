'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 11/10/2024
Last modified: 11/10/2024
Purpose: Axe Weapon Script
'''
extends Node2D
#Here we have the speed for the swing, the angle it goes to, and timer for hitbox cooldown
@export var swing_speed: float = 7.0 
@export var max_angle: float = 1.5  
@onready var timer: Timer = $Timer
#For Audio
@onready var swing_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D  
#This variable updates with the timer so it doesnt hit every frame, the 1 for clockwise rotation and the 0 is the starting angle
var can_hit = true
var swing_direction: int = 1 
var current_angle: float = 0.0
var has_played_sound: bool = false
func _ready():
	var direction = Vector2.RIGHT.rotated(rotation)
	rotation = direction.angle()
	swing_sound.play()

# We call this every frame to update the swingin motion and angle
func _process(delta):
	# Update the current angle for the swinging motion
	current_angle += swing_direction * swing_speed * delta
	# When reaching the q.5 limit, switch the direction you are going
	if abs(current_angle) > max_angle:
		swing_direction *= -1
		current_angle = clamp(current_angle, -max_angle, max_angle)
		has_played_sound = false

	#Rotates the axe and hitbox as needed
	rotation = current_angle

#When its hitbox enters an enemy, deal damage and start the timer for frame protection
func _on_area_2d_body_entered(body: Node2D) -> void:
	if can_hit and body.is_in_group("Enemies"):
		body.take_damage(60,4)
		can_hit = false
		timer.start()

#When the timer runs out let them hit again
func _on_Timer_timeout() -> void:
	can_hit = true
