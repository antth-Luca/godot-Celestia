extends BaseProperty
class_name ForceProperty

var fr: float
const MIN_FR: int = 0


func _init(initial_value: float):
	set_force(initial_value)

# Force
func get_force() -> float:
	return fr


func get_format_force() -> int:
	return ceil(fr)


func set_force(newFR: float) -> void:
	fr = max(newFR, MIN_FR)
