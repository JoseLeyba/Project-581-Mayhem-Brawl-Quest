extends Node
#Single Player
@onready var health: Label = %Health
@onready var kills: Label = %Kills
@onready var damage: Label = %Damage
@onready var total_health: Label = %TotalHealth
@onready var total_kills: Label = %TotalKills
@onready var total_damage: Label = %TotalDamage

#Multiplayer
#Player1 Stats
@onready var health_player_1: Label = %HealthPlayer1
@onready var kills_player_1: Label = %KillsPlayer1
@onready var damage_player_1: Label = %DamagePlayer1
@onready var total_health_player_1: Label = %TotalHealthPlayer1
@onready var total_kills_player_1: Label = %TotalKillsPlayer1
@onready var total_damage_player_1: Label = %TotalDamagePlayer1

#Player2 Stats
@onready var health_player_2: Label = %HealthPlayer2
@onready var kills_player_2: Label = %KillsPlayer2
@onready var damage_player_2: Label = %DamagePlayer2
@onready var total_health_player_2: Label = %TotalHealthPlayer2
@onready var total_kills_player_2: Label = %TotalKillsPlayer2
@onready var total_damage_player_2: Label = %TotalDamagePlayer2

#Modes
@onready var single_player_mode: VBoxContainer = %SinglePlayerMode
@onready var multiplayer_mode: HBoxContainer = %MultiplayerMode

#Player 1 Stats
var player1_health = 0
var player1_kills = 0
var player1_damagetaken = 0
var player1_health_total = 0
var player1_kills_total = 0
var player1_damagetaken_total = 0

#Player 2 Stats
var player2_health = 0
var player2_kills = 0
var player2_damagetaken = 0
var player2_health_total = 0
var player2_kills_total = 0
var player2_damagetaken_total = 0
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
	var stats = GlobalData.get_player1_total_data()
	player1_health = stats[0]
	player1_kills = stats[1]
	player1_damagetaken = stats[2]
	player1_health_total = stats[3]
	player1_kills_total = stats[4]
	player1_damagetaken_total = stats[5]
func player2_stats():
	var stats = GlobalData.get_player2_total_data()
	player2_health = stats[0]
	player2_kills = stats[1]
	player2_damagetaken = stats[2]
	player2_health_total = stats[3]
	player2_kills_total = stats[4]
	player2_damagetaken_total = stats[5]
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
	health_player_1.text = "Level 5 Health Point: " + str(player1_health)
	kills_player_1.text = "Level 5 Kills: " + str(player1_kills)
	damage_player_1.text = "Level 5 Damage Taken: " + str(player1_damagetaken)
	total_health_player_1.text = "Total Health Point: " + str(player1_health_total)
	total_kills_player_1.text = "Total Kills: " + str(player1_kills_total)
	total_damage_player_1.text = "Total Damage Taken: " + str(player1_damagetaken_total)
	#Updates Player 2 states
	health_player_2.text = "Level 5 Health Point: " +  str(player2_health)
	kills_player_2.text = "Level 5 Kills: " + str(player2_kills)
	damage_player_2.text = "Level 5 Damage Taken: " + str(player2_damagetaken)
	total_health_player_2.text = "Total Health Point: " + str(player2_health_total)
	total_kills_player_2.text = "Total Kills: " + str(player2_kills_total)
	total_damage_player_2.text = "Total Damage Taken: " + str(player2_damagetaken_total)
#function is used to show the only the single player mode stats
func show_singleplayer() -> void:
	#Gets Player 1's Stats
	player1_stats()
	#Update Player 1 stats
	health.text = "Level 5 Health Point: " + str(player1_health)
	kills.text = "Level 5 Kills: " + str(player1_kills)
	damage.text = "Level 5 Damage Taken: " + str(player1_damagetaken)
	total_health.text = "Total Health Point: " + str(player1_health)
	total_kills.text = "Total Kills: " + str(player1_kills)
	total_damage.text = "Total Damage Taken: " + str(player1_damagetaken)
	#Hides the single player stats
	single_player_mode.show()
	#Shows the multiplayer stats
	multiplayer_mode.hide()
func _on_reply_pressed() -> void:
	GlobalData.reset_all_stats()
	if not is_multiplayer:
		var next_scene = GlobalData.get_level_1P()
		if next_scene == 0:
			get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level1.tscn")
	else:
		var next_scene = GlobalData.get_level_1P()
		if next_scene == 0:
			get_tree().change_scene_to_file("res://Scenes/Levels/1P/Level1.tscn")

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
