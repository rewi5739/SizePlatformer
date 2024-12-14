extends CharacterStateMachine
class_name SizeCharacter

## Use to keep track of important values for each size.
## Collision size, Jump velocity (negative), speed, sprite location
@export var size_values : Dictionary = {"small"  : [28, -480, 300, "small"],
										"medium" : [60, -520, 250, "medium_huge"],
										"large"  : [60, -250, 200, "medium_huge"],
										"huge"   : [120, -370, 430, "huge"]}

@onready var main_sprite = $MainSprite
@onready var main_collider = $MainCollider
var asset_location = "res://tempAssets/"

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
	if Input.is_action_just_pressed("ui_accept") and (coyote_time>=0 or is_on_floor()) and not Globals.space_taken:
		jumping=true
		jumped.emit()
		velocity.y = jump_velocity

	if Input.is_action_just_pressed("shrink"):
		#print("input shrink action")
		attempt_shrink()
	
	if Input.is_action_just_pressed("grow"):
		#print("input grow action")
		attempt_grow()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
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
	main_sprite.texture = load(asset_location + data[3] + "_test.png")

func delayed_speed_change(new_speed):
	if not is_on_floor():
		await landed
		#print("is now on floor")
	speed = new_speed

func attempt_grow():
	return current_state.grow()

func attempt_shrink():
	return current_state.shrink()
