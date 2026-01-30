extends Node

signal day_finished

func _on_finish_day_button_pressed() -> void:
	day_finished.emit()
	print("aprete el boton?")
