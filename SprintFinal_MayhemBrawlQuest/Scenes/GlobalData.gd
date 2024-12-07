'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 11/22/2024
Last modified: 11/22/2024
Purpose: Global Variables 
'''
extends Node

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

var current_1P_level = 0
var current_2P_level = 0
var player1_character = "jose"
var player2_character = "jose"
#Player 1 Powerups
var player1_speed = false
var player1_jump = false
var player1_triple = false
var player1_gravity = false
#Player 2 Powerups
var player2_speed = false
var player2_jump = false
var player2_triple = false
var player2_gravity = false
var player1_weapon = "gun"
var player2_weapon = "sword"

func save_player1_character(character) -> void:
	player1_character = character
func save_player2_character(character) -> void:
	player2_character = character
func save_player1_weapon(weapon) -> void:
	player1_weapon = weapon
func save_player2_weapoon(weapon) -> void:
	player2_weapon = weapon
func add_player1_kill() -> void:
	player1_kills += 1
func add_player2_kill() -> void:
	player2_kills += 1
func save_player1_jump_speed(is_jump) -> void:
	player1_jump = is_jump
func save_player1_triple_jump(is_jump) -> void:
	player1_triple = is_jump
func save_player1_running_speed(is_speed) -> void:
	player1_speed = is_speed
func save_player1_gravity(is_gravity) -> void:
	player1_gravity = is_gravity
func save_player2_jump_speed(is_jump) -> void:
	player2_jump = is_jump
func save_player2_triple_jump(is_jump) -> void:
	player2_triple = is_jump
func save_player2_running_speed(is_speed) -> void:
	player2_speed = is_speed
func save_player2_gravity(is_gravity) -> void:
	player2_gravity = is_gravity
func save_player1_data(health, kills, damage_taken) -> void:
	player1_health = health
	player1_kills = kills
	player1_damagetaken = damage_taken
func save_player2_data(health, kills, damage_taken) -> void:
	player2_health = health
	player2_kills = kills
	player2_damagetaken = damage_taken
func save_player_mode(mode) -> void:
	is_multiplayer = mode

func save_level_1P(level) -> void:
	if level > 4:
		level = 0
	current_1P_level = level
func save_level_2P(level) -> void:
	if level > 4:
		level = 0
	current_2P_level = level
func get_player1_character():
	return player1_character
func get_player2_character():
	return player2_character
func get_player1_data():
	return [player1_health, player1_kills, player1_damagetaken]
func get_player2_data():
	return [player2_health, player2_kills, player2_damagetaken]
func get_player_mode():
	return is_multiplayer
func get_level_1P():
	return current_1P_level
func get_level_2P():
	return current_2P_level
func get_player1_jump_speed():
	return player1_jump
func get_player1_triple_jump():
	return player1_triple
func get_player1_speed():
	return player1_speed
func get_player1_gravity():
	return player1_gravity
func get_player2_jump_speed():
	return player2_jump
func get_player2_triple_jump():
	return player2_triple
func get_player2_speed():
	return player2_speed
func get_player2_gravity():
	return player2_gravity
func get_player1_kills():
	return player1_kills
func get_player2_kills():
	return player2_kills
func get_player1_weapon():
	return player1_weapon
func get_player2_weapon():
	return player2_weapon
	
