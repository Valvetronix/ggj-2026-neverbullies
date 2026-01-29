extends Node

@export var background: ColorRect
@export var countdownText: RichTextLabel

func _ready():
	# Conectar señal de que termino el día
	pass

# La señal cambia la cantidad de días
# text = (parámetro días) " DIAS PARA EL CARNAVAL..."

func _hide():
	background.visible = false
	countdownText.visible = false
	
