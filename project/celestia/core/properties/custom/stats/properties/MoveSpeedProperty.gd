extends BaseProperty
class_name MoveSpeedProperty

var ms: float
const MIN_MS: int = 0


func _init(initial_value: float):
	set_move_speed(initial_value)

# Move Speed
func get_move_speed() -> float:
	return ms


func get_format_move_speed() -> String:
	return str(ms)


func set_move_speed(newMS: float) -> void:
	ms = max(newMS, MIN_MS)
