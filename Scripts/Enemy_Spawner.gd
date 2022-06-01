extends Node

var time = 0
var limU = Vector2.ZERO
var limD = Vector2.ZERO
var limX = Vector2.ZERO
var i = 10
onready var player = owner.get_node('Player')

func _process(delta):
	randomize()
	time = player.time
	limU = player.global_position.y - 160
	limD = player.global_position.y + 160
	limX = player.global_position.x - 576
	if i == 0:
		var e
		if int(time) % 50 == 0:
			e = preload("res://Scenes/Round Enemy.tscn").instance()
			e.global_position = Vector2(limX, rand_range(limD, limU))
			add_child(e)
		elif int(time) % 25 == 0:
			e = preload("res://Scenes/Winged Enemy.tscn").instance()
			e.global_position = Vector2(limX, rand_range(limD, limU))
			e.type = randi()%2
			add_child(e)
		elif int(time) % 10 == 0:
			e = preload("res://Scenes/Thin Enemy.tscn").instance()
			e.global_position = Vector2(limX, rand_range(limD, limU))
			e.type = randi()%2
			add_child(e)
		i = 10
	elif i > 0:
		i -= 1
