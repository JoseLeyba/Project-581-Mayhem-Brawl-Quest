'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 12/7/2024
Purpose: Game Manager Script
'''
extends Node
#Boss Camera
@onready var final_boss_camera: Camera2D = %FinalBossCamera
#Timers for powerups

@onready var invincibility_timer: Timer = %InvincibilityTimer
@onready var jump_speed_timer: Timer = %JumpSpeedTimer
@onready var low_gravity_timer: Timer = %LowGravityTimer
@onready var triple_jump_timer: Timer = %TripleJumpTimer
@onready var speed_timer: Timer = %SpeedTimer
#Damage sound
@onready var jose_ouch: AudioStreamPlayer2D = $JoseHurt
@onready var allie_ouch: AudioStreamPlayer2D = $AllieHurt
@onready var eli_ouch: AudioStreamPlayer2D = $EliHurt
@onready var riley_ouch: AudioStreamPlayer2D = $RileyHurt
@onready var sophie_ouch: AudioStreamPlayer2D = $SophieHurt
@onready var pickup_sound: AudioStreamPlayer2D = $Pickup
#Checks for single player vs 2 players
var is_multi_player = false
var maxHealth = 150
#Player1 Sprite
@onready var player_1: CharacterBody2D = %Player1
#Player2 Sprite
@onready var player_2: CharacterBody2D = %Player2

#PLAYER1
#Player 1 related variables, the enemy kills plus the Life bar
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var kills: Label = %Kills
#Player1 Power Up Images
@onready var power_up_image_1: TextureRect = %PowerUpImage1
@onready var power_up_image_2: TextureRect = %PowerUpImage2
@onready var power_up_image_3: TextureRect = %PowerUpImage3
var num_textures = 0
#Player 1 Variables
var player_1_health = maxHealth
var player_1_damage_taken = 0
var player_1_kills = 0
var player_1_armor = false
var player_1_armor_durability = 0
var player_1_invincinbility = false
var player_1_invincinbility_time = 0
var player_1_jump = false
var player_1_jump_time = 0
var player_1_gravity = false
var player_1_gravity_time = 0
var player_1_triple = false
var player_1_triple_time  = 0
var player_1_speed = false
var player_1_speed_time = 0



#PLAYER2
#Player 2 related variables, the enemy kills plus the Life bar adn the powerups
@onready var player_2_progress_bar: ProgressBar = %Player2_ProgressBar
@onready var player_2_kills: Label = %Player2_Kills
@onready var player_2_power_ups: Label = %Player2_PowerUps
var num_textures_p2 = 0
#Player2 Power Up Images
@onready var power_up_image_1p_2: TextureRect = %PowerUpImage1P2
@onready var power_up_image_2p_2: TextureRect = %PowerUpImage2P2
@onready var power_up_image_3p_2: TextureRect = %PowerUpImage3P2
#Player2 Variables
var player_2_health = maxHealth
var player_2_damage_taken = 0
var player_2_kill = 0
var player_2_armor = false
var player_2_armor_durability = 0
var player_2_invincinbility = false
var player_2_invincinbility_time = 0
var player_2_jump = false
var player_2_jump_time = 0
var player_2_gravity = false
var player_2_gravity_time = 0
var player_2_triple = false
var player_2_triple_time  = 0
var player_2_speed = false
var player_2_speed_time = 0
var player_character = null


#Power Up Images
var armor_texture: Texture = preload("res://assets/Powerups/Armor_Still.png")
var first_aid_texture: Texture = preload("res://assets/Powerups/FirstAid_Still.png")
var strength_potion_texture: Texture = preload("res://assets/Powerups/Strength_Potion_Still.png")
var medium_potion_texture: Texture = preload("res://assets/Powerups/Medium_Potion_Still.png")
var large_potion_texture: Texture = preload("res://assets/Powerups/Large_Potion_Still.png")
var invincibility_potion_texture: Texture = preload("res://assets/Powerups/Invincinbility_Potion_Still.png")
var cherry_texture: Texture = preload("res://assets/Powerups/Cherries.png")
var triple_jump_texture: Texture =preload("res://assets/Powerups/jump_boost_still.png")
var jump_speed_texture: Texture =preload("res://assets/Powerups/triple_jump_still.png")
var speed_texture: Texture =preload("res://assets/Powerups/speed_still.png")
var low_gravity_texture: Texture =preload("res://assets/Powerups/Low_Gravity_Potion_Still.png")

@onready var player1_camera: Camera2D = $"../SceneObjects/PlayerGroup/Player1/Camera1"
@onready var player2_camera: Camera2D = $"../SceneObjects/PlayerGroup/Player2/Camera2"

#On the start get the current scene, and set 1 or 2 healthbar depending on single or multiplayer
func _ready() -> void:
	if player_1 != null:
		print("player_1 initialized successfully: ", player_1.player)
	else:
		print("Error: player_1 is null!")
	#Gets the current scene to figure if it's multiplayer or not
	var currentScene = get_tree().current_scene
	#Checks if the current scene's name is Multi
	if currentScene.name == "Multi":
		#Sets is_multi_player to true
		is_multi_player = true
	else:
		is_multi_player = false
	GlobalData.save_player_mode(is_multi_player)
	#If it is multiplayer mode than it'll set the both player's health bars in the player UI's
	if is_multi_player:
		set_health_bar(1)
		set_health_bar(2)
	#Otherwise it will just set player 1's health bar in the player UI
	else:
		set_health_bar(1)
		
	if player1_camera and player1_camera is Camera2D:
		player1_camera.make_current()
		print("Player 1 camera is now active.")
	else:
		print("player1_camera is null or not a Camera2D!")
	'''if $character_1 and $character_2:
		$character_1.connect("died", Callable(self, "_on_player_died"))
		$character_2.connect("died", Callable(self, "_on_player2_died"))
	else:
		print("One or both character nodes are null!")'''
func _process(delta: float) -> void:
	update_kill()
func winning_screen() -> void:
	GlobalData.save_player1_data(player_1_health, player_1_kills, player_1_damage_taken)
	GlobalData.save_player2_data(player_2_health, player_2_kill, player_2_damage_taken)
	GlobalData.save_player_mode(is_multi_player)
	
	if is_multi_player:
		var current_level = GlobalData.get_level_2P()
		#var next_level = current_level + 1
		#GlobalData.save_level_2P(next_level)
	else:
		var current_level = GlobalData.get_level_1P()
		#var next_level = current_level + 1
		#GlobalData.save_level_1P(next_level)
	get_tree().change_scene_to_file("res://Scenes/Menu/WinningScreen.tscn")
func losing_screen() -> void:
	GlobalData.save_player1_data(player_1_health, player_1_kills, player_1_damage_taken)
	GlobalData.save_player2_data(player_2_health, player_2_kill, player_2_damage_taken)
	GlobalData.save_player_mode(is_multi_player)
	
	if is_multi_player:
		var current_level = GlobalData.get_level_2P()
		GlobalData.save_level_2P(current_level)
	else:
		var current_level = GlobalData.get_level_1P()
		GlobalData.save_level_1P(current_level)
	get_tree().change_scene_to_file("res://Scenes/Menu/LosingScreen.tscn")
	


#Sets the starting health for the players (100 life for each)
func set_health_bar(player_id: int) -> void:
	if player_id == 1:
		progress_bar.max_value = 100
		progress_bar.value = maxHealth
	else:
		player_2_progress_bar.max_value = 100
		player_2_progress_bar.value = maxHealth
		
#updates the health of the player given, if reaches 0 then restart the level
func update_health_bar(player_id: int) -> void:
	#Plays sound effect of currently hurt player
	if player_id == 1:
		player_character = GlobalData.get_player1_character()
	elif player_id == 2:
		player_character = GlobalData.get_player2_character()

	# Play corresponding sound
	match player_character:
		"jose":
			jose_ouch.play()
		"allie":
			allie_ouch.play()
		"eli":
			eli_ouch.play()
		"riley":
			riley_ouch.play()
		_:
			sophie_ouch.play()

	if player_id == 1:
		progress_bar.value = player_1_health
		if player_1_health == 0:
			if is_multi_player:
				if player_2_health == 0:
					losing_screen()
					$"../SceneObjects/PlayerGroup/Player1".queue_free()
				else:
					#player_1.queue_free()
					#change_camera_player()
					$"../SceneObjects/PlayerGroup/Player1".queue_free()
					
			else:
				losing_screen()
	else:
		player_2_progress_bar.value = player_2_health
		if player_2_health == 0:
			#player_2.queue_free()
			$"../SceneObjects/PlayerGroup/Player2".queue_free()
			if is_multi_player:
				if player_1_health == 0:
					losing_screen()
					$"../SceneObjects/PlayerGroup/Player2".queue_free()
			else:
				losing_screen()
				$"../SceneObjects/PlayerGroup/Player2".queue_free()
		
func change_camera_player() -> void:
	pass
#Adds health, does this when they grab a related powerup, with a limit of 100 (can't overheal)
func add_health(player_id: int, heal: int, ):
	if player_id == 1: 
		if (player_1_health + heal) > maxHealth:
			player_1_health = maxHealth
		else:
			player_1_health += heal
			update_health_bar(1)
	else:
		if (player_2_health + heal) > maxHealth:
			player_2_health = maxHealth
		else:
			player_2_health += heal
			update_health_bar(2)

#Here we reduce the health for the players
func decrease_health(player_id: int, damage: int, criticalHit: bool, criticalHitImpact: int) -> void:
	if player_id == 1:
		player_character = GlobalData.get_player1_character()
	elif player_id == 2:
		player_character = GlobalData.get_player2_character()

	# Play corresponding sound
	match player_character:
		"jose":
			jose_ouch.play()
		"allie":
			allie_ouch.play()
		"eli":
			eli_ouch.play()
		"riley":
			riley_ouch.play()
		_:
			sophie_ouch.play()
	var remaining_damage = 0
	#For player 1
	if player_id == 1:
		#If he has the invicibility powerup he doesn't take any
		if player_1_invincinbility:
			return
		#If he has armor then reduce armor by the damage before reducing his life
		if player_1_armor:
			player_1_armor_durability -= damage
			#If the attack was a crit then take the extra armor damage
			if criticalHit:
				player_1_armor_durability -= criticalHitImpact
			#If the armor isn't enough take the rest of damage to your health and stop having armor
			if player_1_armor_durability < 0:
				remaining_damage = -(player_1_armor_durability)
				player_1_armor_durability = 0
				player_1_armor = false
				remove_powerup(1, armor_texture)
				player_1_health -= remaining_damage
				if player_1_health < 0:
					player_1_health = 0
		#Else do the same for regular health
		else:
			player_1_health -= damage
			player_1_damage_taken += damage
			if criticalHit:
				player_1_health -= criticalHitImpact
				player_1_damage_taken += criticalHitImpact
			if player_1_health < 0:
				player_1_health = 0
		update_health_bar(1)
	#Repeats the same for P2
	else:
		if player_2_invincinbility:
			return
		if player_2_armor:
			player_2_armor_durability -= damage
			if criticalHit:
				player_2_armor_durability -= criticalHitImpact
			if player_2_armor_durability < 0:
				remaining_damage = -(player_2_armor_durability)
				player_2_armor_durability = 0
				player_2_armor = false
				remove_powerup(2, armor_texture)
				player_2_health -= remaining_damage
				if player_2_health < 0:
					player_2_health = 0
		else:
			player_2_health -= damage
			player_2_damage_taken += damage
			if criticalHit:
				player_1_health -= criticalHitImpact
				player_2_damage_taken += criticalHitImpact
			if player_2_health < 0:
				player_2_health = 0
		update_health_bar(2)
#When killing an enemy add a kill to the counter
func update_kill():
	if is_multi_player:
		player_1_kills = GlobalData.get_player1_kills()
		kills.text = "Kills: " +  str(player_1_kills)
		player_2_kill = GlobalData.get_player2_kills()
		player_2_kills.text = "Kills: " +  str(player_2_kill)
	else:
		player_1_kills = GlobalData.get_player1_kills()
		kills.text = "Kills: " +  str(player_1_kills)
#Power-Ups 
#This function takes care of the invincinbility potion power up
func add_invincinbility(player_id: int, invincibility_duration: int):
	pickup_sound.play()
	#Checks if the player is player 1
	if player_id == 1:
		#Sets the player having invincinbility to true
		player_1_invincinbility = true
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_1_invincinbility_time = Time.get_ticks_msec()
		#Sets the time duration to the invincibility_duration
		invincibility_timer.wait_time = invincibility_duration
		#Starts the timer
		invincibility_timer.start()
	#Checks if the player is player 2
	if player_id == 2:
		#Sets the player having invincinbility to true
		player_2_invincinbility = true
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_2_invincinbility_time = Time.get_ticks_msec()
		#Sets the time duration to the invincibility_duration
		invincibility_timer.wait_time = invincibility_duration
		#Starts the timer
		invincibility_timer.start()
func add_jumpSpeed(player_id: int, duration: int):
	pickup_sound.play()
	#Checks if the player is player 1
	if player_id == 1:
		#Sets the player having the powerup to true
		player_1_jump = true
		GlobalData.save_player1_jump_speed(player_1_jump)
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_1_jump_time = Time.get_ticks_msec()
		#Sets the time duration to the duration
		jump_speed_timer.wait_time = duration
		
		#Starts the timer
		jump_speed_timer.start()
	#Checks if the player is player 2
	if player_id == 2:
		#Sets the player having the powerup to true
		player_2_jump = true
		GlobalData.save_player2_jump_speed(player_2_jump)
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_2_jump_time = Time.get_ticks_msec()
		#Sets the time duration to the duration
		jump_speed_timer.wait_time = duration
		#Starts the timer
		jump_speed_timer.start()
func add_tripleJump(player_id: int, duration: int):
	pickup_sound.play()
	#Checks if the player is player 1
	if player_id == 1:
		#Sets the player having the powerup to true
		player_1_triple = true
		GlobalData.save_player1_triple_jump(player_1_triple)
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_1_triple_time = Time.get_ticks_msec()
		#Sets the time duration to the duration
		triple_jump_timer.wait_time = duration
		#Starts the timer
		triple_jump_timer.start()
	#Checks if the player is player 2
	if player_id == 2:
		#Sets the player having powerup to true
		player_2_triple = true
		GlobalData.save_player2_triple_jump(player_2_triple)
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_2_triple_time = Time.get_ticks_msec()
		#Sets the time duration to the duration
		triple_jump_timer.wait_time = duration
		#Starts the timer
		triple_jump_timer.start()
func add_lowGravity(player_id: int, duration: int):
	pickup_sound.play()
	#Checks if the player is player 1
	if player_id == 1:
		#Sets the player having the powerup to true 
		player_1_gravity = true
		GlobalData.save_player1_gravity(player_1_gravity)
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_1_gravity_time = Time.get_ticks_msec()
		#Sets the time duration to the duration
		low_gravity_timer.wait_time = duration
		#Starts the timer
		low_gravity_timer.start()
	#Checks if the player is player 2
	if player_id == 2:
		#Sets the player having powerup to true
		player_2_gravity = true
		GlobalData.save_player2_gravity(player_2_gravity)
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_2_gravity_time = Time.get_ticks_msec()
		#Sets the time duration to the duration
		low_gravity_timer.wait_time = duration
		#Starts the timer
		low_gravity_timer.start()
func add_speed(player_id: int, duration: int):
	pickup_sound.play()
	#Checks if the player is player 1
	if player_id == 1:
		#Sets the player having the powerup to true 
		player_1_speed = true
		GlobalData.save_player1_running_speed(player_1_speed)
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_1_speed_time = Time.get_ticks_msec()
		#Sets the time duration to the duration
		speed_timer.wait_time = duration
		#Starts the timer
		speed_timer.start()
	#Checks if the player is player 2
	if player_id == 2:
		#Sets the player having powerup to true
		player_2_speed = true
		GlobalData.save_player2_running_speed(player_2_speed)
		#Gets the start time of this power up since it only occurs doing a certain duration
		player_2_speed_time = Time.get_ticks_msec()
		#Sets the time duration to the duration
		speed_timer.wait_time = duration
		#Starts the timer
		speed_timer.start()
func add_armor(player_id: int, armor_durability) -> void:
	pickup_sound.play()
	#Checks if the player is player 1
	if player_id == 1:
		#Checks to see if the player doesn't have armor already because it can't have more than 1 at a time
		if not player_1_armor: 
			#Adds the armor to the powerup UI
			add_powerup(1, "Armor")
			#Sets player 1 having armor to true
			player_1_armor = true
			#Sets the durability of player1's armor to armor_durability
			player_1_armor_durability = armor_durability
	#Checks if the player is player 2
	if player_id == 2:
		#Checks to see if the player doesn't have armor already because it can't have more than 1 at a time
		if not player_2_armor:
			#Adds the armor to the powerup UI
			add_powerup(1, "Armor")
			#Sets player 2 having armor to true
			player_2_armor = true
			#Sets the durability of player1's armor to armor_durability
			player_2_armor_durability = armor_durability

#This function will add the powerup to the Player UI
func add_powerup(player_id: int, powerup):
	pickup_sound.play()
	#Declares a variable to hold the texture that matches the given powerup
	var texture: Texture
	#Matches the powerup string name to it's texture
	match powerup:
		"Armor":
			texture = armor_texture
		"First Aid Kit":
			texture = first_aid_texture
		"Medium Health Potion":
			texture = medium_potion_texture
		"Large Health Potion":
			texture = large_potion_texture
		"Strength Potion":
			texture = strength_potion_texture
		"Invincinbility Potion":
			texture = invincibility_potion_texture
		"Cherry":
			texture = cherry_texture
		"Low Gravity":
			texture = low_gravity_texture
		"Triple Jump":
			texture = triple_jump_texture
		"Increased Jump Speed":
			texture = jump_speed_texture
		"Increased Running Speed":
			texture = speed_texture
	#Checks if the player is player 2
	if player_id == 1:
		#Removes any instant powerups from the powerup UI
		remove_powerup(1, first_aid_texture)
		remove_powerup(1, medium_potion_texture)
		remove_powerup(1, large_potion_texture)
		remove_powerup(1, cherry_texture)

		#Checks the number of textures already displayer and adds the new power-up texture to the appropriate slot
		if num_textures == 0:
			power_up_image_1.texture = texture
			num_textures += 1
		elif num_textures == 1:
			power_up_image_2.texture = texture
			num_textures += 1
		elif num_textures == 2:
			power_up_image_3.texture = texture
			num_textures += 1
		#If all three slots are filled, it clears the last two and resets the first slot with the new power up
		else:
			power_up_image_2.texture = null
			power_up_image_3.texture = null
			power_up_image_1.texture = texture
			num_textures = 1
	else:
		#Removes any instant powerups from the powerup UI
		remove_powerup(1, first_aid_texture)
		remove_powerup(1, medium_potion_texture)
		remove_powerup(1, large_potion_texture)
		remove_powerup(1, cherry_texture)
		#Checks the number of textures already displayer and adds the new power-up texture to the appropriate slot
		if num_textures_p2 == 0:
			power_up_image_1p_2.texture = texture
			num_textures_p2 += 1
		elif num_textures_p2 == 1:
			power_up_image_2p_2.texture = texture
			num_textures_p2 += 1
		elif num_textures_p2 == 2:
			power_up_image_3p_2.texture = texture
			num_textures_p2 += 1
		#If all three slots are filled, it clears the last two and resets the first slot with the new power up
		else:
			power_up_image_2p_2.texture = null
			power_up_image_3p_2.texture = null
			power_up_image_1p_2.texture = texture
			num_textures_p2 = 1
#This function removes the power up from the player UI display
func remove_powerup(player_id: int, texture: Texture):
	#Checks if the player is player 1
	if player_id == 1:
		#If the first slot contains the texture to be removed, shift the textures left
		if power_up_image_1.texture == texture:
			power_up_image_1.texture = power_up_image_2.texture
			power_up_image_2.texture = power_up_image_3.texture
			power_up_image_3.texture = null
			num_textures -= 1
		#If the second slot contains the texture, shift the last texture left
		elif power_up_image_2.texture == texture:
			power_up_image_2.texture = power_up_image_3.texture
			power_up_image_3.texture = null
			num_textures -= 1
		#If the third slot contains the texture, just clear that slot
		elif power_up_image_3.texture == texture:
			power_up_image_3.texture = null
			num_textures -= 1
		#Makes sure the number of textures doesn't go below zero
		num_textures = max(0, num_textures)
	#Checks if the player is player 2
	if player_id == 2:
		#If the first slot contains the texture to be removed, shift the textures left
		if power_up_image_1p_2.texture == texture:
			power_up_image_1p_2.texture = power_up_image_2p_2.texture
			power_up_image_2p_2.texture = power_up_image_3p_2.texture
			power_up_image_3p_2.texture = null
			num_textures_p2  -= 1
		#If the third slot contains the texture, just clear that slot
		elif power_up_image_2p_2.texture == texture:
			power_up_image_2p_2.texture = power_up_image_3p_2.texture
			power_up_image_3p_2.texture = null
			num_textures_p2  -= 1
		#If the third slot contains the texture, just clear that slot
		elif power_up_image_3p_2.texture == texture:
			power_up_image_3p_2.texture = null
			num_textures_p2  -= 1
		#Makes sure the number of textures doesn't go below zero
		num_textures_p2 = max(0, num_textures_p2)
			




func _on_invincibility_timer_timeout() -> void:
	#Checks if both players have invincibility
	if player_1_invincinbility and player_2_invincinbility:
		#Determine which player gained invincibility first
		if player_1_invincinbility_time < player_2_invincinbility_time:
			#Remove invincibility from player 1 if they gained it earlier
			player_1_invincinbility = false
			remove_powerup(1, invincibility_potion_texture)
		else:
			#Otherwise, remove invincibility from player 2
			player_2_invincinbility = false
			remove_powerup(2, invincibility_potion_texture)
	#Checks if only player 1 has invincibility
	elif player_1_invincinbility:
		#Remove invincibility from player 1
		player_1_invincinbility = false
		remove_powerup(1, invincibility_potion_texture)
	#Checks if only player 2 has invincibility
	elif player_2_invincinbility:
		#Remove invincibility from player 2
		player_2_invincinbility = false
		remove_powerup(2, invincibility_potion_texture)


func _on_jump_speed_timer_timeout() -> void:
	#Checks if both players have jump speed
	if player_1_jump and player_2_jump:
		#Determine which player gained jump speed first
		if player_1_jump_time < player_2_jump_time:
			#Remove jump from player 1 if they gained it earlier
			player_1_jump = false
			GlobalData.save_player1_jump_speed(player_1_jump)
			remove_powerup(1, jump_speed_texture)
		else:
			#Otherwise, remove jump speed from player 2
			player_2_jump = false
			GlobalData.save_player2_jump_speed(player_2_jump)
			remove_powerup(2, jump_speed_texture)
	#Checks if only player 1 has jump speed
	elif player_1_jump:
		#Remove jump speed from player 1
		player_1_jump = false
		GlobalData.save_player1_jump_speed(player_1_jump)
		remove_powerup(1, jump_speed_texture)
	#Checks if only player 2 has jump speed
	elif player_2_jump:
		#Remove jump speed from player 2
		player_2_jump = false
		GlobalData.save_player2_jump_speed(player_2_jump)
		remove_powerup(2, jump_speed_texture)


func _on_low_gravity_timer_timeout() -> void:
	#Checks if both players have  low gravity
	if player_1_gravity and player_2_gravity:
		#Determine which player gained  low gravity first
		if player_1_gravity_time < player_2_gravity_time:
			#Remove  low gravity from player 1 if they gained it earlier
			player_1_gravity = false
			GlobalData.save_player1_gravity(player_1_gravity)
			remove_powerup(1, low_gravity_texture)
		else:
			#Otherwise, remove  low gravity from player 2
			player_2_gravity = false
			GlobalData.save_player2_gravity(player_2_gravity)
			remove_powerup(2, low_gravity_texture)
	#Checks if only player 1 has  low gravity
	elif player_1_gravity:
		#Remove  low gravity from player 1
		player_1_gravity = false
		GlobalData.save_player1_gravity(player_1_gravity)
		remove_powerup(1, low_gravity_texture)
	#Checks if only player 2 has  low gravity
	elif player_2_gravity:
		#Remove  low gravity from player 2
		player_2_gravity = false
		GlobalData.save_player2_gravity(player_2_gravity)
		remove_powerup(2, low_gravity_texture)


func _on_triple_jump_timer_timeout() -> void:
	#Checks if both players have  triple jump
	if player_1_triple and player_2_triple:
		#Determine which player gained  triple jump first
		if player_1_triple_time < player_2_triple_time:
			#Remove  triple jump from player 1 if they gained it earlier
			player_1_triple = false
			GlobalData.save_player1_triple_jump(player_1_triple)
			remove_powerup(1, triple_jump_texture)
		else:
			#Otherwise, remove  triple jump from player 2
			player_2_triple = false
			GlobalData.save_player2_triple_jump(player_2_triple)
			remove_powerup(2, triple_jump_texture)
	#Checks if only player 1 has  triple jump
	elif player_1_triple:
		#Remove  triple jump from player 1
		player_1_triple = false
		GlobalData.save_player1_triple_jump(player_1_triple)
		remove_powerup(1, triple_jump_texture)
	#Checks if only player 2 has  triple jump
	elif player_2_triple:
		#Remove  triple jump from player 2
		player_2_triple = false
		GlobalData.save_player2_triple_jump(player_2_triple)
		remove_powerup(2, triple_jump_texture)


func _on_speed_timer_timeout() -> void: 
	#Checks if both players have running speed
	if player_1_speed and player_2_speed:
		#Determine which player gained running speed first
		if player_1_speed_time < player_2_speed_time:
			#Remove running speed from player 1 if they gained it earlier
			player_1_speed = false
			GlobalData.save_player1_running_speed(player_1_speed)
			remove_powerup(1, speed_texture)
		else:
			#Otherwise, remove running speed from player 2
			player_2_speed = false
			GlobalData.save_player2_running_speed(player_2_speed)
			remove_powerup(2, speed_texture)
	#Checks if only player 1 has running speed
	elif player_1_speed:
		#Remove running speed from player 1
		player_1_speed = false
		GlobalData.save_player1_running_speed(player_1_speed)
		remove_powerup(1, speed_texture)
	#Checks if only player 2 has running speed
	elif player_2_speed:
		#Remove running speed from player 2
		player_2_speed = false
		GlobalData.save_player2_running_speed(player_2_speed)
		remove_powerup(2, speed_texture)


func _on_finish_detection_body_entered(body: Node2D) -> void:
	if final_boss_camera != null:
		if body.name == "Player1":
			var currentScene = get_tree().current_scene
			if currentScene.name == "Multi":
				final_boss_camera.make_current()
			else:
				final_boss_camera.make_current()
		if body.name == "Player2":
			var currentScene = get_tree().current_scene
			if currentScene.name == "Multi":
				final_boss_camera.make_current()
			else:
				final_boss_camera.make_current()
