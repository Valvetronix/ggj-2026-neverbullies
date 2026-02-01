extends Node

enum State {
	COUNTDOWN_WINDOW,
	CLIENT_WINDOW, 
	WORKSHOP_WINDOW,
	ACCESORIES_WINDOW,
	DELIVERY_WINDOW, 
	END_DAY_WINDOW, 
	CELEBRATION_WINDOW
}

const CLIENT_SPRITES = [
	"res://assets/sprites/hombre_sprite_completo.png", 
	"res://assets/sprites/mujer_sprite_completo.png"
]

const CLIENT_DIALOGUES = {
	"Quiero una mascara citrica" : 
		[MASKS_COLORS[4],null,null, null], #Color base, color de detalle, accesorio, material
	"Quiero una mascara primaveral" : 
		[MASKS_COLORS[2], MASKS_COLORS[6], MASKS_MATERIAL[2], MASKS_ACCESORY[3]]
} 

#const CLIENT_ORDERS = {
	##Ejemplo
	#"Citrica" : [MASKS_COLORS[4],"ANY","ANY", 1], 
	#}

const MASKS_COLORS = ["SADDEL_BROWN", "MEDIUM_VIOLET_RED", "HOT_PINK", "RED", "ORANGE", "GOLD", 
"LAWN_GREEN", "DARK_TURQUOISE", "CYAN", "BLUE", "BLUE_VIOLET", "DIM_GRAY"]
const MASKS_MATERIAL = ["LEATHER", "PLASTIC", "FABRIC"]
const MASKS_ACCESORY = ["HORNS", "FEATHERS", "PRECIOUS_STONES", "FLOWERS", "STARTS", "TASSELS", "BUTTONS"]
