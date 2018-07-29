extends Node

enum ENTITY_TYPES {EMPTY, PLAYER}
var points = 2
var color = Color(.8, .8, .8, 1)
var sprite = preload("res://assets/player.png")
var type = PLAYER