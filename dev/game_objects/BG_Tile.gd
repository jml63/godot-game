extends Sprite

var board_tex = preload("res://assets/border.png")

func _ready():
	set_offset(Vector2(0,0))
	set_texture(board_tex)