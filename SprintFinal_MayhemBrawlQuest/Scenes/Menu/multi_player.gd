'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 11/06/2024
Purpose: Multi Player Mode Script
'''
extends Node
var allie: Texture = preload("res://assets/Characters/allie_still.png")
var eli: Texture = preload("res://assets/Characters/eli_still.png")
var jose: Texture = preload("res://assets/Characters/jose_still.png")
var riley: Texture = preload("res://assets/Characters/riley_still.png")
var sophia: Texture = preload("res://assets/Characters/sophia_still.png")

var position = 0
var position2 = 0
@onready var character_1: TextureRect = %Character1
@onready var character_2: TextureRect = %Character2

var player1_character = "jose"
var player2_character = "jose"
var is_player_selected = false
func _ready() -> void:
	character_1.texture = jose
	character_2.texture = jose
	GlobalData.save_player1_character("jose")
	GlobalData.save_player2_character("jose")
#function triggered when the back button is pressed.
func _on_back_pressed() -> void:
	#Changes the scene to the StartMenu scene
	get_tree().change_scene_to_file("res://Scenes/Menu/startMenu.tscn") 
#function triggered when the start button is pressed.
func _on_start_pressed() -> void:
	#Changes the scene to the Level for 2 players scene
	var scene = GlobalData.get_level_2P()
	if scene == 0:
		get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level1.tscn")
	elif scene == 1:
		get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level2.tscn")
	elif scene == 2:
		get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level3.tscn")
	elif scene == 3:
		get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level4.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level5.tscn")


func _on_previous_pressed() -> void:
	position -= 1
	if position < 0:
		position = 4
	if position == 0:
		character_1.texture = jose
		GlobalData.save_player1_character("jose")
	elif position == 1:
		character_1.texture = eli
		GlobalData.save_player1_character("eli")
	elif position == 2:
		character_1.texture = riley
		GlobalData.save_player1_character("riley")
	elif position == 3:
		character_1.texture = allie
		GlobalData.save_player1_character("allie")
	elif position == 4:
		character_1.texture = sophia
		GlobalData.save_player1_character("sophia")



func _on_next_pressed() -> void:
	position += 1
	if position > 4:
		position = 0
	if position == 0:
		character_1.texture = jose
		GlobalData.save_player1_character("jose")
	elif position == 1:
		character_1.texture = eli
		GlobalData.save_player1_character("eli")
	elif position == 2:
		character_1.texture = riley
		GlobalData.save_player1_character("riley")
	elif position == 3:
		character_1.texture = allie
		GlobalData.save_player1_character("allie")
	elif position == 4:
		character_1.texture = sophia
		GlobalData.save_player1_character("sophia")

		

func _on_previous_2_pressed() -> void:
	position2 -= 1
	if position2 < 0:
		position2 = 4
	if position2 == 0:
		character_2.texture = jose
		GlobalData.save_player2_character("jose")
	elif position2 == 1:
		character_2.texture = eli
		GlobalData.save_player2_character("eli")
	elif position2 == 2:
		character_2.texture = riley
		GlobalData.save_player2_character("riley")
	elif position2 == 3:
		character_2.texture = allie
		GlobalData.save_player2_character("allie")
	elif position2 == 4:
		character_2.texture = sophia
		GlobalData.save_player2_character("sophia")



func _on_next_2_pressed() -> void:
	position2 += 1
	if position2 > 4:
		position = 0
	if position2 == 0:
		character_2.texture = jose
		GlobalData.save_player2_character("jose")
	elif position2 == 1:
		character_2.texture = eli
		GlobalData.save_player2_character("eli")
	elif position2 == 2:
		character_2.texture = riley
		GlobalData.save_player2_character("riley")
	elif position2 == 3:
		character_2.texture = allie
		GlobalData.save_player2_character("allie")
	elif position2 == 4:
		character_2.texture = sophia
		GlobalData.save_player2_character("sophia")
