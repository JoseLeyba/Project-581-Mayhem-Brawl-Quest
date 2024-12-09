'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 10/31/2024
Purpose: Start Menu Script
'''
extends Node

#function triggered when the Single Player Mode button is pressed.
func _on_single_player_pressed() -> void:
	#Changes the scene to the SinglePlayer scene
	get_tree().change_scene_to_file("res://Scenes/Menu/SinglePlayer.tscn")

#function triggered when the Multiplayer Mode button is pressed.
func _on_multiplayer_pressed() -> void:
	#Changes the scene to the MultiPlayer scene
	get_tree().change_scene_to_file("res://Scenes/Menu/MultiPlayer.tscn")
	
#function triggered when the Tutorial button is pressed.
func _on_tutorial_pressed() -> void:
	#Changes the scene to the TutorialMenu scene
	get_tree().change_scene_to_file("res://Scenes/Menu/TutorialMenu.tscn")

#function triggered when the Exit button is pressed.
func _on_exit_pressed() -> void:
	#Quits the program
	get_tree().quit()

#function triggered when the Settings button is pressed.
func _on_settings_pressed() -> void:
	#Changes the scene to the SettingsMenu scene
	get_tree().change_scene_to_file("res://Scenes/Menu/SettingsMenu.tscn")
