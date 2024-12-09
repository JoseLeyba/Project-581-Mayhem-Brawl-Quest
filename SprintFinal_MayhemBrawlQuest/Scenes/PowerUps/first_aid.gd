'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/28/2024
Last modified: 10/31/2024
Purpose: First Aid Power Up Script
'''
extends Area2D
#Uses Game Manager to distribute the effect to the Players
@onready var game_manager: Node = %GameManager
#Uses the animated sprite for the idle animation 
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var pickup_sound: AudioStreamPlayer2D = $Pickup

#Amount of life it recovers
var first_aid_heal = 5

#When created play its animation
func _ready() -> void:
	animated_sprite_2d.play("default")
	
#When the Player runs into the medical kit, make it dissapear and call the game manager for adding it's effect to the specific player
func _on_body_entered(body: Node2D) -> void:
	pickup_sound.play()
	#Checks if the body is Player1
	if (body.name == "Player1"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(1,"First Aid Kit")
		#Calls add_health function in game_manager to increase the player's health by first_aid_heal amount
		game_manager.add_health(1, first_aid_heal)
	#Checks if the body is Player2
	if (body.name == "Player2"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls add_powerup function in game_manager which will display the power up
		game_manager.add_powerup(2, "First Aid Kit")
		#Calls add_health function in game_manager to increase the player's health by first_aid_heal amount
		game_manager.add_health(2, first_aid_heal)
