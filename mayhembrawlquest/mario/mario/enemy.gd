extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var enemy_health = 2

	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player")


#move_and_slide()

func _on_player_death_body_entered(body: Node2D) -> void:
	'''if body.name == "Player":
		if randf() < 0.5:
			enemy_health -= 2
		else:
			enemy_health -= 1
		if enemy_health == 0:
			self.queue_free()'''
	if body.name == "Player":
		var damage_amount = 1
		if randf() < 0.5:
			damage_amount = 2
			
			enemy_health -= damage_amount
			Global.health -= damage_amount
			
			if enemy_health <= 0:
				self.queue_free()


func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.armor <= 0:
			Global.health -= 1
		else:
			Global.armor -=1
