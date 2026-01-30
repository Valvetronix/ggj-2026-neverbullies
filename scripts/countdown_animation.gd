extends Node

@export var first_day_background: ColorRect
@export var background: ColorRect
@export var countdownText: RichTextLabel
@export var animation_player: AnimationPlayer

const TEXT_TEMPLATE: String = "[rainbow freq=0.1][wave amp=25.0 freq=10.0 connected=0.75][tornado radius=1.0 freq=1.0 connected=150]%d DIAS PARA EL CARNAVAL[/tornado][/wave]"
var remaining_days = 10

func _ready():
	countdownText.text = TEXT_TEMPLATE % remaining_days
	
func _on_level_day_finished() -> void:
	remaining_days -= 1
	countdownText.text = TEXT_TEMPLATE % remaining_days
	animation_player.play()

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	_show()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	_hide()

func _hide():
	first_day_background.visible = false
	background.visible = false
	countdownText.visible = false

func _show():
	background.visible = true
	countdownText.visible = true	
