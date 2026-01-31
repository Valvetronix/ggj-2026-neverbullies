extends CharacterBody2D

# Señales
signal cut_finished(points: PackedVector2Array)

# Config
@export var speed: float = 1.0
@export var trail: Line2D
@export var finish_cut_threshold: float = 5.0

# Estado
var current_direction: Vector2 = Vector2.ZERO
var is_moving: bool = false
var input = Vector2.ZERO
var boundingBox: Rect2 = Rect2()

# Trazado
var points_buffer: PackedVector2Array = []

func _ready() -> void:
	trail.top_level = true
	trail.global_position = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	
	if boundingBox.get_area() <= 0:
		return
	is_moving = true
	input = get_viewport().get_mouse_position()
	var targetDirection = (input - position).normalized()
	var direction = velocity.normalized().lerp(targetDirection, 0.1)
	var newspeed = speed * (input - position).length()
	velocity = newspeed * direction.normalized()
	
	if boundingBox.has_point(position + velocity.normalized()):
		move_and_slide()
		_record_position()
	
		# Si la cantidad de puntos dibujada es mayor a 10 (para evitar que se cierre apenas empezas a dibujar)
		# y la posición del cutter es menor a 15 pixeles del punto inicial, termina el corte.
		if points_buffer.size() > 10 and global_position.distance_to(points_buffer[0]) < finish_cut_threshold:
			_finish_cut()

# Dibuja el recorrido del cutter 
func _record_position():
	# Guardo un punto cada vez que la distancia con el ultimo sea de 5 pixeles (así no explota todo)
	if points_buffer.is_empty() or global_position.distance_to(points_buffer[-1]) > 5.0:
		points_buffer.append(global_position)
		trail.add_point(global_position)

# Limpia el trazado que se hacía desde el 0,0 global hacia donde comienza el cutter (lo llama LevelManager)
func start_trail(bbox: Rect2) -> void:
	trail.clear_points()
	points_buffer.clear()
	points_buffer.append(global_position)
	trail.add_point(global_position)
	boundingBox = bbox


func _finish_cut() -> void:
	is_moving = false
	velocity = Vector2.ZERO
	
	# Esta señal la toma el LevelManager
	cut_finished.emit(points_buffer)
