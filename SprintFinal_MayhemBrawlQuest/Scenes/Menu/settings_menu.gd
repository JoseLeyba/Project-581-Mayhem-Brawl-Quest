'''
Authors: Alexandra, Sophia, Eli, Jose, and Riley
Date: 10/27/2024
Last modified: 10/31/2024
Purpose: Settings Menu Script
'''
extends Node
# Constants for the volume levels
const HIGH_VOLUME = 0.0  # 0 dB (High)
const MEDIUM_VOLUME = -20.0  # -10 dB (Medium)
const LOW_VOLUME = -60.0  # -20 dB (Low)
#function triggered when the back button is pressed.
func _on_back_pressed() -> void:
	#Changes the scene to the StartMenu scene
	get_tree().change_scene_to_file("res://Scenes/Menu/startMenu.tscn")
#function triggered when the manual button is pressed.
func _on_manual_pressed() -> void:
	#Changes the scene to the manual scene
	get_tree().change_scene_to_file("res://Scenes/Menu/manual.tscn")
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
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db_level)
func set_medium_music_volume(db_level: float) -> void:
	# Set the volume of the Music audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db_level)
func set_low_music_volume(db_level: float) -> void:
	# Set the volume of the Music audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db_level)
# Helper function to adjust the sound effects audio bus volume
func set_sound_effects_high_volume(db_level: float) -> void:
	# Set the volume of the SoundEffects audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), db_level)
func set_sound_effects_medium_volume(db_level: float) -> void:
	# Set the volume of the SoundEffects audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), db_level)
func set_sound_effects_low_volume(db_level: float) -> void:
	# Set the volume of the SoundEffects audio bus
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), db_level)

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))
