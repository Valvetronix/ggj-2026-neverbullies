extends Node2D
class_name ScoreManager

var score : int

func _ready():
	score = 0
	getScore()

func compareColor(client_color: Color, actual_color:Color):
	if client_color == actual_color:
		score += 1

func compareArray (client_array: Array, actual_array: Array):
	if actual_array.is_empty() && client_array.is_empty():
		score += 1
	var matches = 0
	var actual_array_copy = actual_array.duplicate()
	
	for element in client_array:
		var index = actual_array_copy.find(element) ## Puede ser que usar has sea mejor. 
		if index != -1:
			matches += 1
			actual_array_copy.remove_at(index)

	if matches == client_array.size():
		score += 1
		if actual_array_copy.is_empty():
			score += 1

func compareIndex (client_index: int, actual_index: int):
	if client_index == actual_index:
		score += 1

func getScore():
	#compareColor(client_base_color, actual_base_color)
	#compareColor(client_detail_color, actual_detail_color)
	#compareIndex(client_material, actual_material)
	#compareArray(client_accesory, actual_accesory)
	pass
