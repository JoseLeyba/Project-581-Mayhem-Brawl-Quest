'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 11/09/2024
Last modified: 11/09/2024
Purpose: Lava Pit Platform
'''

extends AnimatableBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
#Uses Game Manager to distribute the effect to the Players
@onready var game_manager: Node = %GameManager
#This is used to time until the next damage is taken
@onready var damage_timer: Timer = %DamageTimer

#List to keep track of players in the lava area
var players_in_area = []
#To keep track if the timer is on
var is_timer_running = false
#To ensure that damage is applied upon entry
var first_hit = true

#When running the code it will start playing it's default animation
func _ready() -> void:
	animated_sprite_2d.play("default")

#This function will be called if something enters the lava
func _on_area_2d_body_entered(body: Node2D) -> void:
	#Checks if the body is Player1 or Player2
	if (body.name == "Player1") or (body.name == "Player2"): 
		#Checks if this is the first hit
		if first_hit:
			#applys the immediate damage
			apply_initial_damage(body.name)
			#Disables the first_hit 
			first_hit = false
		#Checks if the player's name is not in the list already and adds it
		if not players_in_area.has(body.name):
			players_in_area.append(body.name)
		#Checks if the timer isn't running and starts it 
		if not is_timer_running:
			damage_timer.wait_time = .25
			damage_timer.start()
			is_timer_running = true

#This function is called whenever a body exits the lava area
func _on_area_2d_body_exited(body: Node2D) -> void:
	#Removes the player from the area list if they are leaving
	if players_in_area.has(body.name):
		players_in_area.erase(body.name)
	#If there are no players in the area, stop the timer and reset states
	if players_in_area.is_empty():
		damage_timer.stop()
		is_timer_running = false
		first_hit = true

#Function to apply initial damage to a player upon first entry
func apply_initial_damage(player_name: String) -> void:
	#Checks if the name is Player1
	if player_name == "Player1":
		#Decreases the health of player1
		game_manager.decrease_health(1, 1, false, 0)
	#Checks if the name is Player2
	if player_name == "Player2":
		#decreases the health of player2
		game_manager.decrease_health(2, 1, false, 0)

#Called when the damage timer times out to apply continuous damage to players in the area
func _on_damage_timer_timeout() -> void:
	#Loop through each player in the fan area and apply damage
	for player_name in players_in_area:
		#Checks if the name is Player1
		if (player_name  == "Player1"): 
			#Decreases the health of player1
			game_manager.decrease_health(1, 1, false, 0)
		#Checks if the name is Player2
		if (player_name == "Player2"):
			#decreases the health of player2
			game_manager.decrease_health(2, 1, false, 0)
