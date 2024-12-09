'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 11/22/2024
Last modified: 11/22/2024
Purpose: Spped Powerup
'''
extends Area2D
@onready var game_manager: Node = %GameManager
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var pickup_sound: AudioStreamPlayer2D = $Pickup

#The time speed lasts
var speed_duration = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("default")


func _on_body_entered(body: Node2D) -> void:
	pickup_sound.play()
	#Checks if the body is Player1
	if (body.name == "Player1"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(1, "Increased Running Speed")
		#adds the running speed power up
		game_manager.add_speed(1,speed_duration)
	#Checks if the body is Player2
	if (body.name == "Player2"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(2,"Increased Running Speed")
		#adds the running speed power up
		game_manager.add_speed(2,speed_duration)
