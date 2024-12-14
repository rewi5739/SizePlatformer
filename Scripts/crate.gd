extends CharacterBody2D

var push_speed = 7
var pushable = false

func _init():
	Globals.connect("stationary_crates", make_stationary)
	Globals.connect("pushable_crates", make_pushable)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		#print(".")

	move_and_slide()
	
	push(Vector2(0,0))
	
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "SizeCharacter":
			push(global_position - collision.get_collider().global_position)

func push(direction):
	if pushable:
		#var preVelocity = velocity
		velocity.x = push_speed * direction.x
		#print("pushed: ", preVelocity, " to ", velocity)

func make_pushable():
	pushable = true
	
func make_stationary():
	pushable = false
