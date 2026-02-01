extends LevelState
@export var client: Sprite2D
@export var client_marker: Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CWClient.global_position = client_marker.global_position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
