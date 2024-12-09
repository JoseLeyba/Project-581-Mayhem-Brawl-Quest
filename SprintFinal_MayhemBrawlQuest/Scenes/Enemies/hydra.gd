'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 11/24/2024
Last modified: 11/24/2024
Purpose: Turtle Enemy Script
'''
extends CharacterBody2D

#The gravity for falling physics
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#The speed of the enemy
var SPEED = 200
var dir = 1
var is_enemy_chase: bool

var agression = 0
#func _ready() -> void:
	#is_enemy_chase = false
@onready var ray_cast_right = $right
@onready var ray_cast_left = $left
#Reference to the game manager node
@onready var game_manager: Node = %GameManager
#Reference to the enemy health bar
@onready var enemy_bar: ProgressBar = %EnemyBar
#Dying sound
@onready var die_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D  
@onready var enemy_sprite = $AnimatedSprite2D


@export var fireball_scene = preload("res://Scenes/Enemies/fireball.tscn")
@onready var fireball_timer: Timer = $FireballTimer
@onready var fireball_timer2: Timer = $FireballTimer2
#Maximum health of the enemy
var maxHealth = 500
#The enemyHealth starts at the max health
var enemyHealth = maxHealth
#Sets if the hit given was a critical hit to false to begin with
var criticalHit = false
#The additional impact of the critical hit if it occurs
var criticalHitImpact = 0

#When running the code it will set the enemy health bar
func _ready() -> void:
	#Calls set_enemy_bar to initialize the enemy health bar
	set_enemy_bar()

#function is triggered when area of the pig's body is entered
func _on_area_2d_body_entered(body: Node2D) -> void:
	#Checks if the body entered is Player1
	if body.name == "Player1":
		#Calls is_criticalHit to determine if the hit was critical or not
		is_criticalHit()
		#Sets criticalHitImpact to 25 if it is a criticalHit and 0 if it isn't
		criticalHitImpact = 25 if criticalHit else 0
		#Decrease the health of the player using the decrease_health function in game_manageer
		game_manager.decrease_health(1, 10, criticalHit, criticalHitImpact)
		#Checks if the key pressed was Q which would represent a sword
		if Input.is_key_pressed(KEY_Q):
			#Decrease the health of the mushroom by 10
			take_damage(30,1)
		else:
			#Decrease the health of the mushroom by 10
			var damage = damage_amount()
			take_damage(damage,1)
	#Checks if the body entered is Player2
	elif body.name == "Player2":
		#Calls is_criticalHit to determine if the hit was critical or not
		is_criticalHit()
		#Sets criticalHitImpact to 25 if it is a criticalHit and 0 if it isn't
		criticalHitImpact = 25 if criticalHit else 0
		#Decrease the health of the player using the decrease_health function in game_manageer
		game_manager.decrease_health(2, 10, criticalHit, criticalHitImpact)
		#Decrease the health of the mushroom by 10
		var damage = damage_amount()
		take_damage(damage,2)
	#Checks if the body entered is a bullet
	elif body.is_in_group("bullet"): 
		#Calls the function take_damage to decrease the mushroom's health by 10
		take_damage(10,3) 
		#Removes that bullet from the scene
		body.queue_free()  
	elif body.is_in_group("fireball"):
		body.queue_free()

#This function will decrease the health of the mushroom
func take_damage(damage: int, playerID: int):
	die_sound.play()
	if enemyHealth <= 0:
		return
	#Decrease the enemyHealth by the damage
	enemyHealth -= damage
	#Checks if the enemy health is less than or eqaul to 0
	if enemyHealth <= 200:
		agression = 1
	if enemyHealth <= 0:
		#Kills the enemy by calling the die function
		die(playerID)
	#Updates the progress bar by calling update_enemy_bar
	update_enemy_bar()
#The function will initialize the enemy health bar
func set_enemy_bar() -> void:
	#Sets the max value to the max possible health
	enemy_bar.max_value = maxHealth
	#Sets the value of the progress bar the max possible health
	enemy_bar.value = maxHealth
#This function will update the enemy health bar
func update_enemy_bar() -> void:
	#Sets the value of the progress bar to enemyHealth
	enemy_bar.value = enemyHealth

#This function will kill the duck
func die(playerID):
	#Removes the duck from the scene
	#queue_free()  
	var player1_weapon = GlobalData.get_player1_weapon()
	var player2_weapon = GlobalData.get_player2_weapon()
	get_node("AnimatedSprite2D").play("Death")
	queue_free()
	if playerID == 1:
		GlobalData.add_player1_kill()
	elif playerID == 2:
		GlobalData.add_player2_kill()
	elif playerID == 0:
		#Check's which player used the sword
		if player1_weapon == "sword":
			GlobalData.add_player1_kill()
		if player2_weapon == "sword":
			GlobalData.add_player2_kill()
	elif playerID == 3:
		#Check's which player used the gun
		if player1_weapon == "gun":
			GlobalData.add_player1_kill()
		if player2_weapon == "gun":
			GlobalData.add_player2_kill()
	elif playerID == 4:
		#Check's which player used the axe
		if player1_weapon == "axe":
			GlobalData.add_player1_kill()
		if player2_weapon == "axe":
			GlobalData.add_player2_kill()
	elif playerID == 5:
		#Check's which player used the axe
		if player1_weapon == "wand":
			GlobalData.add_player1_kill()
		if player2_weapon == "wand":
			GlobalData.add_player2_kill()
	GlobalData.get_boss_death()
#This function determines if the hit will be critical or not
func is_criticalHit():
	#Gets a random number from 1-50
	var random_number = randi_range(1,50)
	#Checks if that number is 10
	if random_number == 10:
		#Sets criticalHit to true
		criticalHit = true
	else:
		#Sets the criticalHit to false
		criticalHit = false
#This function will get the damage amount
func damage_amount():
	#Gets a random number from 1-5
	var damage = randi_range(1,3)
	#Returns the randomized number
	return damage

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		get_node("AnimatedSprite2D").play("Walk")
	move_and_slide()
	if ray_cast_right.is_colliding():
		dir = -1
	if ray_cast_left.is_colliding():
		dir = 1
func _process(delta):
	if ray_cast_right.is_colliding():
		dir = -1
	if ray_cast_left.is_colliding():
		dir = 1
	position.x += dir * SPEED * delta
	


func _on_player_detection_left_body_entered(body: Node2D) -> void:
	#checks if the player has entered the area
	if body.name == "Player1":
		#if the player entered the area its spite goes to default
		enemy_sprite.flip_h = false


func _on_player_detection_right_body_entered(body: Node2D) -> void:
	#Checks if the player has entered the area
	if body.name == "Player1":
		#if the player entered the area its spite will flip and face the player
		enemy_sprite.flip_h = true
func shoot_fireball():
	# Instantiate the fireball
	var fireball = fireball_scene.instantiate() as RigidBody2D
	fireball.position = global_position  # Start at the dragon's position
	
	# Calculate direction towards the player
	
	var direction = Vector2.LEFT if randi() % 2 == 0 else Vector2.RIGHT
	fireball.direction = direction  # Pass the direction to the fireball

	# Add fireball to the scene
	get_parent().add_child(fireball)


func _on_fireball_timer_timeout() -> void:
	shoot_fireball()


func _on_fireball_timer_2_timeout() -> void:
	if agression == 0:
		pass
	else:
		shoot_fireball()
