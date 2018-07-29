extends Node2D

enum ENTITY_TYPES {EMPTY}
var x = 0
var y = 0
var points = 0
var map
var type
var sprite
var color

func setup(_x, _y, _type, _pts, _col):
	x = _x
	y = _y
	type = _type
	points = _pts
	color = _col
	$Pivot/Sprite.set_offset(Vector2(0,0))
	$Pivot/Sprite.set_texture(sprite)
	map = get_parent().map
	map[x][y] = self
	$Pivot.position.x = x*(64+get_parent().gap) + get_parent().center
	$Pivot.position.y = y*68 + 128
	$Pivot/Label.text = str(points)
	
func _process(delta):
	if get_parent().sel_one == self || get_parent().sel_two == self:
		$Pivot/Sprite.set_modulate(Color(1, 1, 1, 1))
	else:
		if type != EMPTY:
			$Pivot/Sprite.set_modulate(color)
		else:
			$Pivot/Sprite.set_modulate(Color(1, 1, 1, 0))
			points = ""
	$Pivot/Sprite.set_texture(sprite)
	$Pivot/Label.text = str(points)
	
func play_anim(anim):
	$AnimationPlayer.play(anim)
	yield($AnimationPlayer, "animation_finished")