extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://SinglePlayer.tscn")


func _on_multiplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://MultiPlayer.tscn")


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://TutorialMenu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://SettingsMenu.tscn")
