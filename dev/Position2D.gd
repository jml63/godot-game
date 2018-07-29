extends Position2D
var center_width

func _ready():
	center_width = (get_viewport().size.x/2) - (2.5*64) + 16
	var a = load("res://Game.tscn").instance()
	add_child(a)