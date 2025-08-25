extends BaseState
class_name IdleState

var left_time: float

# SUPER
func enter() -> void:
	get_randomize_time()


func update(delta: float) -> void:
	print(left_time)
	if left_time > 0:
		left_time -= delta
	else:
		get_randomize_time()

# MAIN
func get_randomize_time() -> void:
	left_time = randf_range(.5, 2)
