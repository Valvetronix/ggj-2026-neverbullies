extends Control

@export var level: PackedScene
@export var config: PackedScene


func _on_play_button_pressed() -> void:
	MusicManager.switch_song()
	get_tree().change_scene_to_packed(level)


func _on_config_button_pressed() -> void:
	get_tree().change_scene_to_packed(config)
	
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		MusicManager.stop_music()
	else:
		MusicManager.play_music()
