extends BaseStatComponent
class_name UseSpeedComponent

const MAX_US: int = 3
var us: float
const MIN_US: float = 0.2

# Use Speed
func get_use_speed() -> float:
	return us


func set_use_speed(newUS: float) -> void:
	us = clamp(newUS, MIN_US, MAX_US)
