
extends Node

#Single Player
@onready var single_player_mode: VBoxContainer = %SinglePlayerMode
#Player
@onready var health: Label = %Health
@onready var kills: Label = %Kills
@onready var damage: Label = %Damage
#MultiPlayer
@onready var multiplayer_mode: HBoxContainer = %MultiplayerMode
#Player 1
@onready var health_player_1: Label = %HealthPlayer1
@onready var kills_player_1: Label = %KillsPlayer1
@onready var damage_player_1: Label = %DamagePlayer1
#Player2
@onready var health_player_2: Label = %HealthPlayer2
@onready var kills_player_2: Label = %KillsPlayer2
@onready var damage_player_2: Label = %DamagePlayer2


#Player 1 Stats
var player1_health = 0
var player1_kills = 0
var player1_damagetaken = 0
#Player 2 Stats
var player2_health = 0
var player2_kills = 0
var player2_damagetaken = 0

#Tells if the mode is single player or multiplayer
var is_multiplayer = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_multiplayer = GlobalData.get_player_mode()
	if is_multiplayer:
		show_multiplayer()
	else:
		show_singleplayer()

func player1_stats():
	var stats = GlobalData.get_player1_data()
	player1_health = stats[0]
	player1_kills = stats[1]
	player1_damagetaken = stats[2]
func player2_stats():
	var stats = GlobalData.get_player2_data()
	player2_health = stats[0]
	player2_kills = stats[1]
	player2_damagetaken = stats[2]
#function is used to show only the multiplayer mode stats
func show_multiplayer() -> void:
	#Gets Player 1's Stats
	player1_stats()
	player2_stats()
	#Gets Player 2's Stats
	#Hides the single player stats
	single_player_mode.hide()
	#Shows the multiplayer stats
	multiplayer_mode.show()
	#Updates Player 1 stats
	health_player_1.text = "Health Point: " + str(player1_health)
	kills_player_1.text = "Kills: " + str(player1_kills)
	damage_player_1.text = "Damage Taken: " + str(player1_damagetaken)
	#Updates Player 2 states
	health_player_2.text = "Health Point: " +  str(player2_health)
	kills_player_2.text = "Kills: " + str(player2_kills)
	damage_player_2.text = "Damage Taken: " + str(player2_damagetaken)
#function is used to show the only the single player mode stats
func show_singleplayer() -> void:
	#Gets Player 1's Stats
	player1_stats()
	#Update Player 1 stats
	health.text = "Health Point: " + str(player1_health)
	kills.text = "Kills: " + str(player1_kills)
	damage.text = "Damage Taken: " + str(player1_damagetaken)
	#Hides the single player stats
	single_player_mode.show()
	#Shows the multiplayer stats
	multiplayer_mode.hide()
#function trigged when Next Level button is pressed
func _on_next_level_pressed() -> void:
	GlobalData.reset_level_stats()
	if not is_multiplayer:
		var current_scene = GlobalData.get_level_1P()
		GlobalData.save_nextlevel_1P()
		var next_scene = GlobalData.get_level_1P()
		if next_scene == 0:
			get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level1.tscn")
		elif next_scene == 1:
			get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level2.tscn")
		elif next_scene == 2:
			get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level3.tscn")
		elif next_scene == 3:
			get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level4.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level5.tscn")
	else:
		var current_scene = GlobalData.get_level_2P()
		GlobalData.save_nextlevel_2P()
		var next_scene = GlobalData.get_level_2P()
		if next_scene == 0:
			get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level1.tscn")
		elif next_scene == 1:
			get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level2.tscn")
		elif next_scene == 2:
			get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level3.tscn")
		elif next_scene == 3:
			get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level4.tscn")
		elif next_scene == 4:
			get_tree().change_scene_to_file("res://Scenes/Levels/2P/Level5.tscn")

#function triggered when the Exit to Main Menu button is pressed
func _on_main_menu_pressed() -> void:
	GlobalData.reset_all_stats()
	#Changes the scene to the StartMenu scene
	get_tree().change_scene_to_file("res://Scenes/Menu/startMenu.tscn")

#function triggered when the Exit button is pressed.
func _on_exit_pressed() -> void:
	GlobalData.reset_all_stats()
	#Quits the program
	get_tree().quit()
