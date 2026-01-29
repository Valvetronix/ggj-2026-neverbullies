extends Control

@export var level: PackedScene
@export var config: PackedScene

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(level)

func _on_config_button_pressed() -> void:
	get_tree().change_scene_to_packed(config)
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()
