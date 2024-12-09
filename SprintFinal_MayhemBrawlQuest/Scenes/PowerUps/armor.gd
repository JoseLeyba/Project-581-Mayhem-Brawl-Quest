'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/28/2024
Last modified: 10/31/2024
Purpose: Armor Power Up Script 
'''
extends Area2D
#Uses Game Manager to distribute the effect to the Players
@onready var game_manager: Node = %GameManager
#Uses the animated sprite for the idle animation 
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_sound: AudioStreamPlayer2D = $Pickup

#Stablish the durability of the armor
var armor_durability = 50
#When running the code it will start playing it's default animation
func _ready() -> void:
	animated_sprite_2d.play("default")

#When the Player runs into the Armor, make it dissapear and call the game manager for adding it's effect to the specific player
func _on_body_entered(body: Node2D) -> void:
	pickup_sound.play()
	#Checks if the body is Player1
	if (body.name == "Player1"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls the add_armor in game_manger.gd
		#With the parameters being 1 for player1 and the durability of the armor 
		game_manager.add_armor(1, armor_durability)
	#Checks if the body is Player2
	if (body.name == "Player2"):
		#Gets rid of the armor power up from the scene
		queue_free()
		#Calls the add_armor in game_manger.gd
		#With the parameters being 2 for player1 and the durability of the armor 
		game_manager.add_armor(1, armor_durability)
