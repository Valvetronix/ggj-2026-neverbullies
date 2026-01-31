extends Node

var clients: Array[Node2D]
var masks: Array[Node2D]

#cambiar tipo de clase de cliente
func add_client(client: Node2D):
	clients.append(client)
	
func add_mask(mask: Node2D):
	masks.append(mask)
