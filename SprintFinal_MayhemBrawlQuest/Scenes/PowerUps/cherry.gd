'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 10/31/2024
Purpose: Cherry Power Up Script
'''

extends Area2D
#Uses Game Manager to distribute the effect to the Players
@onready var game_manager: Node = %GameManager
@onready var pickup_sound: AudioStreamPlayer2D = $Pickup


#Uses the animated sprite for the idle animation 
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


#Amount of life it recovers
var cherry_heal = 1

#When created play its animation
func _ready() -> void:
	animated_sprite_2d.play("default")
	
#When the Player runs into the cherry, make it dissapear and call the game manager for adding it's effect to the specific player
func _on_body_entered(body: Node2D) -> void:
	pickup_sound.play()
	#Checks if the body is Player1
	if (body.name == "Player1"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(1,"Cherry")
		#Calls add_health function in game_manager to increase the player's health by cheal_heal amount
		game_manager.add_health(1,cherry_heal)
	#Checks if the body is Player2
	if (body.name == "Player2"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(2,"Cherry")
		#Calls add_health function in game_manager to increase the player's health by cheal_heal amount
		game_manager.add_health(2,cherry_heal)
		
		
