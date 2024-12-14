extends State

var medium_state : State
var huge_state : State

func initialize():
	medium_state = get_parent().get_node("Medium")
	huge_state = get_parent().get_node("Huge")
	#print(small_state)

func on_enter_state():
	body.change_size("large")

func process_state(_delta):
	#print("")
	body.do_movement(_delta)

func grow():
	change_state.emit(huge_state)
	return true

func shrink():
	change_state.emit(medium_state)
	Globals.stationary_crates.emit()
	return true
