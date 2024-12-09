'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/28/2024
Last modified: 10/31/2024
Purpose: Invincinbility Power Up Script
'''
extends Area2D
#Uses the animated sprite for the idle animation 
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var pickup_sound: AudioStreamPlayer2D = $Pickup

#Uses Game Manager to distribute the effect to the Players
@onready var game_manager: Node = %GameManager
#The time invicibility lasts
var invincinbility_duration = 15

#When created play its animation
func _ready() -> void:
	animated_sprite_2d.play("default")

#When the Player runs into the invicibility potion, make it dissapear and call the game manager for adding it's effect to the specific player
func _on_body_entered(body: Node2D) -> void:
	pickup_sound.play()
	#Checks if the body is Player1
	if (body.name == "Player1"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(1, "Invincinbility Potion")
		#Calls add_invincinbility function which will set a timer for the invincinbility_duration and only have the invinvinbility power up for that time
		game_manager.add_invincinbility(1,invincinbility_duration)
	#Checks if the body is Player2
	if (body.name == "Player2"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(2, "Invincinbility Potion")
		#Calls add_invincinbility function which will set a timer for the invincinbility_duration and only have the invinvinbility power up for that time
		game_manager.add_invincinbility(2,invincinbility_duration)
