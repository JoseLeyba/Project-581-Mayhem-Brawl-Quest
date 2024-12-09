'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 10/31/2024
Purpose:Manual Script
'''
extends Node
#function triggered when a back button is pressed
func _on_back_pressed() -> void:
	#Changes the scene to the SettingsMenu scene
	get_tree().change_scene_to_file("res://Scenes/Menu/SettingsMenu.tscn")
