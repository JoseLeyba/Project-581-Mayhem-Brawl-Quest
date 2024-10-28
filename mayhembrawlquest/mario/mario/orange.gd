extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if Global.health < 10:
		Global.health += 1
		queue_free()
	else:
		queue_free()
