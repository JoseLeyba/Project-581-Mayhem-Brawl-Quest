'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 11/22/2024
Last modified: 11/22/2024
Purpose: Triple Jump Powerup
'''
extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var pickup_sound: AudioStreamPlayer2D = $Pickup

#The time triple jump lasts
var triple_duration = 15

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
		game_manager.add_powerup(1, "Triple Jump")
		#adds the triple jump power up
		game_manager.add_tripleJump(1,triple_duration)
	#Checks if the body is Player2
	if (body.name == "Player2"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(2, "Triple Jump")
		#adds the triple jump power up
		game_manager.add_tripleJump(2,triple_duration)
