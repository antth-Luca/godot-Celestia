extends BaseProperty
class_name UseSpeedProperty

const MAX_US: int = 3
var us: float
const MIN_US: float = 0.2


func _init(initial_value: float):
	set_use_speed(initial_value)

# Use Speed
func get_use_speed() -> float:
	return us


func get_format_use_speed() -> String:
	return str(us)


func set_use_speed(newUS: float) -> void:
	us = clamp(newUS, MIN_US, MAX_US)
