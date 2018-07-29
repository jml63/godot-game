extends Node

enum ENTITY_TYPES {EMPTY, PLAYER, ENEMY, HEART}
var points = 1
var color = Color(.9, .1, .1, 1)
var sprite = preload("res://assets/heart.png")
var type = HEART