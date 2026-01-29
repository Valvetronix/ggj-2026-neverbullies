extends Node2D

@export var sheet: Polygon2D
@export var cutter: CharacterBody2D

# Configuración de la hoja y del punto inicial del cutter
@export var sheet_size := Vector2(400, 300)
@export var start_offset := Vector2(50, 150)


func _ready() -> void:
	_setup_sheet()
	_place_cutter()
	cutter.cut_finished.connect(_on_cutter_finished)


func _setup_sheet() -> void:
	var points = PackedVector2Array([
		Vector2.ZERO,
		Vector2(sheet_size.x, 0),
		sheet_size,
		Vector2(0, sheet_size.y)
	])
	
	sheet.polygon = points
	
	sheet.position = Vector2(100, 100) 
	sheet.color = Color.AQUAMARINE


func _place_cutter() -> void:
	cutter.global_position = sheet.global_position + start_offset
	cutter.start_trail()


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
		
		# Opcional: Crear el objeto físico/visual del pedazo que cortamos
		_spawn_cutout(final_polygon)
	else:
		# Si el array está vacío, significa que no quedó nada de hoja
		sheet.queue_free()

func _spawn_cutout(points: PackedVector2Array) -> void:
	# Función visual para ver lo que recortamos
	var poly = Polygon2D.new()
	poly.polygon = points
	poly.color = Color.ORANGE
	add_child(poly)
