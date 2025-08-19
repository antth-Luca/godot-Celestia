extends BaseProperty
class_name RangeProperty

var rg: float
const MIN_RG: int = 1

# Range
func get_range() -> float:
	return rg


func set_range(newRG: float) -> void:
	rg = max(newRG, MIN_RG)
