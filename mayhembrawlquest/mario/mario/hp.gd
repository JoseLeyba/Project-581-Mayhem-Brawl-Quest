extends Label


func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.armor <= 0:
			Global.health -= 1
		else:
			Global.armor -=1
