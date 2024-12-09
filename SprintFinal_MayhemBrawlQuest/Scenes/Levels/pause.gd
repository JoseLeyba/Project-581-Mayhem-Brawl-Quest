'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 10/31/2024
Purpose: Pause Menu Script
'''
extends Node

#Reference to the pause panel in the scene
@onready var pause_panel: Panel = %PausePanel
#Reference to the controls panel in the scene,
@onready var controls: Panel = %Controls
# Constants for the volume levels
const HIGH_VOLUME = 0.0  # 0 dB (High)
const MEDIUM_VOLUME = -10.0  # -10 dB (Medium)
const LOW_VOLUME = -20.0  # -20 dB (Low)

#function triggered when a resume button is pressed
func _on_resume_pressed() -> void:
	#Hides the pause panel
	pause_panel.hide()
	#Unpauses the game
	get_tree().paused = false
	
#function triggered when a exit button is pressed
func _on_exit_pressed() -> void:
	#Unpauses the game
	get_tree().paused = false
	#Closes the game
	get_tree().quit()

#function triggered when a pause button is pressed
func _on_pause_button_pressed() -> void:
	#Pauses the game
	get_tree().paused = true
	#Shows the pause panel
	pause_panel.show()

#function triggered when a controls button is pressed
func _on_controls_pressed() -> void:
	#Pauses the game
	get_tree().paused = true
	#Shows the controls panel
	controls.show()
	
func _on_back_pressed() -> void:
	#Pauses the game
	get_tree().paused = true
	#Hides controls panel
	controls.hide()
#function triggered when a Exit to Main Menu button is pressed
func _on_main_menu_pressed() -> void:
	#Unpaused the game this will allow the buttons on the startMenu to work
	get_tree().paused = false
	#Changes the scene to the startMenu scene
	get_tree().change_scene_to_file("res://Scenes/Menu/startMenu.tscn")

# Function to set high volume for music
func _on_music_high_volume_pressed() -> void:
	set_high_music_volume(HIGH_VOLUME)

# Function to set medium volume for music
func _on_music_medium_volume_pressed() -> void:
	set_medium_music_volume(MEDIUM_VOLUME)

# Function to set low volume for music
func _on_music_low_volume_pressed() -> void:
	set_low_music_volume(LOW_VOLUME)
# Function to set high volume for sound effects
func _on_sound_effects_high_volume_pressed() -> void:
	set_sound_effects_high_volume(HIGH_VOLUME)

# Function to set medium volume for sound effects
func _on_sound_effects_medium_volume_pressed() -> void:
	set_sound_effects_medium_volume(MEDIUM_VOLUME)

# Function to set low volume for sound effects
func _on_sound_effects_low_volume_pressed() -> void:
	set_sound_effects_low_volume(LOW_VOLUME)

# Helper function to adjust the music audio bus volume
func set_high_music_volume(db_level: float) -> void:
	# Set the volume of the Music audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db_level)
func set_medium_music_volume(db_level: float) -> void:
	# Set the volume of the Music audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Medium"), db_level)
func set_low_music_volume(db_level: float) -> void:
	# Set the volume of the Music audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Low"), db_level)
# Helper function to adjust the sound effects audio bus volume
func set_sound_effects_high_volume(db_level: float) -> void:
	# Set the volume of the SoundEffects audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db_level)
func set_sound_effects_medium_volume(db_level: float) -> void:
	# Set the volume of the SoundEffects audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Medium"), db_level)
func set_sound_effects_low_volume(db_level: float) -> void:
	# Set the volume of the SoundEffects audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Low"), db_level)
