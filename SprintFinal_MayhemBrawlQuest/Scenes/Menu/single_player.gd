'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 11/06/2024
Purpose: Single Player Mode Script
'''
extends Node
@onready var character: TextureRect = %Character

var allie: Texture = preload("res://assets/Characters/allie_still.png")
var eli: Texture = preload("res://assets/Characters/eli_still.png")
var jose: Texture = preload("res://assets/Characters/jose_still.png")
var riley: Texture = preload("res://assets/Characters/riley_still.png")
var sophia: Texture = preload("res://assets/Characters/sophia_still.png")
var position = 0
func _ready() -> void:
	character.texture = jose
	GlobalData.save_player1_character("jose")
#function triggered when the back button is pressed
func _on_back_pressed() -> void:
	#Changes the scene to the StartMenu scene
	get_tree().change_scene_to_file("res://Scenes/Menu/startMenu.tscn")
#function triggered when the back button is pressed
func _on_start_pressed() -> void:
	var scene = GlobalData.get_level_1P()
	if scene == 0:
		get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level1.tscn")
	elif scene == 1:
		get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level2.tscn")
	elif scene == 2:
		get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level3.tscn")
	elif scene == 3:
		get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level4.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level5.tscn")


func _on_previous_pressed() -> void:
	position -= 1
	if position < 0:
		position = 4
	if position == 0:
		character.texture = jose
		GlobalData.save_player1_character("jose")
	elif position == 1:
		character.texture = eli
		GlobalData.save_player1_character("eli")
	elif position == 2:
		character.texture = riley
		GlobalData.save_player1_character("riley")
	elif position == 3:
		character.texture = allie
		GlobalData.save_player1_character("allie")
	elif position == 4:
		character.texture = sophia
		GlobalData.save_player1_character("sophia")

func _on_next_pressed() -> void:
	position += 1
	if position > 4:
		position = 0
	if position == 0:
		character.texture = jose
		GlobalData.save_player1_character("jose")
	elif position == 1:
		character.texture = eli
		GlobalData.save_player1_character("eli")
	elif position == 2:
		character.texture = riley
		GlobalData.save_player1_character("riley")
	elif position == 3:
		character.texture = allie
		GlobalData.save_player1_character("allie")
	elif position == 4:
		character.texture = sophia
		GlobalData.save_player1_character("sophia")
