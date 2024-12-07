'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 10/31/2024
Purpose: Sword Script
'''
extends Node2D
@export var knockback_strength: float = 200.0  
@export var hit_cooldown: float = 0.5  
var can_hit = true
@onready var timer: Timer = $Timer
@onready var stab_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D  

# Function to handle collision with an enemy
func _on_area_2d_body_entered(body: Node2D) -> void:
	if can_hit and body.is_in_group("Enemies"):
		body.take_damage(30,0)
		can_hit = false
		timer.start()
		stab_sound.play()

#After timer runs our, allow it to hit again (so you dont damage every frame)
func _on_Timer_timeout() -> void:
	can_hit = true
