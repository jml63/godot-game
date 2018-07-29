extends Area2D

enum ENTITY_TYPES {EMPTY, PLAYER, ENEMY, HEART, COIN}

func _input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
        self.on_click()

func on_click():
	var par = get_parent().get_parent()
	#If first one isn't selected
	if par.sel_one == null:
		#cant select enemies for first tile
		if get_parent().type != ENEMY:
			par.sel_one = get_parent()
			par.sel_one.play_anim("selected")
		else:
			get_parent().play_anim("invalid")
	#Else if first one is selected
	else:
		#If first one is the one we're clicking on then unselect
		if par.sel_one == get_parent():
			par.sel_one = null
		#Else if second one is null
		elif par.sel_two == null:
			par.sel_two = get_parent()
			var a = (par.sel_one.y == par.sel_two.y) && (abs(par.sel_one.x - par.sel_two.x) == 1)
			var b = (par.sel_one.x == par.sel_two.x) && (abs(par.sel_one.y - par.sel_two.y) == 1)
			if (a || b):
				check_match(par.sel_one, par.sel_two)
			else:
				par.sel_one.play_anim("invalid")
			#unselect them
			par.sel_one = null
			par.sel_two = null
			
func check_match(t1, t2):
	var par = get_parent().get_parent()
	#IF BOTH TILES ARE GOOD
	if t1.type == t2.type || (t2.type != ENEMY):
		if t1.type == HEART && t2.type == COIN:
			par.sel_one.play_anim("invalid")
			return
		if t1.type == PLAYER:
			if t2.type == COIN:
				get_tree().get_root().get_node("RootNode/Position2D/Game").score += t2.points
				t2.points = t1.points
			else:
				t2.points += t1.points
			t2.type = t1.type
			t2.sprite = t1.sprite
			t2.color = t1.color
		elif t1.type == COIN:
			if t2.type == COIN:
				t2.points += t1.points
			elif t2.type == PLAYER:
				get_tree().get_root().get_node("RootNode/Position2D/Game").score += t1.points
			else:
				par.sel_one.play_anim("invalid")
				return
		elif t1.type == HEART:
			t2.points += t1.points
		t1.type = EMPTY
		t1.points = 0
		par.new_piece(t1)
		t2.play_anim("victory")
	#IF PLAYER MOVING ONTO ENEMY
	elif t1.type == PLAYER && t2.type == ENEMY:
		if t1.points > t2.points:
			get_tree().get_root().get_node("RootNode/Position2D/Game").enemy_hp -= t2.points
			t2.type = t1.type
			t2.sprite = t1.sprite
			t2.color = t1.color
			t2.points = t1.points-1
		elif t1.points == t2.points:
			get_tree().get_root().get_node("RootNode/Position2D/Game").enemy_hp -= t2.points
			t2.type = EMPTY
			t2.points = 0
			par.new_piece(t2)
		t1.type = EMPTY
		t1.points = 0
		par.new_piece(t1)
		t2.play_anim("victory")
	else:
		par.sel_one.play_anim("invalid")
