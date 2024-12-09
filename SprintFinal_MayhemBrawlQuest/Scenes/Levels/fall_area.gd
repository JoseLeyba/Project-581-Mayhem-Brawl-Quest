'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 11/24/2024
Purpose: Fall Area Script
'''
extends Area2D

#When the Player (1 or 2) falls of the screen, it "dies" and reloads the level
func _on_body_entered(body: Node2D) -> void:
	#Checks if the body that falls of the screen was Player1
	if (body.name == "Player1"):
		%GameManager.player_1_health = 0
		$"../PlayerGroup/Player1".queue_free()
		#Reloads the whole scene to the beginning
		#get_tree().reload_current_scene()
		if %GameManager.is_multi_player and %GameManager.player_2_health > 0:
			%GameManager.player2_camera.make_current()
		else:
			check_restart_condition()
	#Checks if the body that falls of the screen was Player2
	elif (body.name == "Player2"):
		%GameManager.player_2_health = 0
		$"../PlayerGroup/Player2".queue_free()
		#Reloads the whole scene to the beginning
		#get_tree().reload_current_scene()
		if %GameManager.is_multi_player and %GameManager.player_1_health > 0:
			%GameManager.player1_camera.make_current()
		else:
			check_restart_condition()
		#Reloads the whole scene to the beginning
		#get_tree().reload_current_scene()
		
func check_restart_condition() -> void:
	if %GameManager.is_multi_player:
		if %GameManager.player_1_health <= 0 and %GameManager.player_2_health <= 0:
			%GameManager.losing_screen()
	else:
		#get_tree().reload_current_scene()
		%GameManager.losing_screen()

		
