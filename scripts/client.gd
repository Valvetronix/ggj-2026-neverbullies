extends Node2D
class_name Client

@export var animation_player: AnimationPlayer

func change_animation(anim_id: String) -> void:
	if not animation_player:
		push_error("Error: AnimationPlayer no asignado")
		return
	
	if animation_player.current_animation == anim_id:
		return
	
	if animation_player.has_animation(anim_id):
		animation_player.play(anim_id)
	else:
		push_warning("La animación '" + anim_id + "' no existe")
