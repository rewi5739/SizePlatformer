extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Restart"):
		call_deferred("restart")
	elif Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	elif Input.is_action_just_pressed("ui_accept"):
		call_deferred("start")

func restart():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func start():
	get_tree().change_scene_to_file("res://Scenes/world1.tscn")
