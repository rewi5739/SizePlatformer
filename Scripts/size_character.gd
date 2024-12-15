extends CharacterStateMachine
class_name SizeCharacter

## Use to keep track of important values for each size.
## Collision size, Jump velocity (negative), speed, sprite location
@export var size_values : Dictionary = {"small"  : [28, -480, 300, "small"],
										"medium" : [60, -520, 250, "medium"],
										"large"  : [60, -250, 200, "large"],
										"huge"   : [120, -370, 430, "huge"]}

@onready var main_sprite = $MainSprite
@onready var main_collider = $MainCollider
var asset_location = "res://Assets/"

var speed = 300.0
var jump_velocity = -400.0
var jumping = true
var current_size = "small"
var coyote_time = 0.7

func do_movement(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		if jumping:
			jumping = false
			coyote_time = 0.7
			#print("emitting Landed")
			landed.emit()
	else:
		velocity += get_gravity() * delta
		coyote_time -= delta
		

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and (coyote_time>=0 or is_on_floor()) and not Globals.space_taken:
		jumping=true
		coyote_time = 0
		jumped.emit()
		velocity.y = jump_velocity

	if Input.is_action_just_pressed("shrink"):
		#print("input shrink action")
		attempt_shrink()
	
	if Input.is_action_just_pressed("grow"):
		#print("input grow action")
		attempt_grow()
		
	if Input.is_action_just_pressed("Restart"):
		call_deferred("reset_level")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction > 0:
		main_sprite.flip_h = false
	elif direction < 0:
		main_sprite.flip_h = true
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func change_size(size: String):
	current_size = size
	var data = size_values[size]
	main_collider.shape.size = Vector2(data[0],data[0])
	jump_velocity = data[1]
	delayed_speed_change(data[2])
	#print(asset_location + data[3] + "_test.png")
	main_sprite.texture = load(asset_location + data[3] + ".png")
	main_sprite.scale = Vector2(1, 1)
	if size == "medium":
		main_collider.shape.size =Vector2(data[0],data[0]/2.)
		#main_sprite.scale = Vector2(1, 0.5)

func delayed_speed_change(new_speed):
	if not is_on_floor():
		await landed
		#print("is now on floor")
	speed = new_speed
	
func reset_level():
	change_size("small")
	get_tree().reload_current_scene()

func attempt_grow():
	return current_state.grow()

func attempt_shrink():
	return current_state.shrink()
