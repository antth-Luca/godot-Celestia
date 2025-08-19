extends BaseStatComponent
class_name MoveSpeedComponent

var ms: float
const MIN_MS: int = 0

# Move Speed
func get_move_speed() -> float:
	return ms


func set_move_speed(newMS: float) -> void:
	ms = max(newMS, MIN_MS)
