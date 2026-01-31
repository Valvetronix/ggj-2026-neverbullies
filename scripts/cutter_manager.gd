extends Node2D

@export var sheet: Polygon2D
var cutter: CharacterBody2D
@export var spawn: Node2D

# Configuración de la hoja y del punto inicial del cutter
@export var sheet_size := Vector2(400, 300)
@export var start_offset := Vector2(50, 150)

var rect_box: Rect2 = Rect2()
var is_cutter_placed: bool = false
var poly_shape: Polygon2D


func _ready() -> void:
	_setup_sheet()
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MouseClick") && !is_cutter_placed:
		is_cutter_placed = true
		_place_cutter(get_viewport().get_mouse_position())

func _setup_sheet() -> void:
	var points = PackedVector2Array([
		Vector2.ZERO,
		Vector2(sheet_size.x, 0),
		sheet_size,
		Vector2(0, sheet_size.y)
	])
	
	sheet.polygon = points
	rect_box = _get_bounding_box(points)
	
	sheet.position = Vector2(100, 100) 
	rect_box.position = sheet.position
	sheet.color = Color.AQUAMARINE
	
func _get_bounding_box(poly: PackedVector2Array) -> Rect2:
	var min_v: Vector2 = poly[0]
	var max_v: Vector2 = poly[0]
	
	for v in poly:
		min_v.x = min(min_v.x, v.x)
		min_v.y = min(min_v.y, v.y)
		max_v.x = max(max_v.x, v.x)
		max_v.y = max(max_v.y, v.y)
		
	var pos: Vector2 = min_v
	var size: Vector2 = max_v - min_v
	
	return Rect2(pos, size)


func _place_cutter(pos: Vector2) -> void:
	cutter = preload("res://scenes/cutter.tscn").instantiate()
	add_child(cutter)
	cutter.cut_finished.connect(_on_cutter_finished)
	cutter.global_position = pos
	cutter.start_trail(rect_box)


func _on_cutter_finished(global_points: PackedVector2Array) -> void:
	# 1. Preparar los puntos: Convertir de Global a Local
	# Creamos una lista vacía donde guardaremos los puntos transformados
	var final_polygon = PackedVector2Array() 
	
	# Recorremos cada punto que nos envió el cutter y lo convertimos
	# usando 'sheet.to_local()'. Esto arregla el error de tipos.
	for p in global_points:
		final_polygon.append(sheet.to_local(p))
	
	# 2. Cerrar el polígono 
	# Geometry2D necesita que el último punto conecte con el primero
	if final_polygon.size() > 2:
		final_polygon.append(final_polygon[0])
	
	# 3. Realizar el recorte (La magia matemática)
	# clip_polygons resta la forma del usuario (final_polygon) a la hoja (sheet.polygon)
	var result = Geometry2D.clip_polygons(sheet.polygon, final_polygon)
	
	# 4. Aplicar el resultado visualmente
	if result.size() > 0:
		# Actualizamos la forma de la hoja con el nuevo polígono recortado
		# (Tomamos result[0] asumiendo que la hoja no se partió en dos pedazos aún)
		sheet.polygon = result[0]
		
		_spawn_cutout(result[1])
		
		#if result.size() > 2:
			#_failed_cut()
		#else:
			## Opcional: Crear el objeto físico/visual del pedazo que cortamos
			#_spawn_cutout(final_polygon)
		
	else:
		# Si el array está vacío, significa que no quedó nada de hoja
		sheet.queue_free()

func _spawn_cutout(points: PackedVector2Array) -> void:
	# Función visual para ver lo que recortamos
	_center_points(Vector2.ZERO, points)
	poly_shape = Polygon2D.new()
	poly_shape.polygon = points
	poly_shape.color = Color.ORANGE
	
	spawn.add_child(poly_shape)
	poly_shape.position = spawn.position
	_clear_work_station()
	
func _center_points(cent: Vector2, poly: PackedVector2Array) -> void:
	for p in poly:
		cent += p
	cent /= poly.size()
		
	for i in range(poly.size()):
		poly[i] -= cent
		
func _failed_cut() -> void:
	is_cutter_placed = false
	cutter.queue_free()
	_setup_sheet()
	
func _clear_work_station() -> void:
	sheet.queue_free()
	cutter.queue_free()
