'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 12/07/2024
Purpose: Player 2 Script
'''
extends CharacterBody2D
#Here we have the speed, the speed for jumping, it's sprite to call the  different animations, a timer for double jumping
var SPEED = 300.0
var BASE_SPEED = 300.0
var JUMP_VELOCITY = -500.0
var BASE_JUMP_VELOCITY = -500.0

@onready var sprite_2d = $Sprite2D
@onready var jump_timer: Timer = $Timer
#Time to charge the wand
@onready var charge_timer: Timer = $ChargeTimer 
#The gravity for falling physics
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#The amount of jumps that have been done by the character
var jump_count = 0
#How many can they jump before touching the floor (minus one)
var max_jump_count = 1
#A damage variable that will be used for implementing weapons 
var dmg = false
#And the variable to stop jumping when reaching the max
var can_jump = true
var weapon = "gun"
#Then all the weapon related stuff related stuff
#This preloads its sprites
@export var sword_scene: = preload("res://Scenes/Weapons/sword.tscn")
@export var axe_scene: = preload("res://Scenes/Weapons/axe.tscn")
@export var wind_bullet = preload("res://Scenes/Weapons/Wind_Bullet.tscn")
@export var wand = preload("res://Scenes/Weapons/wand.tscn")
#This is its offset so it know where to shoot from or hold the weapon
@export var shoot_offset: Vector2 = Vector2(16, 0)  
@export var sword_offset: Vector2 = Vector2(35, 28)
@export var wand_offset: Vector2 = Vector2(35, 28)
#This says that the weapon isnt out yet
var sword_instance: Node2D = null
var staff_instance: Node2D = null
var axe_instance: Node2D = null
var is_charging_wand = false
#This is the force of throwing them
@export var throw_force: Vector2 = Vector2(600, -500)
#Also takes into account the other player so it can throw them in the air
@export var other_player: CharacterBody2D

var player = "jose"

func _ready()->void:
	player = GlobalData.get_player2_character()

func jump():
	if jump_count < max_jump_count and can_jump:
		jump_count += 1  
		can_jump = false
		jump_timer.start() 
		#Here we have the jumping action accompanied by its animation
		velocity.y = JUMP_VELOCITY
		if player == "jose":
			sprite_2d.animation = "jose_jumping"
		elif player == "eli":
			sprite_2d.animation = "eli_jumping"
		elif player == "allie":
			sprite_2d.animation = "allie_jumping"
		elif player == "riley":
			sprite_2d.animation = "riley_jumping"
		else:
			sprite_2d.animation = "sophia_jumping"


func shoot_bullet():
	var bullet_scene = load("res://Scenes/Weapons/bullet.tscn") as PackedScene
	if bullet_scene:
		var bullet = bullet_scene.instantiate() as RigidBody2D
		if bullet:
			bullet.position = global_position + shoot_offset.rotated(rotation)
			bullet.rotation = rotation
			get_parent().add_child(bullet)

	
#If the sword isn't out yet, then create one and place it on the player
func sword_appear():
	if sword_instance == null:
		sword_instance = sword_scene.instantiate() as Node2D
		sword_instance.position = global_position + sword_offset
		get_parent().add_child(sword_instance)
#If the axe isn't out yet, then create one and place it on the player
func axe_appear():
	if axe_instance == null:
		axe_instance = axe_scene.instantiate() as Node2D
		axe_instance.position = Vector2(16, 0)  # Adjust to place it at the player's hand
		add_child(axe_instance)


#When stopping pressing Q, despawn the sword
func sword_despawn():
	if sword_instance != null:
		sword_instance.queue_free()
		sword_instance = null
#When stopping pressing Q, despawn the axe
func axe_despawn():
	if axe_instance != null:
		axe_instance.queue_free()
		axe_instance = null

#Starts the wand attack timer
func start_wand_charge():
	if staff_instance == null:
		staff_instance = wand.instantiate() as Node2D
		staff_instance.position = global_position + wand_offset
		get_parent().add_child(staff_instance)
	if not is_charging_wand:
		is_charging_wand = true
		charge_timer.start() 
		
#When the time ends, shoot the projectile and start the process again
func fire_wand_projectile():
	if is_charging_wand:
		var projectile = wind_bullet.instantiate() as RigidBody2D
		projectile.position = global_position + shoot_offset
		projectile.rotation = rotation
		get_parent().add_child(projectile)
		is_charging_wand = false
# Cancels the Wand attack
func cancel_wand_charge():
	if staff_instance != null:
		staff_instance.queue_free()
		staff_instance = null
		is_charging_wand = false
		charge_timer.stop()  
func apply_powerups():
	#Check speed power-up
	if GlobalData.get_player1_speed():
		#Increase speed by 50%
		SPEED = BASE_SPEED * 1.5
	else:
		#Reset to base speed
		SPEED = BASE_SPEED
		#Check jump power-up
	if GlobalData.get_player1_jump_speed():
		#Increase jump by 20%
		JUMP_VELOCITY = BASE_JUMP_VELOCITY * 1.2  
	else:
		 #Reset to base jump
		JUMP_VELOCITY = BASE_JUMP_VELOCITY 
	#Check triple jump power-up
	if GlobalData.get_player1_triple_jump():
		max_jump_count = 2
	else:
		max_jump_count = 1
	# Check gravity power-up
	if GlobalData.get_player1_gravity():
		#Reduce gravity by half
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.5 
	else:
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Here are all physics related issues: The animations for walking/running, and maps all "moving" keys to the action
func _physics_process(delta):
	velocity.x = 0
	apply_powerups()
	if (velocity.x > 1 || velocity.x < -1):
		if player == "jose":
			sprite_2d.animation = "jose_running"
		elif player == "eli":
			sprite_2d.animation = "eli_running"
		elif player == "allie":
			sprite_2d.animation = "allie_running"
		elif player == "riley":
			sprite_2d.animation = "riley_running"
		else:
			sprite_2d.animation = "sophia_running"
	else:
		if player == "jose":
			sprite_2d.animation = "jose_default"
		elif player == "eli":
			sprite_2d.animation = "eli_default"
		elif player == "allie":
			sprite_2d.animation = "allie_default"
		elif player == "riley":
			sprite_2d.animation = "riley_default"
		else:
			sprite_2d.animation = "sophia_default"
	
	# if no key is pressed for left or right, x velocity is zero
	if Input.is_key_pressed(KEY_L):
		velocity.x = SPEED
	elif Input.is_key_pressed(KEY_J):
		velocity.x = -SPEED
	if Input.is_key_pressed(KEY_K):
		if player == "jose":
			sprite_2d.animation = "jose_crouching"
		elif player == "eli":
			sprite_2d.animation = "eli_crouching"
		elif player == "allie":
			sprite_2d.animation = "allie_crouching"
		elif player == "riley":
			sprite_2d.animation = "riley_crouching"
		else:
			sprite_2d.animation = "sophia_crouching"
	#When pressing the attack button it spawn sword and when stopping pressing it despawn it
	if Input.is_key_pressed(KEY_U):
		handle_weapons_spawn()
	if Input.is_key_pressed(KEY_M):
		if is_near_other_player():
			throw_other_player()
	#When stopping pressing it we will handle the specific weapon despawn
	elif not Input.is_key_pressed(KEY_Q):
		handle_weapons_unspawn()
		
	#Moves the sword every frame
	if sword_instance != null:
		sword_instance.position = global_position + sword_offset
	
	if staff_instance != null:
		staff_instance.position = global_position + wand_offset
	#When in the air gets affected by gravity to get back again
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_key_pressed(KEY_I):
		jump()
	#If on floor, resetr the ability to jump and the jumps done
	if is_on_floor():
		jump_count = 0
	#Allows the movement 
	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

#Here we match all possible weapons the character can have and we do its ability
func handle_weapons_spawn():
	match weapon:
		"gun":
			shoot_bullet()
		"sword":
			sword_appear()
		"axe":
			axe_appear()
		"wand":
			start_wand_charge()

#For weapons that need to despawn we do it here
func handle_weapons_unspawn():
	match weapon:
		"sword":
			sword_despawn()
		"wand":
			cancel_wand_charge()
		"axe":
			axe_despawn()



#Changes Weapon in hand
func weapon_change(new_weapon : String):
	weapon = new_weapon
	charge_timer.stop()
#When timer reaches 0, allows for double jump
func _on_Timer_timeout() -> void:
	can_jump = true
#Shoots the wind bullet when timer is over
func _on_ChargeTimer_timeout() -> void:
	fire_wand_projectile()


#This gets called to check if it can throw the P1, just calculates the distance to see if it's within range
func is_near_other_player() -> bool:
	#Checks if another player exists
	if other_player:
		#Calculates the distance between the two players
		var distance = global_position.distance_to(other_player.global_position)
		#Returns true if the distance is less than 80
		return distance < 80
	#Returns false if the distance is greater than or equal to 80  
	return false

#Does the thorwing action when possible
func throw_other_player():
	#Checks if another player exists
	if other_player:
		#Sets their velocity to the throwing_force velocity
		other_player.velocity = throw_force
		
