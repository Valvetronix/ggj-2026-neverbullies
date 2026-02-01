#Esta seria la interfaz que extiende el script de cada ventana. 
 
class_name LevelState
extends Node

var window: Node2D

signal transitioned(state: LevelState, new_state_name: LevelState)

# Se llama cuando el estado se activa
func enter() -> void:
	pass

# Se llama cuando el estado se desactiva (antes de cambiar a otro)
func exit() -> void:
	pass


func _process(_delta: float) -> void:
	pass
	

func _physics_processe(_delta: float) -> void:
	pass
