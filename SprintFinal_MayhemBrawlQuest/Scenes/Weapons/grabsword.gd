'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 11/7/2024
Last modified: 11/7/2024
Purpose: Grabing Sword Script
'''
extends Node2D
# Function to handle collision with a player
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Characters"):
		body.weapon_change("sword")
		if body.name == "Player1":
			GlobalData.save_player1_weapon("sword")
		if body.name == "Player2":
			GlobalData.save_player2_weapon("sword")
		queue_free()