extends Sprite2D
class_name Client

var client_sprites = C.CLIENT_SPRITES
var client_dialogues = C.CLIENT_DIALOGUES
@export var sprites: Node2D
@export var cw_client: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprites.hide()
	spawn_client()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_client():
	var data = randomize_client()
	var sprite_path = data.client
	var order = data.order
	cw_client.texture = load(sprite_path)
	send_ordered_mask(order)
	

func randomize_client():
	var random_sprite = randi() % C.CLIENT_SPRITES.size()
	var choosen_client = C.CLIENT_SPRITES[random_sprite]
	
	var dialogue_keys = C.CLIENT_DIALOGUES.keys()
	var random_key = randi() % dialogue_keys.size()
	var random_order = dialogue_keys[random_key]
	var choosen_order = C.CLIENT_DIALOGUES[random_order]
	
	client_sprites.erase(choosen_client)
	client_dialogues.erase(random_order) 
	
	return {"client": choosen_client, "order": choosen_order}
	
func send_ordered_mask(choosen_order):
	var base_color = choosen_order[0]
	var detail_color  = choosen_order[1]
	var material  = choosen_order[2]
	var accesories  = choosen_order[3]
	$Mask.get_order_from_client(base_color, detail_color, material, accesories)
