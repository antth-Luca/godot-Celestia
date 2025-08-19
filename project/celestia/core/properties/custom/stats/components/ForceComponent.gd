extends PropertyBaseComponent
class_name ForceComponent

var fr: float
const MIN_FR: int = 0

# Force
func get_force() -> float:
	return fr


func get_format_force() -> int:
	return ceil(fr)


func set_force(newFR: float) -> void:
	fr = max(newFR, MIN_FR)
