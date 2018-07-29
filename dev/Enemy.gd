extends Node

enum ENTITY_TYPES {EMPTY, PLAYER, ENEMY}
var points = 5
var color = Color(.3, .6, 0, 1)
var sprite = preload("res://assets/goblin.png")
var type = ENEMY