extends KinematicBody2D

export var ACC = 500
export var MAXSPEED = 7500
export var FRIC = 500
var dir = Vector2.ZERO
var vel = Vector2.ZERO
var time = 0
var score = 0

func _process(delta):
	$CanvasLayer/Label.text = str(int(time))
	$CanvasLayer/Label2.text = str(int(score))
	get_parent().get_node("AudioStreamPlayer").pitch_scale = 1+(score/5000)
	time += (10*delta)*(1+(score/5000))
	MAXSPEED = 7500 * (1+(score/5000))
	$Tails.speed_scale = 1+(score/5000)
	$Sonic.speed_scale = 1+(score/5000)
	if Input.is_mouse_button_pressed(1):
		dir.y = (get_global_mouse_position()-global_position).normalized().y
	else:
		dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	dir.x = -1
	vel += dir*ACC*delta
	vel = vel.clamped(MAXSPEED*delta)
	owner.get_node("Camera2D").limit_right = global_position.x + 512
	if Input.is_action_just_pressed("ui_accept") and get_tree().get_nodes_in_group('bullets').size()<2:
		var b = preload("res://Scenes/Bullet.tscn").instance()
		b.global_position = global_position-Vector2(72,0)
		owner.add_child(b)
	vel = move_and_slide(vel, Vector2.UP)

func die():
	$AnimationPlayer.play("ded")
	get_parent().get_node("AudioStreamPlayer").pitch_scale = 0.5
	get_tree().paused = true
