extends State

var large_state : State

func initialize():
	large_state = get_parent().get_node("Large")
	#print(medium_state)

func on_enter_state():
	body.change_size("huge")

func process_state(_delta):
	#print("")
	body.do_movement(_delta)

func grow():
	print("no Larger State")

func shrink():
	change_state.emit(large_state)
