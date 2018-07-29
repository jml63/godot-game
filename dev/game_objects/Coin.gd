extends Node

enum ENTITY_TYPES {EMPTY, PLAYER, ENEMY, HEART, COIN}
var points = 2
var color = Color(1, .84, 0, 1)
var sprite = preload("res://assets/coins.png")
var type = COIN