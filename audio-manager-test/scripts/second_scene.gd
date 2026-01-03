extends Node

func _on_navigate_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_button_1_pressed() -> void:
	var sound_1 = AudioManager.game_audio.sound_1
	AudioManager.play_sound(sound_1)

func _on_button_2_pressed() -> void:
	var sound_2 = AudioManager.game_audio.sound_2
	AudioManager.play_sound(sound_2)

func _on_button_3_pressed() -> void:
	var sound_3 = AudioManager.game_audio.sound_3
	AudioManager.play_sound(sound_3)
