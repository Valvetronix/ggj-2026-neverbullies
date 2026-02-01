extends Node
var ordered_base_color : Color
var ordered_detail_color 
var ordered_accesories 
var ordered_material

var created_base_color : Color
var created_detail_color 
var created_accesories 
var created_material

var score : ScoreManager
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = ScoreManager.new()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Si alguien sabe como tipar con condicionales, seria ideal ponerle el tipo o null. 
func get_order_from_client(base_color : Color, detail_color, material, accesories): 
	ordered_base_color = base_color
	ordered_detail_color = detail_color
	ordered_accesories = accesories
	ordered_material  = material 
	print("Nodo: ", self.get_path())
	print(
		"ordered_base_color", ordered_base_color, 
		"ordered_detail_color", ordered_detail_color,
		"ordered_accesories", ordered_accesories, 
		"ordered_material", ordered_material )

#func get_score():
	
