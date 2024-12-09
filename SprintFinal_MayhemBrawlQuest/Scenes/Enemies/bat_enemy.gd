extends CharacterBody2D

const SPEED = 150
var dir: Vector2

var is_bat_chase: bool  #value that checks if the bat detects the player

#Reference to the game manager node
@onready var game_manager: Node = %GameManager
#Reference to the enemy health bar
@onready var enemy_bar: ProgressBar = %EnemyBar
#Sound effect for dying
@onready var die_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D  

#Maximum health of the enemy
var maxHealth = 100
#The enemyHealth starts at the max health
var enemyHealth = maxHealth
#Sets if the hit given was a critical hit to false to begin with
var criticalHit = false
#The additional impact of the critical hit if it occurs
var criticalHitImpact = 0

# func runs on start up
func _ready():
	is_bat_chase = false  

func _process(delta):
	move(delta)
	handle_anim()

func move(delta):
	if !is_bat_chase:
		velocity += dir * SPEED * delta
	move_and_slide()
	
func _on_timer_timeout():
	$Timer.wait_time = choose([1.0, 1.5, 2.0])
	if !is_bat_chase:
		dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
		print(dir)
		
func handle_anim():
	var anim_sprite = $AnimatedSprite2D
	anim_sprite.play("fly")
	if dir.x == 1:
		anim_sprite.flip_h = true
	elif dir.x == -1:
		anim_sprite.flip_h = false
	
func choose(array):
	array.shuffle()
	return array.front()
	
#function is triggered when area of the bat's body is entered
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

#This function will decrease the health of the mushroom
func take_damage(damage: int, playerID: int):
	die_sound.play()
	if enemyHealth <= 0:
		return 
	#Decrease the enemyHealth by the damage
	enemyHealth -= damage
	#Checks if the enemy health is less than or eqaul to 0
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
	var player1_weapon = GlobalData.get_player1_weapon()
	var player2_weapon = GlobalData.get_player2_weapon()
	#Removes the duck from the scene
	#queue_free()  
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
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
		#Check's which player used the sword
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
