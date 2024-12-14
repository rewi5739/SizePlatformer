extends Area2D

@onready var main_sprite = $MainSprite
@export var has_size :bool = false
var character_present = null
signal got_size
signal lost_size

func _ready() -> void:
	update_to_state()

func _process(delta: float) -> void:
	if character_present:
		if Input.is_action_just_pressed("ui_accept"):
			swap_size()
	else:
		pass

func update_to_state():
	if has_size:
		main_sprite.modulate = Color("#1aca63")
	else:
		main_sprite.modulate = Color("db4d64")

func _on_body_entered(body: Node2D) -> void:
	character_present = body
	Globals.space_taken = true
	await body_exited
	character_present = null
	Globals.space_taken = false

func swap_size():
	if not has_size and character_present.current_size == "small":
		print("Character is too small to ")
	elif has_size and character_present.current_size == "huge":
		print("Character already at max")
	elif has_size:
		has_size = false
		update_to_state()
		character_present.attempt_grow()
		lost_size.emit()
	else:
		has_size = true
		update_to_state()
		character_present.attempt_shrink()
		got_size.emit()
		
