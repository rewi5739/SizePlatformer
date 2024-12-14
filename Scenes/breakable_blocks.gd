extends TileMapLayer

var character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character = get_parent().get_node("SizeCharacter")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
