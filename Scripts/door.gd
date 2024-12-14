extends CharacterBody2D

@export var switch : Node
@export var open : bool = false
@onready var main_sprite = $MainSprite
@onready var main_collider = $MainCollider
@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch.got_size.connect(open_door)
	switch.lost_size.connect(close_door)
	if open:
		open_door()
	else:
		close_door()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open_door():
	main_collider.set_deferred("disabled", true)
	#main_sprite.modulate = Color(0.2, 0.2, 0.2, 1)
	anim_player.play("open_door")

func close_door():
	main_collider.set_deferred("disabled", false)
	#main_sprite.modulate = Color(1, 1, 1, 1)
	anim_player.play("close_door")
