extends Node

var player = preload("res://game_objects/Player.tscn").instance()
var enemy = preload("res://game_objects/Enemy.tscn").instance()
var heart = preload("res://game_objects/Heart.tscn").instance()
var coin = preload("res://game_objects/Coin.tscn").instance()

enum ENTITY_TYPES {EMPTY}
var map_size = 5
var map = []
var gap = 8
var center
var Entity = preload("res://game_objects/Entity.tscn")
var sel_one = null
var sel_two = null
var score = 0
var enemy_hp = 100
const enemy_hp_max = 100
var tile_pool = []

func _ready():
	add_child(player)
	add_child(enemy)
	add_child(heart)
	add_child(coin)
	init_game()
	
func init_game():
	#Setup map array and bg tiles
	for x in range(map_size):
		map.append([])
		for y in range(map_size):
			map[x].append(null)
			#Draw some background tiles
			var bg_tile = load("res://game_objects/BG_Tile.tscn").instance()
			center = get_parent().center_width
			bg_tile.position = Vector2(x*(64+gap)+center, y*(64+gap) + 128)
			add_child(bg_tile)
			
			#Add a entity instance for each tile
			var test = Entity.instance()
			add_child(test)
			test.setup(x, y, EMPTY, 0, Color(1, 1, 1, 1))
			
	for x in range(map_size):
		for y in range(map_size):		
			new_piece(map[x][y])
				
func new_piece(piece):
	randomize()
	var n = randi()%3+1
	var picked
	if n == 1:
		picked = player
	elif n == 2:
		picked = enemy
	elif n == 3:
		if (randf() < 0.5):
			picked = heart
		else:
			picked = coin
		
	piece.color = picked.color
	piece.type = picked.type
	piece.points = picked.points
	piece.sprite = picked.sprite
	piece.play_anim("created")
	
func _process(delta):
	get_parent().get_parent().get_node("UI/Top/Score").text = str(score)
	get_parent().get_parent().get_node("UI/TopRight/Health").text = str(enemy_hp) + "/" + str(enemy_hp_max)