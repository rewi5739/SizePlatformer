extends State

var medium_state : State

func initialize():
	medium_state = get_parent().get_node("Medium")
	#print(medium_state)

func on_enter_state():
	body.change_size("small")

func process_state(_delta):
	#print("")
	body.do_movement(_delta)

func grow():
	change_state.emit(medium_state)
	return true

func shrink():
	print("no Smaller State")
	return false
