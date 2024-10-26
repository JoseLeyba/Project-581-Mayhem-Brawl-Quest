extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health = 10

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
	if body.name == "Player":
		self.queue_free()


func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.health -= 2
