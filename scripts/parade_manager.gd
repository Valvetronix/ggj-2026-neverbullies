extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mask_to_add = ParadeSingleton.masks[0]
	ParadeSingleton.remove_child(mask_to_add)
	add_child(mask_to_add)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
