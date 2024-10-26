extends Area2D

class_name Sword

# Sword properties
var damage = 10
var swing_duration = 0.2  # Duration the sword swing is active
var swing_timer = 0.0

# Initialize collision shape as disabled
func _ready():
	$CollisionShape2D.disabled = true

# Triggered by player pressing the attack button
func attack():
	# Start the sword swing
	swing_timer = swing_duration
	$CollisionShape2D.disabled = false

func _process(delta):
	# Handle sword swing duration
	if swing_timer > 0:
		swing_timer -= delta
		if swing_timer <= 0:
			$CollisionShape2D.disabled = true
			print("Sword swing ended.")

# Detect collisions with enemies
func _on_Sword_body_entered(body):
	if body.is_in_group("enemies"):  # Ensure enemies are in the "enemies" group
		print("Enemy hit by sword! Inflicting", damage, "damage.")
		# Apply damage logic here when enemies are implemented
