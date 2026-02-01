extends Node2D

var spawn_points: Array[Marker2D] = []
var clients_mock: Array[Client] = []
@export var client_scene: PackedScene

func _ready() -> void:
	for child in $positions.get_children():
		if child is Marker2D:
			spawn_points.append(child)
			
	_create_mock_clients(10)
	
	_spawn_clients(clients_mock)

func _spawn_clients(clients: Array[Client]) -> void:
	# Verificamos que no intentemos acceder a un índice que no existe
	var limit = min(clients.size(), spawn_points.size())
	
	for i in range(limit):
		var client = clients[i]
		var point = spawn_points[i]
		
		# Asignamos la posición global para evitar problemas de herencia
		client.global_position = point.global_position
		
		# Si aún no están en el árbol, los añadimos (opcional)
		if not client.is_inside_tree():
			add_child(client)
			
	if clients.size() > spawn_points.size():
		push_warning("Hay más personajes que posiciones disponibles.")


func _create_mock_clients(amount: int) -> void:
	for i in range(amount):
		var new_client = client_scene.instantiate()
			
		new_client.name = "MockClient_" + str(i)
		clients_mock.append(new_client)
