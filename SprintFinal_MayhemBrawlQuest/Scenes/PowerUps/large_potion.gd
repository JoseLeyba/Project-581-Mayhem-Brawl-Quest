'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/28/2024
Last modified: 10/31/2024
Purpose: Large Health Potion Power Up Script
'''
extends Area2D
#Uses the animated sprite for the idle animation 
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D2
#Uses Game Manager to distribute the effect to the Players
@onready var game_manager: Node = %GameManager
@onready var pickup_sound: AudioStreamPlayer2D = $Pickup

#Amount of life it recovers
var large_heal = 10

#When created play its animation
func _ready() -> void:
	animated_sprite_2d.play("default")
	
#When the Player runs into the large potion, make it dissapear and call the game manager for adding it's effect to the specific player
func _on_body_entered(body: Node2D) -> void:
	pickup_sound.play()
	#Checks if the body is Player1
	if (body.name == "Player1"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(1,"Large Health Potion")
		#Calls add_health function in game_manager to increase the player's health by large_heal amount
		game_manager.add_health(1, large_heal)
	#Checks if the body is Player2
	if (body.name == "Player2"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(2, "Large Health Potion")
		#Calls add_health function in game_manager to increase the player's health by large_heal amount
		game_manager.add_health(2, large_heal )
