extends Node
class_name State

signal change_state(new_state : State)

var main_sprite: Sprite2D
var main_collider: CollisionShape2D
var body : CharacterStateMachine

func initialize():
	pass

func on_enter_state():
	pass

func on_exit_state():
	pass

func process_state(_delta : float):
	pass

func process_input(_event: InputEvent):
	pass
