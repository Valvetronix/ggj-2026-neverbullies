extends LevelState
@export var cw_background: Sprite2D
@export var cw_client: Sprite2D
@export var cw_next_window_button: Button 
@export var cw_dialogue_bubble: Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	spawn_client()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_client():
	get_random_client()
	
func get_random_client():
	var random_sprite = randi()%10
	var random_order = randi()%10
#	var choosen_sprite = C.CLIENT_SPRITES[random_sprite]
#	var choosen_orden = C.CLIENT_DIALOGUES[random_order]
