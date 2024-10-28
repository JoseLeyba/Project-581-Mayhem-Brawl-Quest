extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.health < 3:
			Global.health == 3
		queue_free()
