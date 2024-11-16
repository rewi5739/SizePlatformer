extends State

var small_state : State
var large_state : State

func initialize():
	small_state = get_parent().get_node("Small")
	large_state = get_parent().get_node("Large")
	#print(small_state)

func on_enter_state():
	body.change_size("medium")

func process_state(_delta):
	#print("")
	body.do_movement(_delta)

func grow():
	change_state.emit(large_state)

func shrink():
	change_state.emit(small_state)
