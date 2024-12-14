extends CharacterBody2D




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func push(push_direction:Vector2):
	velocity += push_direction


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.attempt_grow()):
		queue_free()
	else:
		print("pellet was not picked up")
	
