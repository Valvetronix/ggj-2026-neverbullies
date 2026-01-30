extends Node2D
@export var cw_background: Sprite2D
@export var cw_client: Sprite2D
@export var cw_next_window_button: Button
@export var cw_dialogue_bubble: Sprite2D
 ##Vas a tener que iterar sobre los sprites y asignarlos con el indice. Lo mismo con el pedido
## Que puede ser un label 
## Y en algun script commons asocias pedido y mascara. 
## A revisar los atributos. 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	spawn_client()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn_client():
	get_random()
	
func get_random():
	var random_sprite = randi()%10
	var random_order = randi()%10
	
